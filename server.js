const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

// Import routes
const collegeRoutes = require('./routes/collegeRoutes');
const courseRoutes = require('./routes/courseRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Enable Cross-Origin Resource Sharing
app.use(cors());

// Parse JSON and URLEncoded bodies
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static assets from public folder
app.use(express.static(path.join(__dirname, 'public')));

// Setup API routes
app.use('/api', collegeRoutes);
app.use('/api', courseRoutes);

// Catch-all route for unmatched API requests
app.use('/api/*', (req, res) => {
  res.status(404).json({ error: 'API route not found' });
});

// Fallback route for client side page transitions
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Global error handling middleware
app.use((err, req, res, next) => {
  console.error('Server error stack:', err.stack);
  res.status(500).json({
    error: 'Internal server error',
    message: err.message
  });
});

// Bind port and start Express server
const server = app.listen(PORT, () => {
  console.log(`==================================================`);
  console.log(`EduQuest Server is active on Port: ${PORT}`);
  console.log(`Local web portal URL: http://localhost:${PORT}`);
  console.log(`==================================================`);
});

server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.error(`\n✗ Port ${PORT} is already in use.`);
    console.error(`  Run this command to free it, then try again:`);
    console.error(`  netstat -ano | findstr :${PORT}  →  taskkill /PID <PID> /F\n`);
    process.exit(1);
  } else {
    throw err;
  }
});

