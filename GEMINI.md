## Overview

이 프로젝트는 computer science, data science에 관한 자료를 주제별로 작성해서 주피터 북 프로젝트로 묶고, 이 주피터 북을 온라인 상에서 접속할 수 있도록 제공하기 위한 프로젝트입니다. 디렉토리 구조는 다음과 같습니다.

/book(깃허브 레포)
├── .github/
│   └── workflows/
│       └── deploy.yml        <-- 통합 배포 스크립트
├── index.html                <-- 메인 페이지 (CS/DS 선택 버튼)
├── assets/                   <-- 메인 페이지용 이미지 등
├── myst.yml              <-- 메인 페이지용 myst 설정
├── cs/                       <-- Computer Science 주피터북
│   ├── myst.yml                <-- Computer Science 주피터북 설정
│   ├── intro.md
│   └── ... (교재 내용)
└── ds/                       <-- Data Science 주피터북
    ├── myst.yml                <-- Data Science 주피터북 설정
    ├── intro.md
    └── ... (교재 내용)

## 주피터 북

각각의 주피터 북은 별도의 프로젝트로 관리됨. 각 프로젝트와 관련된 자료를 생성해서 디렉토리에 추가할 예정

로컬 환경에서 주피터 북 패키지는 conda activate jbook에 설치된 2.1.0 버전을 사용

## 배포

전체 프로젝트는 깃허브+GCP를 통해 배포됨. 새로운 자료를 추가할 때마다 깃허브에 푸시하고, 이와 연동된 GCP에 자동으로 배포

## 도메인

개인 도메인인 book.qlab.science를 통해 GCP 배포 사이트에 접속 예정. 각각의 하위 주피터북은 서브 도메인으로 구분(/cs, /ds)