const express = require('express');
const router = express.Router();
const courseController = require('../controllers/courseController');

// Define course routes
router.get('/courses', courseController.getAllCourses);

module.exports = router;
