const db = require('../config/db');

// Utility to sanitize and fix college records (e.g. website URLs)
function sanitizeCollege(college) {
  if (!college) return college;

  let name = (college.college_name || '').trim();
  let rawWeb = (college.website || '').trim();

  // Explicit override for Vidyalankar Polytechnic Wadala
  if (name.toLowerCase().includes('vidyalankar polytechnic')) {
    if (!rawWeb || rawWeb.includes('vpmthane') || rawWeb === 'N/A' || rawWeb === '#') {
      college.website = 'https://vpt.edu.in';
      return college;
    }
  }

  // Ensure clean website URL format
  if (rawWeb && rawWeb !== 'N/A' && rawWeb !== '#' && rawWeb !== 'undefined' && rawWeb !== 'null') {
    college.website = /^https?:\/\//i.test(rawWeb) ? rawWeb : `https://${rawWeb}`;
  } else {
    college.website = null;
  }

  return college;
}

const College = {
  // Get all colleges (basic listing, ordered by name)
  getAll: async () => {
    const [rows] = await db.query('SELECT * FROM colleges ORDER BY college_name');
    return rows.map(sanitizeCollege);
  },

  // Get single college details with courses offered
  getById: async (id) => {
    const [colleges] = await db.query('SELECT * FROM colleges WHERE id = ?', [id]);
    if (colleges.length === 0) return null;

    const college = sanitizeCollege(colleges[0]);

    // Fetch courses mapped to this college along with fees
    const [courses] = await db.query(`
      SELECT c.id AS course_id, c.course_name, c.duration, c.eligibility, c.stream, cc.fees
      FROM college_courses cc
      JOIN courses c ON cc.course_id = c.id
      WHERE cc.college_id = ?
      ORDER BY c.stream ASC, c.course_name ASC
    `, [id]);

    college.courses = courses;
    return college;
  },

  // Advanced search with multi-filter support
  search: async (params) => {
    const { q, courseId, course, type, ownership, state, city, university, naac, stream, approval } = params;

    let conditions = [];
    let values = [];

    // Filter: Specific Course ID (via college_courses junction table)
    if (courseId && !isNaN(parseInt(courseId, 10))) {
      conditions.push('cc.course_id = ?');
      values.push(parseInt(courseId, 10));
    }

    // Filter: Specific Course Name or Keyword
    if (course && course.trim() !== '') {
      conditions.push('(c.course_name LIKE ? OR c.stream LIKE ? OR col.streams LIKE ?)');
      const cTerm = `%${course.trim()}%`;
      values.push(cTerm, cTerm, cTerm);
    }

    // Base text search across key fields
    if (q && q.trim() !== '') {
      const term = `%${q.trim()}%`;
      conditions.push(`(
        col.college_name       LIKE ? OR
        col.city               LIKE ? OR
        col.state              LIKE ? OR
        col.university         LIKE ? OR
        col.institution_type   LIKE ? OR
        col.streams            LIKE ? OR
        c.course_name          LIKE ? OR
        c.stream               LIKE ?
      )`);
      values.push(term, term, term, term, term, term, term, term);
    }

    // Filter: Institution Type
    if (type && type.trim() !== '') {
      conditions.push('col.institution_type LIKE ?');
      values.push(`%${type.trim()}%`);
    }

    // Filter: Ownership (Government / Private / Aided)
    if (ownership && ownership.trim() !== '') {
      conditions.push('col.ownership = ?');
      values.push(ownership.trim());
    }

    // Filter: State
    if (state && state.trim() !== '') {
      conditions.push('col.state = ?');
      values.push(state.trim());
    }

    // Filter: City
    if (city && city.trim() !== '') {
      conditions.push('col.city LIKE ?');
      values.push(`%${city.trim()}%`);
    }

    // Filter: Affiliated University
    if (university && university.trim() !== '') {
      conditions.push('col.university LIKE ?');
      values.push(`%${university.trim()}%`);
    }

    // Filter: NAAC Grade
    if (naac && naac.trim() !== '') {
      conditions.push('col.naac_grade = ?');
      values.push(naac.trim());
    }

    // Filter: Stream (checks the streams column)
    if (stream && stream.trim() !== '') {
      conditions.push('(col.streams LIKE ? OR c.stream LIKE ?)');
      values.push(`%${stream.trim()}%`, `%${stream.trim()}%`);
    }

    // Filter: Approval body (checks approvals column)
    if (approval && approval.trim() !== '') {
      conditions.push('col.approvals LIKE ?');
      values.push(`%${approval.trim()}%`);
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    const [rows] = await db.query(`
      SELECT DISTINCT col.*
      FROM colleges col
      LEFT JOIN college_courses cc ON col.id = cc.college_id
      LEFT JOIN courses c ON cc.course_id = c.id
      ${whereClause}
      ORDER BY col.college_name
      LIMIT 200
    `, values);

    return rows.map(sanitizeCollege);
  },

  // Get list of distinct states
  getStates: async () => {
    const [rows] = await db.query('SELECT DISTINCT state FROM colleges ORDER BY state');
    return rows.map(row => row.state);
  },

  // Get all distinct filter values for dropdowns
  getFilters: async () => {
    const [types]      = await db.query('SELECT DISTINCT institution_type FROM colleges WHERE institution_type IS NOT NULL ORDER BY institution_type');
    const [ownerships] = await db.query('SELECT DISTINCT ownership FROM colleges WHERE ownership IS NOT NULL ORDER BY ownership');
    const [states]     = await db.query('SELECT DISTINCT state FROM colleges ORDER BY state');
    const [naacs]      = await db.query("SELECT DISTINCT naac_grade FROM colleges WHERE naac_grade IS NOT NULL AND naac_grade != 'N/A' ORDER BY naac_grade");
    const [streamRows] = await db.query('SELECT DISTINCT stream FROM courses WHERE stream IS NOT NULL ORDER BY stream');

    return {
      institution_types: types.map(r => r.institution_type),
      ownerships:        ownerships.map(r => r.ownership),
      states:            states.map(r => r.state),
      naac_grades:       naacs.map(r => r.naac_grade),
      streams:           streamRows.map(r => r.stream)
    };
  },

  // Get metrics for counts
  getStats: async () => {
    const [[{ college_count }]] = await db.query('SELECT COUNT(*) AS college_count FROM colleges');
    const [[{ course_count }]]  = await db.query('SELECT COUNT(*) AS course_count FROM courses');
    const [[{ state_count }]]   = await db.query('SELECT COUNT(DISTINCT state) AS state_count FROM colleges');
    return {
      colleges: college_count,
      courses:  course_count,
      states:   state_count
    };
  }
};

module.exports = College;
