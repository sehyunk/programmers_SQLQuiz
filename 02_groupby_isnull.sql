# [고양이와 개는 몇 마리 있을까]
# 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.
SELECT ANIMAL_TYPE, count(distinct animal_id)
from animal_ins
group by animal_type;

# [동명 동물 수 찾기]
# 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
SELECT name, count(name)
from animal_ins
group by name # group by절을 통해 name별로 데이터를 집계
having count(name) > 1 # having절로 group by로 집계된 후의 데이터를 필터링 할 수 있다.
order by name;

# [입양 시각 구하기(1)]
# 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
SELECT hour(datetime) as hour, count(animal_id) # hour함수를 통해 datetime에서 시간값을 추출
from animal_outs
where hour(datetime) between 9 and 20 # between으로 9이상 20미만의 데이터를 필터링
group by hour(datetime)
order by hour(datetime);

# [입양 시각 구하기(2)]
# 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
set @row_num = -1;# 0시 ~ 23시 틀 데이터를 만들기 위한 변수

select d.hour, sum(d.count)
from(
    (select hour(datetime) as 'hour', count(animal_id) as 'count'
                from animal_outs
                group by hour(datetime))
    union 
    (select @row_num := @row_num + 1 as 'hour', 0 as 'count' 
                from animal_outs 
                limit 24) # 0~23 의 HOUR 칼럼, 모두 0값이 들어있는 COUNT 칼럼
    )as d
group by d.hour
order by d.hour;

# [이름이 없는 동물의 아이디]
# 동물 보호소에 들어온 동물 중, 이름이 없는 채로 들어온 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT animal_id
from animal_ins
where name is null # is null을 통해 이름이 없는 동물 검색
order by animal_id asc;

# [이름이 있는 동물의 아이디]
# 동물 보호소에 들어온 동물 중, 이름이 있는 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT animal_id
from animal_ins
where name is not null # is not null을 통해 이름이 있는 동물 검색
order by animal_id asc;

# [NULL 처리하기]
# 입양 게시판에 동물 정보를 게시하려 합니다. 동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 프로그래밍을 모르는 사람들은 NULL이라는 기호를 모르기 때문에, 이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
SELECT animal_type, if(name is null, "No name", name), # name이 Null인 경우 "No name"으로 표기 조건문
	sex_upon_intake
from animal_ins
order by animal_id;

