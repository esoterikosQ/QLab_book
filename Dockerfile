FROM node:20-slim

WORKDIR /app

# 프로젝트 파일 복사
COPY package.json .
RUN npm install

# MyST 설치
RUN npm install -g mystmd

# 나머지 파일 복사
COPY . .

# CS 빌드
WORKDIR /app/cs
RUN myst build

# DS 빌드
WORKDIR /app/ds
RUN myst build

# 메인 디렉토리로 이동
WORKDIR /app

# 포트 설정
ENV PORT=8080
EXPOSE 8080

# 시작 스크립트
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
