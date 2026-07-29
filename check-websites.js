const db = require('./config/db');
const fs = require('fs');

async function checkUrl(urlStr) {
  if (!urlStr || urlStr.trim() === '') return { status: 'Empty' };
  
  let url = urlStr;
  if (!url.startsWith('http')) url = 'http://' + url;

  try {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 6000); // 6 sec timeout
    
    const response = await fetch(url, { 
      method: 'GET', // Using GET because some servers reject HEAD requests
      signal: controller.signal,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
      }
    });
    
    clearTimeout(timeoutId);
    
    if (response.ok) {
      return { status: response.status };
    } else {
      return { status: response.status };
    }
  } catch (error) {
    if (error.name === 'AbortError') {
      return { status: 'Timeout' };
    }
    return { status: 'Error: ' + error.message };
  }
}

async function run() {
  console.log('Fetching all colleges...');
  const [rows] = await db.query('SELECT id, college_name, website FROM colleges');
  
  console.log(`Found ${rows.length} colleges. Checking websites in batches...`);
  
  const broken = [];
  
  const BATCH_SIZE = 25;
  for (let i = 0; i < rows.length; i += BATCH_SIZE) {
    const batch = rows.slice(i, i + BATCH_SIZE);
    process.stdout.write(`Checking batch ${Math.floor(i/BATCH_SIZE) + 1} / ${Math.ceil(rows.length/BATCH_SIZE)}...\r`);
    
    const results = await Promise.all(batch.map(async (row) => {
      const res = await checkUrl(row.website);
      return { ...row, result: res };
    }));
    
    for (const item of results) {
      if (item.result.status === 'Empty' || 
         (typeof item.result.status === 'number' && item.result.status >= 400) ||
         (typeof item.result.status === 'string' && (item.result.status.startsWith('Error') || item.result.status === 'Timeout'))) {
        broken.push(item);
      }
    }
  }
  
  console.log(`\n\nFound ${broken.length} broken/unreachable websites out of ${rows.length}.`);
  let logContent = `Found ${broken.length} broken/unreachable websites:\n\n`;
  broken.forEach(b => {
    logContent += `ID: ${b.id}\nName: ${b.college_name}\nURL: ${b.website}\nStatus: ${b.result.status}\n---\n`;
  });
  
  fs.writeFileSync('broken-websites.log', logContent);
  console.log('Results saved to broken-websites.log');
  process.exit(0);
}

run();
