# 1.5.1. C/C++ 소개

C/C++는 시스템 프로그래밍과 고성능 컴퓨팅에 사용되는 저수준 언어입니다.

## 1.5.1.1. 설치 (Ubuntu 24.04)

```bash
# GCC/G++ 설치
sudo apt update
sudo apt install -y build-essential gdb

# 버전 확인
gcc --version   # gcc (Ubuntu 13.2.0) 
g++ --version   # g++ (Ubuntu 13.2.0)

# CMake 설치
sudo apt install -y cmake

# 추가 도구
sudo apt install -y valgrind  # 메모리 검사
sudo apt install -y clang clang-format  # 대체 컴파일러
```

## 1.5.1.2. 기본 문법 (C)

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    // 변수
    int x = 42;
    float y = 3.14;
    char c = 'A';
    char str[] = "Hello";
    
    // 출력
    printf("x = %d\n", x);
    printf("y = %.2f\n", y);
    printf("c = %c\n", c);
    printf("str = %s\n", str);
    
    // 조건문
    if (x > 0) {
        printf("Positive\n");
    } else if (x < 0) {
        printf("Negative\n");
    } else {
        printf("Zero\n");
    }
    
    // 반복문
    for (int i = 0; i < 5; i++) {
        printf("%d ", i);
    }
    printf("\n");
    
    return 0;
}
```

## 1.5.1.3. 컴파일 및 실행

```bash
# C 컴파일
gcc program.c -o program
./program

# 최적화
gcc -O2 program.c -o program

# 디버그 정보 포함
gcc -g program.c -o program
gdb ./program

# 경고 활성화
gcc -Wall -Wextra program.c -o program

# C++ 컴파일
g++ program.cpp -o program -std=c++20
```

## 1.5.1.4. C++ 기본

```cpp
#include <iostream>
#include <vector>
#include <string>

int main() {
    // auto 타입 추론
    auto x = 42;
    
    // 벡터
    std::vector<int> nums = {1, 2, 3, 4, 5};
    
    // Range-based for loop
    for (const auto& num : nums) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // 문자열
    std::string name = "Alice";
    std::cout << "Hello, " << name << std::endl;
    
    return 0;
}
```
