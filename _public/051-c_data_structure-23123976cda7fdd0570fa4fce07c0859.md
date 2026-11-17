# 1.5.2. C/C++ 자료구조

## 1.5.2.1. C 배열과 포인터

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    // 배열
    int arr[5] = {1, 2, 3, 4, 5};
    
    // 포인터
    int *ptr = arr;
    printf("%d\n", *ptr);      // 1
    printf("%d\n", *(ptr+1));  // 2
    
    // 동적 할당
    int *dynamic = (int*)malloc(10 * sizeof(int));
    for (int i = 0; i < 10; i++) {
        dynamic[i] = i * 10;
    }
    free(dynamic);
    
    return 0;
}
```

## 1.5.2.2. C++ STL 컨테이너

```cpp
#include <vector>
#include <map>
#include <set>
#include <algorithm>

int main() {
    // vector
    std::vector<int> vec = {3, 1, 4, 1, 5};
    vec.push_back(9);
    vec.pop_back();
    
    // map
    std::map<std::string, int> ages;
    ages["Alice"] = 25;
    ages["Bob"] = 30;
    
    // set
    std::set<int> unique_nums = {1, 2, 2, 3, 3, 3};
    // unique_nums: {1, 2, 3}
    
    // 알고리즘
    std::sort(vec.begin(), vec.end());
    
    return 0;
}
```
