const http = require('http');

const PORT = process.env.PORT || 8080;
const APP_NAME = process.env.APP_NAME || 'cpln-test';
const DB_HOST = process.env.DATABASE_URL || 'not-configured';

const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok', app: APP_NAME }));
    return;
  }

  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    message: `Hello from ${APP_NAME}`,
    env: process.env.NODE_ENV || 'development',
    db_configured: DB_HOST !== 'not-configured',
    timestamp: new Date().toISOString()
  }));
});

server.listen(PORT, () => {
  console.log(`${APP_NAME} listening on port ${PORT}`);
});
