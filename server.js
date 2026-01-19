const http = require('http');
const httpProxy = require('http-proxy');
const fs = require('fs');
const path = require('path');

const proxy = httpProxy.createProxyServer({ changeOrigin: true });
const PORT = process.env.PORT || 8080;

// 헬스체크: 백엔드 서버 상태 확인
function checkBackend(port, callback) {
  const req = http.request({ host: 'localhost', port: port, path: '/', timeout: 2000 }, (res) => {
    callback(true);
  });
  req.on('error', () => callback(false));
  req.on('timeout', () => { req.destroy(); callback(false); });
  req.end();
}

const server = http.createServer((req, res) => {
  const url = req.url;

  // 메인 페이지
  if (url === '/' || url === '/index.html') {
    const indexPath = path.join(__dirname, 'index.html');
    fs.readFile(indexPath, (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading index.html');
        return;
      }
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(data);
    });
    return;
  }

  // assets 폴더
  if (url.startsWith('/assets/')) {
    const filePath = path.join(__dirname, url);
    fs.readFile(filePath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('Not found');
        return;
      }
      res.writeHead(200);
      res.end(data);
    });
    return;
  }

  // CS 프록시
  if (url.startsWith('/cs')) {
    req.url = url.replace('/cs', '') || '/';
    proxy.web(req, res, { target: 'http://localhost:3001' }, (err) => {
      console.error('CS proxy error:', err.message);
      res.writeHead(502);
      res.end('CS server not ready');
    });
    return;
  }

  // DS 프록시
  if (url.startsWith('/ds')) {
    req.url = url.replace('/ds', '') || '/';
    proxy.web(req, res, { target: 'http://localhost:3002' }, (err) => {
      console.error('DS proxy error:', err.message);
      res.writeHead(502);
      res.end('DS server not ready');
    });
    return;
  }

  res.writeHead(404);
  res.end('Not found');
});

proxy.on('error', (err, req, res) => {
  console.error('Proxy error:', err);
  res.writeHead(502);
  res.end('Bad Gateway');
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
