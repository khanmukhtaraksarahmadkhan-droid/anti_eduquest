const College = require('../models/collegeModel');

// Fetch all colleges
exports.getAllColleges = async (req, res) => {
  try {
    const colleges = await College.getAll();
    res.json(colleges);
  } catch (error) {
    console.error('Error fetching colleges:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Fetch single college details with courses and fees
exports.getCollegeById = async (req, res) => {
  try {
    const id = parseInt(req.params.id, 10);
    if (isNaN(id)) {
      return res.status(400).json({ error: 'Invalid college ID' });
    }

    const college = await College.getById(id);
    if (!college) {
      return res.status(404).json({ error: 'College not found' });
    }

    res.json(college);
  } catch (error) {
    console.error('Error fetching college details:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Search colleges with multi-filter support
// Accepts: q, type, ownership, state, city, university, naac, stream, approval
exports.searchColleges = async (req, res) => {
  try {
    const params = {
      q:          req.query.q          || '',
      type:       req.query.type       || '',
      ownership:  req.query.ownership  || '',
      state:      req.query.state      || '',
      city:       req.query.city       || '',
      university: req.query.university || '',
      naac:       req.query.naac       || '',
      stream:     req.query.stream     || '',
      approval:   req.query.approval   || ''
    };
    const results = await College.search(params);
    res.json(results);
  } catch (error) {
    console.error('Error searching colleges:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Fetch distinct states list
exports.getStates = async (req, res) => {
  try {
    const states = await College.getStates();
    res.json(states);
  } catch (error) {
    console.error('Error fetching states:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Fetch filter dropdown options
exports.getFilters = async (req, res) => {
  try {
    const filters = await College.getFilters();
    res.json(filters);
  } catch (error) {
    console.error('Error fetching filters:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Fetch counts for summary analytics
exports.getStats = async (req, res) => {
  try {
    const stats = await College.getStats();
    res.json(stats);
  } catch (error) {
    console.error('Error fetching stats:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
