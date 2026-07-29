const db = require('./config/db');
const fs = require('fs');

async function fixBrokenLinks() {
  try {
    const logData = fs.readFileSync('broken-websites.log', 'utf8');
    
    // Extract IDs using regex
    const idMatches = [...logData.matchAll(/^ID: (\d+)$/gm)];
    const ids = idMatches.map(m => parseInt(m[1], 10));
    
    if (ids.length === 0) {
      console.log('No broken IDs found in log.');
      process.exit(0);
    }
    
    console.log(`Found ${ids.length} broken websites. Updating database...`);
    
    // Create placeholders for the IN clause
    const placeholders = ids.map(() => '?').join(',');
    
    // Update the database, setting website to NULL for the broken ones
    const [result] = await db.query(
      `UPDATE colleges SET website = NULL WHERE id IN (${placeholders})`,
      ids
    );
    
    console.log(`Database updated successfully! ${result.affectedRows} records modified.`);
    process.exit(0);
  } catch (error) {
    console.error('Failed to update broken links:', error);
    process.exit(1);
  }
}

fixBrokenLinks();
