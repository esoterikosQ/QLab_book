# 1.5.5. C/C++ 라이브러리 관리

## 1.5.5.1. 헤더와 라이브러리

```cpp
// mylib.h
#ifndef MYLIB_H
#define MYLIB_H

int add(int a, int b);

#endif

// mylib.cpp
#include "mylib.h"

int add(int a, int b) {
    return a + b;
}

// main.cpp
#include "mylib.h"
#include <iostream>

int main() {
    std::cout << add(3, 4) << std::endl;
    return 0;
}
```

## 1.5.5.2. CMake

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
project(MyProject)

set(CMAKE_CXX_STANDARD 20)

add_executable(myapp main.cpp mylib.cpp)

# 외부 라이브러리
find_package(Boost REQUIRED)
target_link_libraries(myapp Boost::boost)
```

```bash
# 빌드
mkdir build
cd build
cmake ..
make
./myapp
```

## 1.5.5.3. 유용한 라이브러리 (Ubuntu 24.04)

```bash
# Boost
sudo apt install -y libboost-all-dev

# Eigen (선형대수)
sudo apt install -y libeigen3-dev

# OpenCV (컴퓨터 비전)
sudo apt install -y libopencv-dev

# 사용 예제
#include <Eigen/Dense>
#include <iostream>

int main() {
    Eigen::MatrixXd m(2,2);
    m(0,0) = 3;
    m(1,0) = 2.5;
    m(0,1) = -1;
    m(1,1) = m(1,0) + m(0,1);
    std::cout << m << std::endl;
}
```
