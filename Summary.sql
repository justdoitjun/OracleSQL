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
