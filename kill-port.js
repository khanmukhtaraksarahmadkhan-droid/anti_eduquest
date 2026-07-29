// kill-port.js — kills any process holding port 3000 before starting dev server
const { execSync } = require('child_process');
const PORT = process.env.PORT || 3000;

try {
  // Find PID using netstat
  const result = execSync(
    `netstat -ano | findstr :${PORT} | findstr LISTENING`,
    { encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] }
  );

  const match = result.match(/\s+(\d+)\s*$/m);
  if (match) {
    const pid = match[1].trim();
    execSync(`taskkill /PID ${pid} /F`, { stdio: 'ignore' });
    console.log(`✓ Freed port ${PORT} (killed PID ${pid})`);
  }
} catch (e) {
  // Port is free — nothing to kill, just continue
}
process.exit(0);
