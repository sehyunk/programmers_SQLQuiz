# [모든 레코드 조회하기]
# 동물 보호소에 들어온 모든 동물의 정보를 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. 
SELECT *
from animal_ins
order by animal_id;

# [역순 정렬하기]
# 동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 ANIMAL_ID 역순으로 보여주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT name, datetime
from animal_ins
order by animal_id desc; # 내림차순 정렬

# [아픈동물 찾기]
# 동물 보호소에 들어온 동물 중 아픈 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 
SELECT animal_id, name
from animal_ins
where intake_condition = "Sick" 
order by animal_id;

# [어린동물 찾기]
# 동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
SELECT animal_id, name
from animal_ins
where intake_condition != "Aged" # 특정값과 다른 연산자 != 으로 필터링
order by animal_id;

# [동물의 아이디와 이름]
# 동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. 
SELECT animal_id, name
from animal_ins
order by animal_id;

# [여러 기준으로 정렬하기]
# 동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성해주세요. 단, 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
SELECT animal_id, name, datetime
from animal_ins
order by name asc, datetime desc; # 2가지 소팅기준 각자 오름차순 내림차순 정렬이 가능하다.

# [상위 n개 레코드]
# 동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.
SELECT name
from animal_ins
order by datetime
limit 1;# limit으로 보여줄 데이터의 수 지정

# [최댓값 구하기]
# 가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT datetime
from animal_ins
order by datetime desc
limit 1;

# [최솟값 구하기]
# 동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT datetime
from animal_ins
order by datetime asc
limit 1;

# [동물 수 구하기]
# 동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT count(animal_id) #count를 통해 animal_id의 수 집계
from animal_ins;

# [중복 제거하기]
# 동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
SELECT count(distinct name) # distinct를 통해 중복값을 제외하고 count를 통해 집계
from animal_ins; 

