-- <오라클 함수> --DAY3(03/17/2023)

-- 문자열 함수
-- (1) =================================================
-- UPPER() 대문자 변환
-- LOWER() 소문자 변환
-- LENGTH() 문자열 길이
-- SAMPLE
SELECT ENAME
    , upper(ename) AS to_upper_name
    , lower(ename) AS to_lower_name
FROM EMP;
-- 고객은 대문자 / 소문자를 구분하지 않는 경우가 많습니다. 따라서, 이를 대문자든 소문자로 통합해주는 것이 매우 중요합니다.
-- 이는 뭔가 String 값을 비교하는 것도 마찬가지입니다. 아래의 사례처럼 말이죠. 이 개념은 원자성이라는 것과 연결됩니다.
SELECT *
FROM EMP
WHERE upper(ename) = upper('Scott');
-- 빈칸을 날리는 경우는 어떻게 할까요? TRIM  공란을 날려줘야할 필요도 있지요.
-- (2) =================================================
-- TRIM : 공란 제거
SELECT trim(' ___ORACLE _ _ _ ')
FROM dual;
-- 위 처럼 하면 공란이 제거가 되긴 하지만, 하나밖에 사라지지 않습니다.
-- 이 경우에는 공란도 정규 아스키코드가 있으므로 아스키 코드를 사용해보는 것도 팁입니다.
-- CONCAT : 문자열 연결 (더하기)
SELECT EMPNO    -- 7369
        , ENAME -- SMITH
        , concat(empno, ename) -- 이 경우에는 7369SMITH
FROM EMP;
-- (3) =================================================
-- REPLACE : 문자열 교체
-- 주요 예시 : 전화번호, 이메일, 집주소 등등
-- 자료를 깔끔하게 정리해주거나 혹은 개인정보를 보호하려고 이렇게 합니다.
SELECT '010-1234-5678' AS mobile_phone
    , replace('010-1234-5678', '-', '') AS replaced_mobile_phone
-- replace(1,2,3) 1번의 값 중 2번의 내용을 찾아서 3번처럼 바꿔주세요.
FROM dual;
-- (4) =================================================
-- LPAD, RAPD : 문자열을 채워주는 함수   --> TRIM과 대척점에 있는 함수.
-- 이 건 실무에서 왜 쓸까요? 칸을 채우기 위해 씁니다. 통일성을 유지하기 위해서.
-- 혹은 개인정보를 보호하기 위해서 이렇게 하는 경우도 있습니다.
SELECT lpad('ORA_1234_XE', 20) AS lpad_20
    , rpad('ORA_1234_XE', 20) AS rapd_20
FROM dual;
SELECT lpad('ORA_1234_XE', 20, '*') AS lpad_20
    , rpad('ORA_1234_XE', 20, '*') AS rapd_20
FROM dual;
-- (5) =================================================
-- 이번 건은 4번에서 확장되는 코드입니다.

-- (6) =================================================
-- 숫자함수
SELECT ROUND(1234.5678) AS R, ROUND(1234.5678, 0) AS R_0;
SELECT ROUND(3.1428, 3) AS round0
    , ROUND(3.1421, 3) AS ROUND1
    , TRUNC(123.4567, 3) AS trunc0
    , TRUNC(-123.4567, 3) AS trunc1
FROM dual;
SELECT CEIL(3.1) AS CEIL0 -- 부동소수가 일반적으로 들어갑니다. 정수가 있는 곳에 넣을 일은 없겠죠.
    , CEIL(3.9) AS CEIL1
    , FLOOR(3.1) AS CEIL0
    , FLOOR(3.9) AS CEIL1
FROM dual;
-- CEIL과 FLOOR는 자리수와 상관이 없습니다.

SELECT POWER(3,2), POWER(-3,3) FROM dual;
SELECT ABS(-100), ABS(100), ABS(0) from dual;
SELECT SIGN(-900), SIGN(700), SIGN(0) from dual;
-- 나누기에 대한 나머지(REMAINDER) 나머지에 대한 몫(MOD)
SELECT MOD(15,6), MOD(10,2), MOD(11,2) FROM dual;
SELECT REMAINDER(15,4) AS R1   --  -1
    , REMAINDER(15, -4) AS R2  --  -1
    , REMAINDER(-11, 4) AS R3  --  +1
    , REMAINDER(-11, -4) AS R4 --  +1
    , MOD(15,4) AS M1          --  +3
    , MOD(15,-4) AS M2         --  +3
    , MOD(-11,4) AS M3         --  -3
    , MOD(-11,-4) AS M4        --  -3
FROM dual;
-- (7) =================================================
-- 날짜함수

SELECT sysdate                  -- 현재시간
    ,ADD_MONTHS(sysdate, 3)     -- 3개월 후
    ,ADD_MONTHS(sysdate, 3*4)   -- 1년  후
FROM dual;

SELECT ENAME,
       ,EXTRACT(YEAR FROM HIREDATE) AS y
       ,EXTRACT(month from HIREDATE) AS m
       ,EXTRACT(day from HIREDATE) AS d
FROM emp;

SELECT sysdate,
    round(sysdate,'cc') AS format_cc, -- 1세기를 당겨주세요. Century 2001-01-01 // 2500년이 안지나서..
    round(sysdate, 'YYYY') AS format_yyyy, -- 2022년 초로 반올림해주세요. 2023-01-01 // 6월이 안 지나서..
    round(sysdate, 'Q') AS format_q,    -- 분기를 반올림해주세요. Quarter 2023-04-01 //
    round(sysdate, 'DDD') AS format_ddd, --
    round(sysdate, 'HH') AS format_hh
FROM dual;

-- (8) =================================================
-- NULL과 관련된 함수
-- NVL함수는 매우 중요합니다!!!!!
-- NVL(입력값, NULL인 경우 대체할 값) 일치한다면, 이렇게 바꿀 거고 일치하지 않는다면 값 그대로 할 거야.
-- NVL2(입력값, NULL인 경우 대체할 값) 일치하다면, 어떻게 일치하지 않는다면 어떻게 표기할지 정해줘.
SELECT NVL(COMM,0),
     NVL2(COMM,'Good', 'Bad')
FROM EMP;

SELECT EMPNO, ENAME, COMM
    ,NVL(COMM,0)
    ,SAL+NVL(COMM,0)
FROM EMP;
-- NULL값의 비교는 IS NULL <> IS NOT NULL


-- (9) =================================================
-- 형변환
-- 문자열과 숫자가 비교가 어렵지.
-- 근데, 만약에 14억 인도인 인구를 문자로 정리해 놓으면, 숫자로 치환하는데 너무 오랜 시간이 걸린다.
-- 형변환은 명시적형변환(To~~로 시작하는 형변환)과 암묵적형변환이 있지만, 최대한 명시적 형변환을 사용하는 걸 선호한다.
-- To_char
-- 컴퓨터 계산을 위해서 서로 비교하기 위해 만든다....
SELECT TO_NUMBER('3,300', '999,999'),
       TO_NUMBER('1,100', '999,999')
FROM DUAL;
SELECT to_char(sysdate, 'YYYY/MM/DD HH24')
FROM dual; -- 24시간 표기
SELECT to_char(sysdate, 'DD HH24:MI:SS')
FROM dual; -- 시분초까지 표기
SELECT sysdate,
       to_char(sysdate, 'MM') AS mml,
       to_char(sysdate, 'mon', 'MLS_DATE_LANGUAGE = KOREAN') AS mm2
FROM dual;
SELECT sysdate,
       to_char(sysdate, 'HH12:MI:SS' ) AS time
FROM dual;
SELECT to_number('1,000,000', '999,999,999') AS CURRENCY_TO_NUMBER
FROM dual; -- 문자를 숫자로 바궈준다. 999,999,999가 의미하는 바는? 저 숫자크기를 넘어가면 error를 내겠다.
-- 이 경우에는 일부러 error를 내는 경우로 1억이 넘는 경우는 error를 내겠다는 것이다.
SELECT to_date('20230330', 'YYYY/MM/DD') AS ymd
FROM dual;

-- TO_DATE(입력날짜, 'RR-MM-DD')
-- TO_DATE(입력날짜, 'YY-MM-DD')
-- 날짜 포멧 RR과 YY의 값을 비교하자.

SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_491
    ,TO_DATE('49/12/10', 'RR/MM/DD') AS RR_491
    ,TO_DATE('50/12/19', 'YY/MM/DD') AS YY_492
    ,TO_DATE('50/12/19', 'RR/MM/DD') AS RR_492
    ,TO_DATE('51/12/19', 'YY/MM/DD') AS YY_493
    ,TO_DATE('51/12/19', 'RR/MM/DD') AS RR_493
FROM dual;
-- (10) =================================================
-- DECODE CASE
-- DECODE는 무조건 해당 숫자가 되어야하지만
-- CASE는 유연하게 그 해당 범위에 있으면 처리해줄 수 있다.

SELECT EMPNO, ENAME, JOB, SAL
    ,DECODER(JOB,
                    'MANAGER', SAL*0.2,
                    'SALESMAN', SAL*0.3,
                    'ANALYST', SAL*0.05,
                    SAL*0.1) AS BONUS
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL
    ,CASE JOB
            WHEN 'MANAGER' THEN SAL*0.2
            WHEN 'SALESMAN' THEN SAL*0.3
            WHEN 'ANALYST' THEN SAL*0.05
            ELSE SAL *0.1
            END AS BONUS
FROM EMP;

-- (11) =================================================
-- 집계함수
-- 합 /
SELECT sum(E.sal) AS sum_of_sal
    ,avg(e.sal) As avg_of_sal
FROM EMP E
;
FROM dual;
-- (12) =================================================
-- 중요한 함수는 레코드 그룹별 집계입니다.
-- Group by 라든지... 이 때 집계조건은 having입니다.
-- 이 때 칼럼에 자주 쓰는 접두사는 distinct 입니다.
SELECT DEPTNO
    , count(SAL)
    , avg(SAL)
    , max(SAL)
    , min(SAL)
    , sum(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY deptno;

SELECT *
FROM EMP, DEPT
GROUP BY EMPNO
ORDER BY empno;


SELECT DISTINCT DEPTNO
FROM EMP E
;
SELECT DISTINCT e.DEPTNO
    , e.SAL
    , e.EMPNO
FROM EMP e;

SELECT SUM(DISTINCT SAL) AS SUM_DISTINCT_SAL
    ,SUM(ALL SAL) AS SUM_ALL_SAL
    ,SUM(SAL) AS SUM
FROM EMP;
-- ALL SAL과 SAL의 차이가 있을까?

-- 아래처럼 최대값 최소값은 각 칼럼의 편차를 알기에도 적합합니다.
SELECT MAX(SAL) AS MAX_SAL-- SAL 칼럼 중에 최대값
    ,MIN(SAL)   AS MIN_SAL-- SAL 칼럼 중에 최소값
    ,ROUND(MAX(SAL) / MIN(SAL) , 2) AS MAX_MIN_TIMES
FROM EMP
WHERE DEPTNO = 10;
-- (13) =================================================
-- COUNT 집계함수
SELECT COUNT(*)
FROM EMP;
SELECT COUNT(*)
FROM EMP
WHERE deptno = 30;
SELECT COUNT(empno) -- null은 계산에 들어가지 않는다.
    ,COUNT(comm)    -- 0도 당연히 센다. null만 안들어가는 것임.
FROM EMP;
SELECT count(DISTINCT sal)
    ,count(ALL sal)
    ,count(sal)
FROM emp;
SELECT count(ename)
FROM EMP
WHERE comm IS NOT NULL;
SELECT count(ename)
FROM EMP
WHERE nvl(comm,0) > 0;
SELECT avg(sal), '10' AS dno
FROM EMP
WHERE DEPTNO = 30;


-- cf.후보키 / super 키
-- 하나의 키만으로는 집단이 설명이 안되어서 2개 혹은 3개까지 주키를 만드는 칼럼도 생긴다.
-- 이들을 조합해서 만드는 것을 super키이다.

-- (14) =================================================
-- JOIN

-- 잘못된 JOIN
SELECT *
FROM EMP, DEPT -- 잘못된 join 사용 : cartesian product
ORDER BY empno;
SELECT *
FROM EMP E, DEPT D -- 잘못된 join 사용 : cartesian product
WHERE E.ENAME = 'SMITH'
ORDER BY E.EMPNO;
-- 정확한 JOIN : 교집합 칼럼 연결 (INNER JOIN)
SELECT *
FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO
ORDER BY EMPNO;
-- 아래는 위와 동일한 결과를 출력합니다.
SELECT *
FROM EMP E JOIN DEPT D
ON(E.DEPTNO = D.DEPTNO) -- ON 키워드 뒤에 값을 비교하지.
ORDER BY EMPNO;
-- OUTER JOIN
SELECT *
FROM EMP E LEFT OUTER JOIN DEPT D
ON(E.DEPTNO = D.DEPTNO)     -- ON 키워드 뒤에 값을 비교하자.
ORDER BY EMPNO;

--USING 구문으로도 ON 대신 간단하게 JOIN의 제약조건을 쓸 수도 있습니다.
--이 경우의 장점은 나중에 JAVA와 결합될 때 using 뒤에 변수를 넣어주면 되기 때문에 굉장히 간단하게 SQL을 쓸 수 있다는 장점이 있습니다.
SELECT *
FROM EMP e JOIN DEPT d
USING(deptno); -- USING 키워드 하나만으로 동일 칼럼을 비교할 수가 있게 되버림.

-- 쿼리문을 문자열로 사용 가능하다.
var_deptno; -- 사용자로부터 입력받은 부서 번호
var_sql = "   SELECT E.EMPNO
        , e.HIREDATE
        , d.DNAME
        , e.JOB
        , e.SAL
      FROM emp E JOIN dept D
        ON E.(var_deptno) = D.(var_deptno);  ";

SELECT e.empno
    ,e.ename
    ,e.hiredate
    ,to_char(e.hiredate, 'YYYY -MM : DD') AS STRINGDATE
    ,d.deptno
    ,d.LOC
FROM emp e
    ,dept d
WHERE e.deptno = d.deptno
ORDER BY d.deptno, e.empno;

SELECT e.empno
    ,e.ename
    ,e.hiredate
    ,to_char(e.hiredate, 'YYYY -MM : DD') AS STRINGDATE
    ,d.deptno
    ,d.LOC
FROM emp e
    ,dept d
WHERE e.deptno = d.deptno AND e.sal <2000
ORDER BY d.deptno, e.empno;

SELECT d.DNAME AS DEPARTMENT
    ,avg(e.sal) AS avg_sal
    ,sum(e.sal) AS sum_sal
    ,max(e.sal) AS max_sal
    ,min(e.sal) AS min_sal
FROM EMP e
    ,DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL <2000
GROUP BY d.DNAME;

/*
JOIN 함수로 SALGRADE 부여 후 GRADE로 그룹별 직원 수...
 */

SELECT s.grade
    ,count(e.Ename) AS emp_cnt
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal and s.hisal
group by s.grade
order by emp_cnt desc;

/*
SELECT
FROM emp E, dept D ---내가 필요한 테이블
WHERE E.deptno = D.deptno; --- FROM에 대한 제약 조건.
-- WHERE 이 자체가 E와 D를 inner join하겠다는 뜻입니다.
이를 통해 알 수 있듯, from에 테이블이 2개가 있으면 JOIN하겠다는 이야기고, 그렇다면 반드시 where절로 제약조건을 둬야지.
 */

SELECT *
FROM emp E, dept D -- Where를 안 썼을 때...cross join과 같은 형태로 나옵니다...
Order by E.empno;
-- 따라서 반드시 위처럼 제약조건을 적어주세요.

/*
 SELF-JOIN : 자기 자신의 릴레이션을 이용해서 테이블 칼럼을 조작하세요.
 언제 쓰냐면, 아래의 사례처럼, 자체 조인하는 경우에는...
 내 사번(3332223) /최준혁 / 상사 사번(777777) /상사 최으뜸
 그러나 만약, 테이블에 상사의 이름이 없다면, 상사의 이름을 자동으로 붙여줘야하는데
 이런 경우에는 테이블을 하나 더 가져와야하고 그래서 self-join을 해주는 것입니다.
 */
SELECT e1.EMPNO AS EMP_NO
     ,e1.ENAME AS EMP_NAME
     ,e2.MGR AS MGR_NO
     ,e2.ENAME AS MGR_NAME
    FROM EMP e1, EMP e2 -- SELF JOIN을 하기 위해서는 이 처럼 같은 테이블을 2번 불러와줘야합니다.
    WHERE e1.EMPNO = e2.MGR -- 직원의 사번이 다른 직원의 상사사번이라면? 즉, 나는 다른직원의 상사라는 이야기입니다.

SELECT e1.empno
        ,e1.ename
        ,e1.mgr
        ,e2.empno AS mgr_no
        ,e2.ename AS mgr_name
    FROM emp e1, emp e2
    WHERE e1.mgr = e2.empno;

/*
EMPNO,ENAME,MGR,MGR_NO,MGR_NAME
7788,SCOTT,7566,7566,JONES
7902,FORD,7566,7566,JONES
7499,ALLEN,7698,7698,BLAKE
7521,WARD,7698,7698,BLAKE
7654,MARTIN,7698,7698,BLAKE
7844,TURNER,7698,7698,BLAKE
7900,JAMES,7698,7698,BLAKE
7934,MILLER,7782,7782,CLARK
7876,ADAMS,7788,7788,SCOTT
7566,JONES,7839,7839,KING
7698,BLAKE,7839,7839,KING
7782,CLARK,7839,7839,KING
7369,SMITH,7902,7902,FORD
 */
-- 하지만, 굳이 SELF-JOIN이 아니어도... OUTER join으로 이를 구현할 수 있습니다.
-- 왼쪽부터 시작해서
SELECT e1.empno
    ,e1.ename
    ,e1.mgr
    ,e2.empno AS mgr_no
    ,e2.ename AS mgr_name
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno(+);
/*
 Left-join : 표준 SQL
 */
SELECT e1.empno
    ,e1.ename
    ,e1.mgr
    ,e2.empno AS mgr_no
    ,e2.ename AS mgr_name
FROM emp e1 left outer join emp e2
on(e1.mgr = e2.empno) ;
/*
 Right-outer-join
 */
SELECT e1.empno
    ,e1.ename
    ,e1.mgr
    ,e2.empno AS mgr_no
    ,e2.ename AS mgr_name
FROM emp e1 left outer join emp e2
on e1.mgr = e2.empno;

SELECT e1.empno
    ,e1.ename
    ,e1.mgr
    ,e2.empno AS mgr_no
    ,e2.ename AS mgr_name
FROM emp e1, emp e2
WHERE e1.mgr(+) = e2.empno;
/*
 Right-outer-join
 */
SELECT e1.empno
    ,e1.ename
    ,e1.mgr
    ,e2.empno AS mgr_no
    ,e2.ename AS mgr_name
FROM emp e1 right outer join emp e2
on e1.mgr = e2.empno;

/*
 Full-outer-join : 목적이 불분명해서...이걸 평소에 자주 쓰지가 않는다. 데이터가 의미가 없다는 것.
 */
SELECT e1.empno
    ,e1.ename
    ,e1.mgr
    ,e2.empno AS mgr_no
    ,e2.ename AS mgr_name
FROM emp e1 full outer join emp e2
ON e1.mgr = e2.empno
Order by e1.empno;

SELECT D.DEPTNO
    ,D.DNAME
    ,E.EMPNO
    ,E.ENAME
    ,E.MGR
    ,E.SAL
    ,E.DEPTNO
    ,S.LOSAL
    ,S.HISAL
    ,S.GRADE
    ,E2.EMPNO AS MGR_EMPNO
    ,E2.ENAME AS MGR_ENAME
FROM EMP E, DEPT D, SALGRADE S, EMP E2
WHERE E.DEPTNO(+) = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO;

SELECT D.DEPTNO
    ,D.DNAME
    ,E.EMPNO
    ,E.ENAME
    ,E.MGR
    ,E.SAL
    ,E.DEPTNO
    ,S.LOSAL
    ,S.HISAL
    ,S.GRADE
    ,E2.EMPNO AS MGR_EMPNO
    ,E2.ENAME AS MGR_ENAME
FROM EMP E, DEPT D, SALGRADE S, EMP E2
WHERE E.DEPTNO(+) = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO;

SELECT D.DEPTNO
    ,D.DNAME
    ,E.EMPNO
    ,E.ENAME
    ,E.MGR
    ,E.SAL
    ,E.DEPTNO
    ,S.LOSAL
    ,S.HISAL
    ,S.GRADE
    ,E2.EMPNO AS MGR_EMPNO
    ,E2.ENAME AS MGR_ENAME
FROM EMP E, DEPT D, SALGRADE S, EMP E2
WHERE E.DEPTNO(+) = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO;

SELECT *
FROM emp e1 RIGHT JOIN dept d
ON e1.DEPTNO = d.DEPTNO
LEFT OUTER JOIN SALGRADE s
ON (e1.sal >= s.LOSAL AND e1.sal <= s.HIGHSAL)
LEFT OUTER JOIN EMP e2
ON (e1.mgr = e2.EMPNO);

/*
 단일행 서브쿼리는 서브쿼리 결과가 1개 혹은 0개인 것. 따로 서브쿼리 모양이 다른 건 아님.
 */

SELECT *
FROM EMP e, DEPT d
WHERE e.DEPTNO = 10
AND e.SAL > (SELECT sal from emp E where E.ENAME = 'SMITH');

/*
 다중행 서브쿼리는 서브쿼리 결과가 2개 이상으로 여러개인 것. 따로 서브쿼리 모양이 다른 건 아님.
*/
SELECT *
FROM EMP
WHERE DEPTNO IN(10,20); -- 값이 8개가 나옴.

SELECT *
FROM EMP
WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO); -- 값이 4개 나옴.

SELECT *
FROM EMP
WHERE SAL IN(SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO); -- 값은 0개.

SELECT *
FROM EMP
WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO = 20);

SELECT *
FROM EMP
WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30);
-- 특정 부서 사원들의 최대 급여보다 적은 급여를 받는 직원을 출력함.
SELECT deptno, sal,EMPNO, ENAME
FROM EMP
WHERE (deptno, sal) IN (SELECT deptno, max(sal)
                        FROM EMP
                        GROUP BY deptno);
/*
 FROM 절에 사용되는 서브쿼리. 그러나 실상은 크게 다르지 않음.
SELECT
FROM (SELECT FROM ) A
    ,(SELECT FROM ) B
WHERE A. = B.
 */
SELECT B.deptno, B.dname, A.empno, A.ename, A.sal, B.loc
FROM (SELECT * FROM emp where deptno = 30) A
    ,(SELECT * FROM dept) B
WHERE A.deptno = B.deptno;
/*
 With 구절 ---> dual이나 view처럼 가상 테이블로 만들어줍니다.
WITH E AS (  )
    ,D AS (  )
SELECT ....
FROM E, D ;
 */
WITH E AS (SELECT * FROM emp WHERE deptno = 20 )
    ,D AS (SELECT * FROM dept)
    ,S AS (SELECT * FROM salgrade)
SELECT E.ename, D.dname, D.loc, S.GRADE
FROM E, D, S
WHERE E.deptno = D.deptno AND E.sal BETWEEN S.losal AND S.hisal;

/*
 DDL (CRUD- Create Read Update Delete) STATEMENT ==================================================================
 */

CREATE TABLE dept_temp2
AS SELECT * FROM dept;

--DAY 05 ===================================================================================================

INSERT INTO emp_temp2(empno, ename, job, mgr,hiredate,sal, comm,deptno)
VALUES(9999, 'hong', 'president', null, to_date('2001/01/01', 'YYYY/MM/DD'), 6000, 500, 10);
INSERT INTO emp_temp2(empno, ename, job, mgr,hiredate,sal, comm,deptno)
VALUES(2111, 'lee', 'manager', 9999, to_date('07/01/2000', 'MM/DD/YYYY'), 6000, 500, 10);
INSERT INTO emp_temp2(empno, ename, job, mgr,hiredate,sal, comm,deptno)
VALUES(2111, 'lee', 'manager', 9999, to_date('07/01/2000', 'DD/MM/YYYY'), 6000, 500, 10);
INSERT INTO emp_temp2(empno, ename, job, mgr,hiredate,sal, comm,deptno)
VALUES(3111, 'choi', 'manager', 9999, SYSDATE, 9000, 500, 10);
SELECT * from emp_temp2;

SELECT e.empno
     , e.ename
     , e.job
     , e.mgr
     , e.hiredate
     , e.sal
     , e.comm
     , e.deptno
     , s.grade
FROM EMP e, SALGRADE s
WHERE e.sal BETWEEN s.losal AND s.HISAL
AND s.grade =1 ;

SELECT *
FROM emp_temp2;

/*
 UPDATE 문 : 필터된 데이터에 대해서 레코드 값을 수정한다.
 이유 불문하고, update set where가 통으로 필요함. (Where 가 꼭 필요함)
 */
 CREATE TABLE dept_temp3
AS (SELECT * FROM dept);

SELECT * FROM dept_temp3;

UPDATE dept_temp3
SET loc = 'BOSTON'
WHERE deptno = 40;

rollback;

 UPDATE dept_temp3
 SET dname = 'DATABASE'
    , loc = 'SEOUL'
WHERE deptno = 40;
/*
서브쿼리문을 사용하여 UPDATE
 */
UPDATE dept_temp3
set (DNAME, LOC) = (SELECT dname,LOC
                    FROM dept
                    WHERE deptno = 40
                    )

WHERE deptno = 20; -- 이 경우에는 튜플이기 때문에 rollback이 안된다.

WHERE deptno = 40;
/*
DELETE 구문으로 테이블에서 값을 제거
    보통의 경우, DELETE 보다는 UPDATE 구문으로 상태 값을 변경합니다.
    예시 : 근무/휴직/퇴사 등의 유형으로 값을 변경
DELETE는 가능하면 거의 안 쓴다....
    반드시, where 조건이 필요하다. UPDATE랑 똑같이 DELETE도 반드시 WHERE 조건이 필요하다.
 */
SELECT *
FROM emp_temp3;


CREATE table emp_temp3
AS (SELECT * FROM emp);

DELETE FROM emp_temp3
WHERE job = 'MANAGER';

ROLLBACK ;
COMMIT ;

DELETE FROM emp_temp3
WHERE empno IN(SELECT e.empno
               FROM emp_temp3 e, salgrade s
               WHERE e.sal BETWEEN s.losal AND s.hisal
               AND s.grade = 3
               AND deptno = 30);

SELECT e.empno
               FROM emp_temp3 e, salgrade s
               WHERE e.sal BETWEEN s.losal AND s.hisal
               AND s.grade = 3
               AND deptno = 30;

/*
 CREATE Statement :
 */

 CREATE TABLE EMP_NEW
 (
    empno           number(4)
    ,ename          varchar(10)
    ,job            varchar(9)
    ,hiredate       date
    ,salgrade       number(7,2)
    ,comm           number(7,2)
    ,dpetno         number(2)
 );

SELECT *
FROM emp_new
WHERE rownum <= 10;

ALTER TABLE emp_new
ADD (hp varchar(20))
;                           -- 칼럼을 추가해줄 수 있음.

ALTER TABLE EMP_NEW
RENAME COLUMN hp TO TEL_NO; -- 잘못된 칼럼명을 hp에서 tel_no으로 바꿔줄 수 있음.

ALTER TABLE emp_new
MODiFy empno number(5) ;

ALTER TABLE EMP_NEW
DROP COLUMN tel_no ;

/*
 SEQUENCE 일련번호를 생성하며 테이블 관리를 편리하게 하고자 함.
 */
 CREATE SEQUENCE ()
INCREMENT BY 1
START WITH  1
MAXVALUE 999
MINVALUE 1
nocycle nocache ;  -- no cycle no cache의 뜻이 뭔가?
-- SEQUENCE를 가져다 쓰는데, 이 번호를 1군데에서만 쓸 수 있는 게 아니라 다른 데에서도 쓸 수 있잖아요.

/*
 제약조건 지정 : 테이블 생성 시, 테이블 칼럼 별 제약조건을 설정..
 Not null / Unique / PK / FK
 */

CREATE TABLE login
(
    log_id  VARCHAR2(20) NOT NULL
    , log_pwd VARCHAR2(20) NOT NULL
    , tel     VARCHAR2(20)
);
INSERT INTO login(log_id, log_pwd)
VALUES ('test01', '1234');

SELECT *
FROM login;

ALTER TABLE login
MODIFY tel NOT NULL ;
/*
 TEL없는 고객이 발견되어, 수소문 끝에 어렵게 전화번호를 구함.
 */
 UPDATE login
SET tel = '010-1234-5678'
WHERE log_id = 'test01';
/*
 오라클 DBMS가 사용자를 위해 만들어 놓은 제약조건 설정값 테이블
 */
 SELECT owner
    ,constraint_name
    ,constraint_type
    , table_name
FROM USER_CONSTRAINTS
Where table_name = 'login';

ALTER TABLE login
MODIFY (tel CONSTRAINT TEL_NN NOT NULL);

ALTER TABLE login
DROP CONSTRAINT SYS_C007040;

/*
 UNIQUE 키워드를 사용
 */
 CREATE TABLE log_unique
(
    log_id      varchar2(20) UNIQUE
    ,log_pwd    varchar2(20) NOT NULL
    ,tel        varchar2(20)
 );
SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'log_unique' ;

UPDATE log_unique
SET log_id = 'test_id_new' -- 사용자가 id 변경을 요청
WHERE log_id IS NULL;

ALTER TABLE log_unique
MODIFY (tel unique) ;

/*
 PK (Primary Key : 테이블을 설명하는 가장 중요한 키 )
 특징 : Not Null, Unique, Index
 */
 CREATE TABLE log_pk
(
   log_id Varchar2(20) PRIMARY KEY
    , log_pwd varchar2(20) NOT NULL
    , tel     varchar2(20) UNIQUE
 );
INSERT INTO TABLE log_pk (log_id, log_pwd, tel)
VALUES ('id01', 'pk01', '1');

INSERT INTO TABLE log_pk (log_id, log_pwd, tel)
VALUES (NULL, 'pwd02', '2');

SELECT *
FROM emp_temp2;

/*
 존재하지 않는 부서번호를 EMP_TEMP 테이블에 입력을 시도함.
 */

 INSERT INTO emp_temp2 (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (3333,'ghost', 'surprise', 9999, sysdate, 1200, NULL, 99);

/*
 INDEX : 빠른 검색을 위한 색인 지정

 장점 : 순식간에 원하는 값을 찾아 준다.
 단점 : 입력과 출력이 잦은 경우, 인덱스가 설정된 테이블의 속도가 저하된다. 계속 변경이 되면 그렇지.
 */
CREATE INDEX idx_emp_job
ON emp(job);

SELECT *
FROM user_indexes
WHERE TABLE_NAME IN ('EMP', 'DEPT');
/*
 View 생성 : TABLE을 편리하게 사용하기 위한 목적으로 생성하는 가상 테이블
 */

CREATE VIEW vw_emp AS (SELECT empno, ename, job, deptno
FROM emp
WHERE deptno = 10);
-- 테이블은 새로 만든 테이블을 입력해서, 저장하려고 하는 거고...뷰는 지금 만들어서 그냥 한번 볼라고 하는 거
-- 그냥 이거 결과만 보겠다. 조회목적임.

SELECT *
FROM vw_emp ;

SELECT *
FROM USER_VIEWS
WHERE view_name = 'VW_EMP'; -- 테이블 명은 반드시 대문자로 표기. 소문자일지라도...


/*
 ROWNUM     사용 : 상위 N개를 출력하기 위해 사용함.
 컬럼에 ROWNUM 순번을 입력하여 사용할 수 있음.
 */
-- sal desc 순서와 무관하게 emp 테이블에서 가져오는 순서로 순번을 출력한다.
SELECT ROWNUM, E.*
FROM EMP E
ORDER BY SAL DESC;
 --SAL desc 순서에 따라 오름차순으로 rownum 순번을 출력.
SELECT ROWNUM, A.*
FROM (SELECT ROWNUM, E.*
FROM EMP E
ORDER BY SAL DESC) A;
--
SELECT rownum,
       A.*
FROM (SELECT *
      FROM emp
      ORDER BY sal DESC) A
WHERE rownum <=5 ;

/*
 오라클 DBMS에서 관리하는 테이블 리스트 출력
 */
SELECT *
FROM dict
WHERE table_name = 'USER_IN%'--Wild Card(와일드카드 ) : USER_IN이 앞에 포함된 모든 것들을 가져와
;

SELECT *
FROM DBA_USERS
WHERE USERNAME = 'SCOTT'; -- SCOTT의 모든 것 출력

SELECT *
FROM DBA_TABLES
WHERE table_name LIKE 'EMP%'; -- EMP로 시작하는 테이블 모두 출력

SELECT *
FROM USER_INDEXES
WHERE TABLE_OWNER = 'SCOTT'; -- scott의 모든 index출력

DAY 06 ===================03==23==2023===========================================================================
--View
SELECT *
FROM EMPLOYEES
;
SELECT *
FROM EMPLOYEES e
    ,DEPARTMENTS d
    ,jobs j
    , LOCATIONS l
    , COUNTRIES c
    , REGIONS c
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_IT
AND d.LOCATION_ID = l.LOCATION_ID
AND l.COUNTRY_IT = c.COUNTRY_ID
AND c.region_id = r.region_id
AND j.job_id = e.job_id ;

SELECT AVG(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB ;

SELECT ENAME, DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB ;

-- 제1 정규화부터 제 5정규화까지 있구요. 제1~제3정규화까지는 많이 하는 경우가 일반적입니다. BCNF 정규화.
-- 사실 이것은 상황에 따라 달라집니다. Data dependent.
-- 테이블을 일부러 합치는 경우. vIew 도 일종이고, View는 순수하게 조회 목적이다.
-- 파티셔닝은 반 정규화라고 보긴 어렵지만, 데이터를 구체적으로 정규화할 수도 있습니다.
-- 정규화는 Edgar F.Codd   라는 분이 튜링상을 이 이론으로 받습니다.
-- 사실은 Raymond Boyce라는 분이 BNCF 반정규화를 소개한 사람이지만 요절하였음.
-- 1정규화 : 원자값으로 이루어져야합니다.
-- 2정규화 : 완전히 함수종속적으로, 그 테이블을 대표하는 주키를 중심으로 종속되어야한다.
-- 3정규화 : 일반컬럼들끼리는 종속관계가 없는가?  예를 들어, 사번이 주키인 직원 테이블에서 연봉과 입사일자는 연관성이 깊지.
-- 4정규화 : 칼럼이 한개가 아니고 여러개끼리 종속이 발생하는 경우. 3정규화보다 더 개판인 경우. 이런 경우는 드 물다.
-- 5정규화 : 릴레이션(테이블)의 모든 JOIN 종속이 후보키를 통해서만 성립. 후보키까지만 놔두고 다른 일반키들은 모두 날린다는 이야기.
--보통은 그래서 3정규화까지만 합니다.

--다시 정리
-- 1정규화 : 원자성(최소 단일요소)
-- 2정규화 : 완전함수종속 (부분 종속을 제거)

-- PK는 인덱스 처리가 자동으로 되기 때문에,


-- JOIN 교집합
-- InnerJoin을 많이 쓴다. 1 : N 관계인 경우에는 Inner Join이 가능하지만, N : N 관계인 경우에는 Outer-Join을 사용해야겠지..
-- FULL Outer Join은 사실상 쓰지 않는다.

-- 모든 경우의 수로 붙는 것은 카르테시안 곧 (Crouss Join)이라고 한다.
-- 리버스 모델링은 시간을 내서라도 한번 해봤다. 데이터 모델링된 결과물을 바탕으로 이 회사가 가진 특징을 한번 확인해보는 것이다.
-- 현실세계가 계속 변하는데, 이 테이블도 한번 바꿔야할 필요성이 있을 수도 있다.
-- 어떠한 부분을 중요하게 생각하고 있는지를 보고, 또 하나는 

-- 인덱스가 많으면 정보 변경/수정/삽입이 어렵습니다. 인덱스를 삭제하고 다시 데이터를 입력하고 그 이후에 인덱스를 다시 지정하는 게 더 나을 수도 있따.
-- 이유는 인덱스가 사라지거나 하면 칼럼을 매번 다 지정해야하기 때문이다. 
-- 시간이 곧 돈이고, 데이터가 곧 돈이다. 

-- 코딩 스타일 
-- 코딩에 대해서는 다시한번 생각해보면, CODE 작성과 수정 검토는 사람을 위해서 하는 것이다. 
-- 절대 컴퓨터를 위해 코딩하는 것이 아닙니다. 결국 어느 시점에 도달하면, 
-- 코딩이랑 곧 중요한 보고서를 작성하는 것이다. 다시 기억하자. 코딩은 곧 보고서 문서작성과 동일하다. 
-- 한버 작성한 코드는 지속적으로 re-factoring을 해줘야하고 ㅇ리관되게 표시방식을 통일해주는 것이 중요하다. 

-- SQL에선 snake표기법을 씁니다. EMP_NAME (SQL방식)
-- Java에선 camel표기법을 사용합니다. empName 
-- 그 이유는 웹 환경에서 만들어졌기 때문이고, c++이나 코볼은 언더스코어를 많이 썼지만, 웹환경은 언더스코어를 가능한 잘 안 쓴다. 
-- 그러보니, cmael표기법으로 작성한다. 
-- Pascal 표기법이라는 것도 있다. 이건 우리가 일반적으로 쓰는 방법이다. EmpName 이건 각 단어의 첫문자를 대문자로 하는 것이다. 

-- 주석은 최대한 많이, 자세하게 작성하는데 그 위치가 중요하다. 
-- 상단에 먼저 적어주고, 변수명 바로 뒤에 작성한다. 

-- SQL문은 반드시 뒤에 세미콜론 해주고
-- 변수명은 가능한 의미와 일치되게 만들어주자. Employee를 Emp라고 하는 게 좋지 단순히 A라고 하면 안좋다. 
-- 컬럼 별칭에 빈칸이 있는 경우 " " 를 사용하고, 텍스트 값은 ' '을 사용한다. 
