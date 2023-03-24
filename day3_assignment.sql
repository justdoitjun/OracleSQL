/*
 * Q3-1 (1)원자성 (2)완전 함수적 종속 (3)이행적 종속 제거
 * Q3-2 (1)제3정규화(3NF) (2)제2정규화(2NF)
 * Q3-3 (1)inner join (2)left join (3)right join (4)outer join
 * Q3-4 (1)반정규화(Denormalization)
 * Q3-5 (1)인덱스(Index) (2)인덱스 (3)인덱스 (4)인덱스
 * Q3-6 (1)트랜잭션(Transaction) (2)Atomicity(원자성) (3)Consistency(일관성) 
 * 
 */
-- P.8 ============================================
--1-1
CREATE TABLE DEPT_TEST
	AS (SELECT * FROM DEPT)
	;
INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (50, 'ORACLE', 'BUSAN')
	;
INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (60, 'SQL', 'ILSAN')
	;
INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (70, 'SELECT', 'INCHEON')
	;
INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (80, 'DML', 'BUNDANG')
	;
SELECT * FROM DEPT_TEST;



--1-2
DROP TABLE emp_test;

CREATE TABLE EMP_TEST
	AS (SELECT * 
		FROM EMP 
		WHERE 1<>1)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, 
			TO_DATE('2016/01/02', 'YYYY/MM/DD'), 4500)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7202, 'TEST_USER2', 'CLERK', 7201, 
			TO_DATE('2016/02/21', 'YYYY/MM/DD'), 1800)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, 
			TO_DATE('2016/04/11', 'YYYY/MM/DD'), 3400)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, 
			TO_DATE('2016/05/31', 'YYYY/MM/DD'), 2700)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7205, 'TEST_USER5', 'CLERK', 7201, 
			TO_DATE('2016/07/20', 'YYYY/MM/DD'), 2600)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7206, 'TEST_USER6', 'CLERK', 7201, 
			TO_DATE('2016/09/08', 'YYYY/MM/DD'), 2600)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, 
			TO_DATE('2016/10/28', 'YYYY/MM/DD'), 2300)
	;
INSERT INTO EMP_TEST(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL)
	VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, 
			TO_DATE('2018/03/09', 'YYYY/MM/DD'), 1200)
	;

SELECT * FROM EMP_TEST


-- P.9 ========================================
--1-3
UPDATE EMP_TEST
	SET DEPTNO = 70
	WHERE SAL > (SELECT AVG(SAL) 
				 FROM EMP_TEST 
				 WHERE DEPTNO = 50)
	;

--1-4
UPDATE EMP_TEST 
	SET DEPTNO = 80
	   ,SAL = SAL * 1.2
	WHERE EMPNO = (SELECT EMPNO 
				   FROM (SELECT EMPNO 
				         FROM EMP_TEST 
				         WHERE DEPTNO = 60
				         ORDER BY HIREDATE)
				   WHERE ROWNUM = 1)
;



--p10. ==============================================================
-- 2-1

CREATE TABLE EMP_USER(
	EMPNO		NUMBER(4)
	,ENAME		VARCHAR2(10)
	,JOB			VARCHAR2(9)
	,MGR			NUMBER(4)
	,HIREDATE	DATE
	,SAL		NUMBER(7,2)
	,COMM		NUMBER(7,2)
	,DEPTNO		NUMBER(2)
)
;
--p10. 2-2
--처음헤 한개만 넣어서 각자 넣었는데 지우기귀찮아서 각각 넣음
ALTER  TABLE EMP_USER
	ADD EMP_DATE     DATE --문제에서 DATE를 칼럼명으로 하라하였으나 변경함
;

ALTER  TABLE EMP_USER
	ADD RESIGN_DATE     DATE
;

--두개 한번에 ADD하는 방식도 추가
ALTER  TABLE EMP_USER (
	ADD EMP_DATE     DATE --문제에서 DATE를 칼럼명으로 하라하였으나 변경함
	,RESIGN_DATE     DATE
);


--p10. 2-3
ALTER TABLE EMP_USER 	
	ADD SUR_NAME	VARCHAR2(5)
;

--p10. 2-4
--문자열 열자리 변경
ALTER TABLE EMP_USER 
	MODIFY SUR_NAME VARCHAR2(10)
;

--p10. 2-5
ALTER TABLE EMP_USER
	RENAME COLUMN ENAME TO FULL_NAME
;


--만들어졌는지 확인
SELECT * FROM
EMP_USER
;

-- P.11=======================================================================
-- EMP 테이블과 동일한 구조의 EMP_IDX 테이블을 생성한 후 EMPNO 컬럼에 인덱스를 지정하고,
-- 인덱스 명은 EMP_EMPNO_IDX를 지정하세요.


CREATE TABLE EMP_IDX
AS (SELECT * FROM EMP WHERE 1 <> 1) --동일한 구조만 따와서 테이블을 만듦
;
CREATE TABLE EMP_IDX
AS (SELECT * FROM EMP) -- 동일하 구조와 데이터깢 같이 가져와서 테이블을 만듬. 
;

CREATE INDEX EMP_EMPNO_IDX
ON EMP_IDX(EMPNO)
;

-- 해당 인덱스를 User_Indexes 사전 테이블에서 인덱스명으로 조회하세요.

SELECT *
FROM User_Indexes
WHERE Index_Name = 'EMP_EMPNO_IDX';

--Create or replace view 명령어를 사용하여 emp_idx 테이블에서 sal(월급)dl 20,000이상인 직원을 추출하고, comm 이 있는 경우 'Y', 없거나 Null인 경우 'N'으로 출력하세요.

CREATE OR REPLACE VIEW emp_view AS
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE,
       SAL, NVL2(COMM, 'Y', 'N') AS COMM
FROM EMP_IDX
WHERE SAL >= 20000;

-- P.12========================================================
-- 1. 제약조건 2. 고유제약조건 3. NOT NULL 4. PK제약조건 5. FK(외래키)