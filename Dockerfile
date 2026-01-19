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

# 포트 설정 (MyST headless 기본 포트 3100 사용)
# HOST=0.0.0.0으로 설정해야 Cloud Run에서 외부 접근 가능
ENV PORT=3100
ENV HOST=0.0.0.0
EXPOSE 3100

# MyST 서버 직접 실행 (--keep-host로 HOST 환경변수 사용)
CMD ["myst", "start", "--headless", "--keep-host"]
