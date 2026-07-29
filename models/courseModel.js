const db = require('../config/db');

const Course = {
  // Get all courses
  getAll: async () => {
    const [rows] = await db.query('SELECT * FROM courses ORDER BY stream, course_name');
    return rows;
  }
};

module.exports = Course;
