# 1.3.4. Python 객체지향 프로그래밍 (OOP)

객체지향 프로그래밍은 데이터와 함수를 하나의 단위로 묶어 관리하는 프로그래밍 패러다임입니다.

## 1.3.4.1. 클래스와 객체

```python
# 기본 클래스 정의
class Dog:
    # 클래스 변수 (모든 인스턴스가 공유)
    species = "Canis familiaris"
    
    def __init__(self, name, age):
        # 인스턴스 변수
        self.name = name
        self.age = age
    
    def bark(self):
        return f"{self.name}이(가) 짖습니다!"
    
    def get_info(self):
        return f"{self.name}는 {self.age}살입니다."

# 객체 생성
dog1 = Dog("멍멍이", 3)
dog2 = Dog("바둑이", 5)

print(dog1.bark())      # 멍멍이이(가) 짖습니다!
print(dog1.get_info())  # 멍멍이는 3살입니다.
print(dog1.species)     # Canis familiaris
```

## 1.3.4.2. 캡슐화

```python
class BankAccount:
    def __init__(self, owner, balance=0):
        self.owner = owner        # public
        self._account_number = self._generate_account_number()  # protected (_)
        self.__balance = balance  # private (__)
    
    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount
            return True
        return False
    
    def withdraw(self, amount):
        if 0 < amount <= self.__balance:
            self.__balance -= amount
            return True
        return False
    
    def get_balance(self):
        return self.__balance
    
    @staticmethod
    def _generate_account_number():
        import random
        return f"{random.randint(100000, 999999)}"
    
    def __str__(self):
        return f"Account({self.owner}, Balance: {self.__balance})"

account = BankAccount("Alice", 1000)
account.deposit(500)
print(account.get_balance())  # 1500
# print(account.__balance)    # AttributeError (private)
print(account._BankAccount__balance)  # 1500 (name mangling으로 접근 가능)
```

## 1.3.4.3. 상속

```python
# 기본 상속
class Animal:
    def __init__(self, name):
        self.name = name
    
    def speak(self):
        raise NotImplementedError("Subclass must implement speak()")

class Dog(Animal):
    def speak(self):
        return f"{self.name}이(가) 멍멍!"

class Cat(Animal):
    def speak(self):
        return f"{self.name}이(가) 야옹!"

dog = Dog("멍멍이")
cat = Cat("나비")
print(dog.speak())  # 멍멍이이(가) 멍멍!
print(cat.speak())  # 나비이(가) 야옹!

# super()로 부모 클래스 호출
class Employee:
    def __init__(self, name, salary):
        self.name = name
        self.salary = salary
    
    def get_info(self):
        return f"{self.name}: {self.salary}원"

class Manager(Employee):
    def __init__(self, name, salary, department):
        super().__init__(name, salary)
        self.department = department
    
    def get_info(self):
        base_info = super().get_info()
        return f"{base_info}, 부서: {self.department}"

manager = Manager("김철수", 5000000, "개발팀")
print(manager.get_info())  # 김철수: 5000000원, 부서: 개발팀

# 다중 상속
class Flyable:
    def fly(self):
        return "날아갑니다!"

class Swimmable:
    def swim(self):
        return "수영합니다!"

class Duck(Animal, Flyable, Swimmable):
    def speak(self):
        return f"{self.name}이(가) 꽥꽥!"

duck = Duck("도날드")
print(duck.speak())  # 도날드이(가) 꽥꽥!
print(duck.fly())    # 날아갑니다!
print(duck.swim())   # 수영합니다!

# MRO (Method Resolution Order) 확인
print(Duck.__mro__)
```

## 1.3.4.4. 다형성

```python
class Shape:
    def area(self):
        raise NotImplementedError

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height
    
    def area(self):
        return self.width * self.height

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius
    
    def area(self):
        import math
        return math.pi * (self.radius ** 2)

# 다형성: 같은 메서드로 다른 동작
shapes = [Rectangle(4, 5), Circle(3), Rectangle(2, 8)]
for shape in shapes:
    print(f"면적: {shape.area():.2f}")
```

## 1.3.4.5. 특수 메서드 (Magic Methods)

```python
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def __repr__(self):
        """개발자용 표현 (디버깅)"""
        return f"Vector({self.x}, {self.y})"
    
    def __str__(self):
        """사용자용 표현"""
        return f"({self.x}, {self.y})"
    
    def __add__(self, other):
        """+ 연산자"""
        return Vector(self.x + other.x, self.y + other.y)
    
    def __sub__(self, other):
        """- 연산자"""
        return Vector(self.x - other.x, self.y - other.y)
    
    def __mul__(self, scalar):
        """* 연산자 (스칼라 곱)"""
        return Vector(self.x * scalar, self.y * scalar)
    
    def __eq__(self, other):
        """== 연산자"""
        return self.x == other.x and self.y == other.y
    
    def __len__(self):
        """len() 함수"""
        import math
        return int(math.sqrt(self.x**2 + self.y**2))
    
    def __getitem__(self, index):
        """인덱싱"""
        if index == 0:
            return self.x
        elif index == 1:
            return self.y
        else:
            raise IndexError("Index out of range")

v1 = Vector(2, 3)
v2 = Vector(1, 4)
print(v1 + v2)    # (3, 7)
print(v1 * 3)     # (6, 9)
print(v1 == v2)   # False
print(len(v1))    # 3
print(v1[0])      # 2
```

## 1.3.4.6. 프로퍼티 (Property)

```python
class Temperature:
    def __init__(self, celsius):
        self._celsius = celsius
    
    @property
    def celsius(self):
        """Getter"""
        return self._celsius
    
    @celsius.setter
    def celsius(self, value):
        """Setter"""
        if value < -273.15:
            raise ValueError("절대영도 이하는 불가능합니다")
        self._celsius = value
    
    @property
    def fahrenheit(self):
        """자동 계산 프로퍼티"""
        return (self._celsius * 9/5) + 32
    
    @fahrenheit.setter
    def fahrenheit(self, value):
        self._celsius = (value - 32) * 5/9

temp = Temperature(25)
print(temp.celsius)      # 25
print(temp.fahrenheit)   # 77.0

temp.fahrenheit = 86
print(temp.celsius)      # 30.0

# 읽기 전용 프로퍼티
class Circle:
    def __init__(self, radius):
        self._radius = radius
    
    @property
    def radius(self):
        return self._radius
    
    @property
    def area(self):
        import math
        return math.pi * (self._radius ** 2)
    
    @property
    def circumference(self):
        import math
        return 2 * math.pi * self._radius

circle = Circle(5)
print(f"반지름: {circle.radius}")
print(f"넓이: {circle.area:.2f}")
print(f"둘레: {circle.circumference:.2f}")
# circle.area = 100  # AttributeError (읽기 전용)
```

## 1.3.4.7. 클래스 메서드와 정적 메서드

```python
class Date:
    def __init__(self, year, month, day):
        self.year = year
        self.month = month
        self.day = day
    
    @classmethod
    def from_string(cls, date_string):
        """클래스 메서드: 대체 생성자"""
        year, month, day = map(int, date_string.split('-'))
        return cls(year, month, day)
    
    @classmethod
    def today(cls):
        """현재 날짜로 객체 생성"""
        import datetime
        today = datetime.date.today()
        return cls(today.year, today.month, today.day)
    
    @staticmethod
    def is_leap_year(year):
        """정적 메서드: 유틸리티 함수"""
        return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)
    
    def __str__(self):
        return f"{self.year}-{self.month:02d}-{self.day:02d}"

# 일반 생성자
date1 = Date(2024, 3, 9)

# 클래스 메서드로 생성
date2 = Date.from_string("2024-03-09")
date3 = Date.today()

# 정적 메서드 호출 (인스턴스 없이)
print(Date.is_leap_year(2024))  # True
```

## 1.3.4.8. 데이터 클래스 (Python 3.7+)

```python
from dataclasses import dataclass, field
from typing import List

@dataclass
class Point:
    x: float
    y: float
    
    def distance_from_origin(self):
        return (self.x**2 + self.y**2) ** 0.5

p1 = Point(3, 4)
p2 = Point(3, 4)
print(p1)           # Point(x=3, y=4)
print(p1 == p2)     # True (자동 __eq__)
print(p1.distance_from_origin())  # 5.0

# 고급 데이터 클래스
@dataclass(order=True)  # 비교 연산 자동 생성
class Student:
    sort_index: float = field(init=False, repr=False)
    name: str
    grade: float
    courses: List[str] = field(default_factory=list)
    
    def __post_init__(self):
        self.sort_index = self.grade

s1 = Student("Alice", 85.5)
s2 = Student("Bob", 92.0)
print(s1 < s2)  # True (grade 기준)

# Frozen (불변) 데이터 클래스
@dataclass(frozen=True)
class ImmutablePoint:
    x: float
    y: float

point = ImmutablePoint(1, 2)
# point.x = 5  # FrozenInstanceError
```

## 1.3.4.9. 추상 클래스

```python
from abc import ABC, abstractmethod

class Animal(ABC):
    def __init__(self, name):
        self.name = name
    
    @abstractmethod
    def make_sound(self):
        """하위 클래스에서 반드시 구현해야 함"""
        pass
    
    @abstractmethod
    def move(self):
        pass
    
    def sleep(self):
        """구현된 메서드 (하위 클래스에서 사용 가능)"""
        return f"{self.name}이(가) 잠을 잡니다"

class Dog(Animal):
    def make_sound(self):
        return "멍멍!"
    
    def move(self):
        return "네 발로 걷습니다"

# animal = Animal("동물")  # TypeError (추상 클래스는 인스턴스화 불가)
dog = Dog("멍멍이")
print(dog.make_sound())  # 멍멍!
print(dog.sleep())       # 멍멍이이(가) 잠을 잡니다
```

## 1.3.4.10. 디자인 패턴

### 싱글톤 (Singleton)

```python
class Singleton:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

s1 = Singleton()
s2 = Singleton()
print(s1 is s2)  # True (같은 인스턴스)
```

### 팩토리 (Factory)

```python
class AnimalFactory:
    @staticmethod
    def create_animal(animal_type):
        if animal_type == "dog":
            return Dog("멍멍이")
        elif animal_type == "cat":
            return Cat("나비")
        else:
            raise ValueError(f"Unknown animal type: {animal_type}")

animal = AnimalFactory.create_animal("dog")
```

### 옵저버 (Observer)

```python
class Subject:
    def __init__(self):
        self._observers = []
    
    def attach(self, observer):
        self._observers.append(observer)
    
    def detach(self, observer):
        self._observers.remove(observer)
    
    def notify(self, message):
        for observer in self._observers:
            observer.update(message)

class Observer:
    def __init__(self, name):
        self.name = name
    
    def update(self, message):
        print(f"{self.name} received: {message}")

subject = Subject()
observer1 = Observer("Observer1")
observer2 = Observer("Observer2")

subject.attach(observer1)
subject.attach(observer2)
subject.notify("Hello!")
```
