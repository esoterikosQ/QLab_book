## 쉘스크립트

쉘스크립트(Shell Script)는 유닉스 셸(Unix Shell)에서 실행되는 명령어들의 모음입니다. 쉘스크립트를 사용하면 반복적인 작업을 자동화하고, 시스템 관리 작업을 간소화할 수 있습니다. 쉘스크립트는 일반적으로 `.sh` 확장자를 가지며, 텍스트 에디터를 이용하여 작성하는 것이 가장 수월하고, 프롬프트 상에서 touch 명령을 이용하여 직접 작성할 수도 있습니다. 쉘스크립트는 다양한 쉘 환경에서 실행될 수 있으며, 가장 널리 사용되는 쉘은 Bash(Bourne Again SHell)입니다. 쉘스크립트를 작성할 때는 다음과 같은 기본 구문을 사용합니다:

```bash
#!/bin/bash
# 이 스크립트는 "Hello, World!"를 출력합니다.
echo "Hello, World!"
```

```bash
# 실행
chmod +x script.sh # 스크립트를 실행하려면 실행할 수 있도록 권한을 부여해야 합니다.
./script.sh
```

쉘스크립트를 이용하면 반복적으로 이용하는 명령어를 하나의 세트로 묶어서 한 명령어처럼 실행할 수 있습니다.

### 변수 사용

쉘스크립트에서 변수를 사용하여 값을 저장하고 재사용할 수 있습니다. 변수는 `$` 기호를 사용하여 참조합니다.

```bash
#!/bin/bash
NAME="Alice"
echo "Hello, $NAME!"
```

변수를 사용할 때의 장점은 스크립트를 실행할 때에 변수를 선언하면 출력할 때에 나오는 결과물을 쉽게 바꿀 수 있습니다.

### 조건문과 반복문

쉘스크립트에서는 조건문과 반복문을 사용하여 복잡한 로직을 구현할 수 있습니다.

```bash
#!/bin/bash
# 조건문 예시
NUMBER=10
if [ $NUMBER -gt 5 ]; then
    echo "$NUMBER is greater than 5"
else
    echo "$NUMBER is not greater than 5"
```

```bash
# 반복문 예시
for i in {1..5}
do
    echo "Iteration $i"
done
```