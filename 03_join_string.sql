# [없어진 기록 찾기]
# 천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
SELECT o.animal_id, o.name
from animal_ins as i right join animal_outs as o # 들어온 기록이 Null인 데이터를 찾아야하므로 right join을 사용(animal_outs의 데이터 위주로 조회)
    on i.animal_id = o.animal_id 
where i.animal_id is null;

# [있었는데요 없었습니다]
# 관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
SELECT o.animal_id, o.name
from animal_outs as o left join animal_ins as i
    on o.animal_id = i.animal_id
where o.datetime < i.datetime # join 후 2개의 칼럼값을 비교하는 조건 필터링
order by i.datetime asc;

# [오랜 기간 보호한 동물(1)]
# 아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일 순으로 조회해야 합니다.

SELECT i.name, i.datetime
from animal_ins as i left join animal_outs as o
    on i.animal_id = o.animal_id
where o.animal_id is null # is null로 Null인 값 검색
order by i.datetime asc
limit 3;

# [보호소에서 중성화한 동물]
# 보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
SELECT i.animal_id, i.animal_type, i.name
from animal_ins as i join animal_outs as o
    on i.animal_id = o.animal_id
where SUBSTRING_INDEX(i.sex_upon_intake, " ",1) = 'Intact' # join 후 animal_ins에서는 들어올 당시의 데이터를
    and substring_index(o.sex_upon_outcome, " ", 1) in ("Neutered", "Spayed") # animal_outs에서는 나갈 당시의 데이터를 필터링, in 을 사용해서 해당 리스트 안에있는 값들을 검색
order by i.animal_id;

# [루시와 엘라 찾기]
# 동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요.
SELECT animal_id, name, sex_upon_intake
from animal_ins
where name in ("Lucy", "Ella", "Pickle", "Rogan", "Sabrina", "Mitty") # in 을 사용해서 해당 리스트 안에있는 값들을 검색
order by animal_id;

# [이름에 el이 들어가는 동물 찾기]
# 보호소에 돌아가신 할머니가 기르던 개를 찾는 사람이 찾아왔습니다. 이 사람이 말하길 할머니가 기르던 개는 이름에 'el'이 들어간다고 합니다. 동물 보호소에 들어온 동물 이름 중, 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.
SELECT animal_id, name
from animal_ins
where animal_type = "Dog" and name like "%el%" # like절을 통해서 el을 포함하는 문자열 찾기
order by name;

# [중성화 여부 파악하기]
# 보호소의 동물이 중성화되었는지 아닌지 파악하려 합니다. 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.
SELECT animal_id, name,
    if(substring_index(sex_upon_intake," ",1) in ("Neutered", "Spayed"),"O","X") as "중성화" # if절을 통해 조건 분류, substring_index로 분리한 값 중 중성화 한 데이터를 판별해서 O,X 마킹
from animal_ins
order by animal_id;

# [오랜 기간 보호한 동물(2)]
# 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.
SELECT i.animal_id, i.name
from animal_ins as i join animal_outs as o
    on i.animal_id = o.animal_id
where o.animal_id is not null # is not null로 Null이 아닌 데이터 검색
order by o.datetime - i.datetime desc
limit 2;

# [DATETIME에서 DATE로 형 변환]
# ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 SQL문을 작성해주세요. 이때 결과는 아이디 순으로 조회해야 합니다.
SELECT animal_id, name, DATE_FORMAT(datetime, '%Y-%m-%d') # '2018-01-22' 형태로 형변환하는 파라미터 포멧
from animal_ins
order by animal_id;