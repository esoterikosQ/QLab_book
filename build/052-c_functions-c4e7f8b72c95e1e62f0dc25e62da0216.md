# 1.5.3. C/C++ 함수

## 1.5.3.1. C 함수

```c
#include <stdio.h>

// 함수 선언
int add(int a, int b);

// 함수 정의
int add(int a, int b) {
    return a + b;
}

// 포인터 인자
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    int x = 10, y = 20;
    swap(&x, &y);
    printf("x = %d, y = %d\n", x, y);
    return 0;
}
```

## 1.5.3.2. C++ 함수

```cpp
#include <iostream>
#include <vector>

// 함수 오버로딩
int add(int a, int b) {
    return a + b;
}

double add(double a, double b) {
    return a + b;
}

// 템플릿
template<typename T>
T maximum(T a, T b) {
    return (a > b) ? a : b;
}

// 람다
int main() {
    auto multiply = [](int a, int b) { return a * b; };
    std::cout << multiply(3, 4) << std::endl;
    
    return 0;
}
```
