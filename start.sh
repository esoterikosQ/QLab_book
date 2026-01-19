#!/bin/bash

# CS 서버 시작 (백그라운드)
cd /app/cs && myst start --headless --port 3001 &

# DS 서버 시작 (백그라운드)
cd /app/ds && myst start --headless --port 3002 &

# 서버들이 시작될 때까지 대기
echo "Waiting for MyST servers to start..."
sleep 10

# 프록시 서버 시작
cd /app && node server.js
