#!/bin/bash

# 깃허브 업로드 자동화 스크립트
# 사용법: ./upload.sh [커밋메시지]
# 예: ./upload.sh "Add new content"

set -e

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 커밋 메시지 처리
COMMIT_MSG="${1:-Update content $(date +%Y-%m-%d\ %H:%M:%S)}"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}깃허브 업로드 시작${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 1. 현재 상태 확인
echo -e "${YELLOW}[1/4] 현재 상태 확인 중...${NC}"
git status
echo ""

# 2. 변경사항 확인
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}변경사항이 없습니다.${NC}"
    exit 0
fi

# 3. 모든 변경사항 스테이징
echo -e "${YELLOW}[2/4] 변경사항 스테이징 중...${NC}"
git add .
echo -e "${GREEN}✓ 파일 스테이징 완료${NC}"
echo ""

# 4. 커밋
echo -e "${YELLOW}[3/4] 변경사항 커밋 중...${NC}"
echo "커밋 메시지: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"
echo -e "${GREEN}✓ 커밋 완료${NC}"
echo ""

# 5. 푸시
echo -e "${YELLOW}[4/4] 푸시 중...${NC}"
git push origin master
echo -e "${GREEN}✓ 푸시 완료${NC}"
echo ""

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}깃허브 업로드 완료!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${BLUE}배포 상태 확인:${NC}"
echo "https://github.com/esoterikosQ/QLab_book/actions"
echo ""
