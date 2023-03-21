-- Q1-1.
--(1) 논리 모델링(논리 설계) --(2) 데이터 모델링
-- Q1-2.
--(1) E-R Theory --(2) E-R Theory --(3) Entity
-- Q1-3.
--(1) E-R Diagram --(2) Relationship
-- Q1-4.
--(1) 카디널리티, 관계차수 --(2) 옵셔널리티
-- Q1-5.
--(1) 스키마 --(2) Table
-- Q1-6.
--(1) Table --(2) Index --(3) Sequence

-- 1. EMP 테이블에서 다음과 같이 출력하세요.
-- 정렬이 빠져있음.
-- KING과 MILLER를 제외해야함.
SELECT EMPNO AS EMPLOYEE_NO
    , ENAME AS EMPLOYEE_NAME
    , JOB
    , MGR AS MANAGER
    , HIREDATE
    , SAL AS SALARY
    , COMM AS COMMISSION
    , DEPTNO AS DEPARTMENT_NO
FROM EMP
WHERE EMPNO NOT IN (
    SELECT EMPNO
    FROM EMP
    WHERE ENAME IN ('KING', 'MILLER')
)
ORDER BY DEPTNO DESC, ENAME ASC;

--2. NULL에 대한 이해
--2-1) COMM IS NULL이고, SAL > NULL 인 경우는?
SELECT *
    FROM EMP
    WHERE COMM IS NULL
    AND SAL > NULL;
-- 정답 : 이 경우에는 아무 것도 출력하지 못합니다. null과의 비교는 모두 null값을 리턴합니다.

--2-2) MGR과 COMM 모두가 NULL인 직원은?
SELECT *
    FROM EMP
    WHERE MGR IS NULL
    AND COMM IS NULL;
-- 정답 : 정답은 KING(사번 : 7839)입니다.

--3. EMP 테이블에서 다음과 같이 출력하세요.
--3-1) S로 끝나늦 직원은?
SELECT EMPNO
    , ENAME
    , JOB
    , MGR
    , HIREDATE
    , SAL
    , COMM
    , DEPTNO
    FROM EMP
    WHERE ENAME LIKE '%S';
--3-2) JOB SALESMAN이고 부서번호가 30인 경우는?
SELECT EMPNO
    , ENAME
    , JOB
    , MGR
    , HIREDATE
    , SAL
    , COMM
    , DEPTNO
FROM EMP
WHERE JOB = 'SALESMAN'
    AND DEPTNO = 30;

--3-3) 부서번호가 20이거나 30이고,  월급이 2000을 초과하는 경우는?
SELECT EMPNO
    , ENAME
    , JOB
    , MGR
    , HIREDATE
    , SAL
    , COMM
    , DEPTNO
    FROM EMP
    WHERE DEPTNO IN (20, 30)
    AND SAL > 2000;
--3-4) 앞의 3번을 UNION을 이용해서 풀어보시오.
SELECT EMPNO
    , ENAME
    , JOB
    , MGR
    , HIREDATE
    , SAL
    , COMM
    , DEPTNO
    FROM EMP
    WHERE DEPTNO = 20
    AND SAL > 2000
UNION
SELECT EMPNO
    , ENAME
    , JOB
    , MGR
    , HIREDATE
    , SAL
    , COMM
    , DEPTNO
    FROM EMP
    WHERE DEPTNO = 30
    AND SAL > 2000;
-- 3-5) COMM이 없고, 매니저가 아닌 상급자가 있는 직원(MGR is not null) 중에서 직원의 직책이 MANAGER, CLERK 이고, 이름의 두번째 글자가 L이 아닌 경우
SELECT EMPNO
    , ENAME
    , JOB
    , MGR
    , HIREDATE
    , SAL
    , COMM
    , DEPTNO
    FROM EMP
    WHERE MGR IS NOT NULL
    AND COMM IS NULL
    AND JOB IN ('MANAGER', 'CLERK')
    AND ENAME NOT LIKE '_L%';

-- 4.
-- 4-1) 사원명이 6글자를 초과하는 경우에 사원번호와 직원명을 다음과 같이 마스킹 처리하시오.
SELECT EMPNO
  	  ,ENAME
 	  ,RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS EMPNO_마스킹_처리
 	  ,RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS ENAME_마스킹_처리
 	   FROM EMP
 	   WHERE LENGTH(ENAME) >= 6;
-- 4-2)
SELECT EMPNO
 	  ,ENAME
 	  ,JOB
 	  ,SAL
 	  ,(SAL / 20) AS DAY_PER_SAL
 	  ,(SAL / 20 / 8) AS HOUR_PER_SAL
 	  FROM EMP
 	  WHERE JOB IN ('SALESMAN', 'CLERK')
 	  ORDER BY SAL;
-- 4-3)
-- 입사일을 기준으로 3개월 지난 후, 첫 월요일에 정직원이 되는 날짜를 구하고 추가수당이 없는 경우 'N/A'로 출력하시오.
SELECT EMPNO
 	  ,ENAME
 	  ,TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), 'monday'), 'yyyy-mm-dd') AS HIREDATE3
 	  ,NVL(TO_CHAR(COMM), 'N/A') AS COMM
 	  FROM EMP;
-- 4-4)
SELECT EMPNO
 	  ,ENAME
 	  ,MGR
 	  ,CASE WHEN MGR IS NULL THEN '0000'
 	  		WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
 	  		WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
 	  		WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
 	  		WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
 	  		ELSE '9999'
 	  		END AS CHG_MGR
 	  FROM EMP;
