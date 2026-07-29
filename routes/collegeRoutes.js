const express = require('express');
const router = express.Router();
const collegeController = require('../controllers/collegeController');

// Define college routes
router.get('/colleges',       collegeController.getAllColleges);
router.get('/colleges/:id',   collegeController.getCollegeById);
router.get('/search',         collegeController.searchColleges);
router.get('/states',         collegeController.getStates);
router.get('/filters',        collegeController.getFilters);
router.get('/stats',          collegeController.getStats);

module.exports = router;
