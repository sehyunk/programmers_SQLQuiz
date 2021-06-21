2021-06-27 SQL 실력 점검을 위해 프로그래머스에서 SQL 테스트 후 문제풀이 작성

 [https://programmers.co.kr/learn/challenges](https://programmers.co.kr/learn/challenges) 

### 새로 배운 것

1. '다르다' 비교연산자를 `not`으로 잘못 사용함  `!=` 를 사용해야 했음.
2. `set  @변수명`  을 통해 변수를 사용할 수 있다.
3. 대입연산자 `:=` 를 통해 인덱스를 만들어 원하는 데이터 테이블을 만들어 활용 할 수 있다. ex) `select @변수명 := @변수명 + 1 limit을 통해 인덱스 끝 설정`