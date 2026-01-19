#!/bin/bash

# CS와 DS 서버를 동시에 실행하고, nginx로 프록시
# 간단한 방식: 하나의 서버만 실행하고 index.html에서 링크

cd /app/cs && myst start --headless --port 3001 &
cd /app/ds && myst start --headless --port 3002 &

# 간단한 프록시 서버 (Node.js)
node /app/server.js
