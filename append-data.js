const fs = require('fs');
const mysql = require('mysql2/promise');
require('dotenv').config();

async function run() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'm@1234',
    database: process.env.DB_NAME || 'eduquest'
  });

  const [colleges] = await connection.query('SELECT * FROM colleges');
  const [courses] = await connection.query('SELECT * FROM courses');

  let collegeSql = `
-- ============================================================
-- MORE MAHARASHTRA COLLEGES
-- ============================================================
INSERT INTO \`colleges\` (\`college_name\`,\`institution_type\`,\`ownership\`,\`state\`,\`city\`,\`address\`,\`pincode\`,\`college_type\`,\`university\`,\`established_year\`,\`naac_grade\`,\`aicte_approved\`,\`approvals\`,\`streams\`,\`website\`,\`email\`,\`phone\`,\`logo\`,\`description\`) VALUES
('Vidyalankar Polytechnic', 'Polytechnic College', 'Private', 'Maharashtra', 'Mumbai', 'Vidyalankar Educational Campus, Wadala East', '400037', 'Private', 'MSBTE', 2002, 'N/A', 1, 'AICTE, DTE', 'Polytechnic,Engineering', 'https://vpt.edu.in', 'principal@vpt.edu.in', '+91-22-24161126', 'VPT', 'A premier polytechnic college in Mumbai offering various diploma engineering courses with excellent infrastructure.'),
('M.H. Saboo Siddik Polytechnic', 'Polytechnic College', 'Private', 'Maharashtra', 'Mumbai', '8, Saboo Siddik Polytechnic Road, Byculla', '400008', 'Private', 'MSBTE', 1958, 'N/A', 1, 'AICTE, DTE', 'Polytechnic,Engineering', 'https://mhssp.org', 'principal@mhssp.org', '+91-22-23080616', 'MHSSP', 'A historic and highly reputed polytechnic institution in South Mumbai providing quality technical education.');
`;

  // We will insert these manually first to get their IDs
  await connection.query(`
    INSERT INTO \`colleges\` (\`college_name\`,\`institution_type\`,\`ownership\`,\`state\`,\`city\`,\`address\`,\`pincode\`,\`college_type\`,\`university\`,\`established_year\`,\`naac_grade\`,\`aicte_approved\`,\`approvals\`,\`streams\`,\`website\`,\`email\`,\`phone\`,\`logo\`,\`description\`) VALUES
    ('Vidyalankar Polytechnic', 'Polytechnic College', 'Private', 'Maharashtra', 'Mumbai', 'Vidyalankar Educational Campus, Wadala East', '400037', 'Private', 'MSBTE', 2002, 'N/A', 1, 'AICTE, DTE', 'Polytechnic,Engineering', 'https://vpt.edu.in', 'principal@vpt.edu.in', '+91-22-24161126', 'VPT', 'A premier polytechnic college in Mumbai offering various diploma engineering courses with excellent infrastructure.'),
    ('M.H. Saboo Siddik Polytechnic', 'Polytechnic College', 'Private', 'Maharashtra', 'Mumbai', '8, Saboo Siddik Polytechnic Road, Byculla', '400008', 'Private', 'MSBTE', 1958, 'N/A', 1, 'AICTE, DTE', 'Polytechnic,Engineering', 'https://mhssp.org', 'principal@mhssp.org', '+91-22-23080616', 'MHSSP', 'A historic and highly reputed polytechnic institution in South Mumbai providing quality technical education.')
  `);

  const [newColleges] = await connection.query('SELECT * FROM colleges');

  let collegeCoursesSql = `\n-- ============================================================\n-- COLLEGE COURSES DATA (Junction Table)\n-- ============================================================\nLOCK TABLES \`college_courses\` WRITE;\nINSERT INTO \`college_courses\` (\`college_id\`, \`course_id\`, \`fees\`) VALUES\n`;
  
  let values = [];
  let inserts = [];

  for (const college of newColleges) {
    // Determine which courses this college should have based on its streams or type
    let applicableCourses = [];
    
    if (college.institution_type.includes('Polytechnic')) {
      applicableCourses = courses.filter(c => c.stream === 'Polytechnic');
    } else if (college.institution_type.includes('Medical')) {
      applicableCourses = courses.filter(c => c.stream === 'Medical' || c.stream === 'Nursing');
    } else if (college.institution_type.includes('Pharmacy')) {
      applicableCourses = courses.filter(c => c.stream === 'Pharmacy');
    } else if (college.institution_type.includes('Law')) {
      applicableCourses = courses.filter(c => c.stream === 'Law');
    } else if (college.institution_type.includes('Architecture')) {
      applicableCourses = courses.filter(c => c.stream === 'Architecture');
    } else if (college.institution_type.includes('Agriculture')) {
      applicableCourses = courses.filter(c => c.stream === 'Agriculture');
    } else if (college.institution_type.includes('Management')) {
      applicableCourses = courses.filter(c => c.stream === 'Management');
    } else if (college.institution_type.includes('Engineering')) {
      applicableCourses = courses.filter(c => c.stream === 'Engineering' || c.stream === 'Computer Science' || c.stream === 'Information Technology');
    } else {
      // Degree colleges, etc.
      applicableCourses = courses.filter(c => c.stream === 'Science' || c.stream === 'Commerce' || c.stream === 'Arts');
    }

    // Assign 3-8 random courses from the applicable pool
    if (applicableCourses.length > 0) {
      // Shuffle
      applicableCourses.sort(() => 0.5 - Math.random());
      const numCourses = Math.min(Math.floor(Math.random() * 5) + 3, applicableCourses.length);
      const selected = applicableCourses.slice(0, numCourses);

      for (const course of selected) {
        let fee = Math.floor(Math.random() * 90) * 1000 + 10000; // Random fee between 10k and 100k
        if (course.stream === 'Medical') fee *= 5; // Med is expensive
        if (course.stream === 'Engineering') fee *= 1.5;

        values.push(`(${college.id}, ${course.id}, ${fee})`);
        inserts.push([college.id, course.id, fee]);
      }
    }
  }

  collegeCoursesSql += values.join(',\\n') + ';\\nUNLOCK TABLES;\\n';

  // Append to eduquest.sql
  const sqlFilePath = './database/eduquest.sql';
  let sqlContent = fs.readFileSync(sqlFilePath, 'utf8');
  sqlContent += collegeSql;
  sqlContent += collegeCoursesSql.replace(/\\n/g, '\n');
  fs.writeFileSync(sqlFilePath, sqlContent);

  // Also insert directly into DB to fix it now without full import
  for (const row of inserts) {
    await connection.query('INSERT INTO college_courses (college_id, course_id, fees) VALUES (?, ?, ?)', row);
  }

  console.log('Successfully appended polytechnic colleges and generated college_courses data.');
  process.exit(0);
}

run().catch(console.error);
