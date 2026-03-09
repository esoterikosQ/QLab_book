FROM node:20-slim

WORKDIR /app

# 프로젝트 파일 복사
COPY package.json .
RUN npm install

# MyST 설치
RUN npm install -g mystmd

# 나머지 파일 복사
COPY . .

# MyST 빌드
RUN myst build

# 포트 설정 - 0.0.0.0에 바인딩해야 Cloud Run에서 접근 가능
ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE 8080

# MyST 서버 실행 (포트 8080, Cloud Run 호환)
CMD ["myst", "start", "--keep-host", "--port", "8080"]
