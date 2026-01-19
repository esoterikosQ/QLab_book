FROM node:20-slim

WORKDIR /app

# 프로젝트 파일 복사
COPY package.json .
RUN npm install

# MyST 설치
RUN npm install -g mystmd

# 나머지 파일 복사
COPY . .

# 루트에서 빌드 (cs, ds 모두 포함)
RUN myst build

# 포트 설정 (headless 모드는 content server만 실행하므로 SERVER_PORT 사용)
ENV SERVER_PORT=8080
EXPOSE 8080

# MyST 서버 직접 실행 (headless = content server only)
CMD ["myst", "start", "--headless", "--server-port", "8080"]
