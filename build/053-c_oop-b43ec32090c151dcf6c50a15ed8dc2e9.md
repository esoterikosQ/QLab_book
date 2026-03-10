# 1.5.4. C++ 객체지향 프로그래밍

## 1.5.4.1. 클래스 기초

```cpp
#include <iostream>
#include <string>

class Person {
private:
    std::string name;
    int age;

public:
    // 생성자
    Person(std::string n, int a) : name(n), age(a) {}
    
    // 멤버 함수
    void greet() {
        std::cout << "Hello, I'm " << name << std::endl;
    }
    
    // Getter/Setter
    int getAge() const { return age; }
    void setAge(int a) { age = a; }
};

int main() {
    Person alice("Alice", 25);
    alice.greet();
    return 0;
}
```

## 1.5.4.2. 상속과 다형성

```cpp
class Shape {
public:
    virtual double area() const = 0;  // 순수 가상 함수
    virtual ~Shape() {}
};

class Circle : public Shape {
private:
    double radius;
public:
    Circle(double r) : radius(r) {}
    double area() const override {
        return 3.14159 * radius * radius;
    }
};

class Rectangle : public Shape {
private:
    double width, height;
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    double area() const override {
        return width * height;
    }
};
```
