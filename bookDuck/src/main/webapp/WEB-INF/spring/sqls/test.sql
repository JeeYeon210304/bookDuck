CREATE SEQUENCE MEMBERSEQ;
DROP SEQUENCE MEMBERSEQ;

INSERT INTO MEMBER VALUES(MEMBERSEQ.NEXTVAL, 'admin', 'admin1234', 20, 'F', 'admin@admin.com', 'Y', 'Y', 'ADMIN', 'GENERAL', 'N');
INSERT INTO MEMBER VALUES(MEMBERSEQ.NEXTVAL, 'admin2', 'admin1234', 20, 'F', 'admin@admin.com', 'Y', 'Y', 'ADMIN', 'GENERAL', 'N');

SELECT * FROM MEMBER



DELETE FROM MEMBER
WHERE MEMBER_ID='1234'













INSERT INTO PAYTABLE
VALUES (PAY_NO.NEXTVAL,'5000','회원권',SYSDATE,'admin')

SELECT * FROM PAYTABLE

SELECT MEMBER_PAYROLE
FROM MEMBER
WHERE MEMBER_ID='woobin'

DELETE FROM PAYTABLE
WHERE PAY_ID = 'admin'

UPDATE MEMBER SET MEMBER_PAYROLE = 'N'
WHERE MEMBER_ID ='1234'










CREATE SEQUENCE INTD_NO

INSERT INTO INTRODUCETABLE
VALUES('woobin123','안녕하세요',INTD_NO.NEXTVAL)

SELECT * FROM INTRODUCETABLE;

SELECT INTD_NO,INTD_ID,INTD_CONTENT
FROM INTRODUCETABLE
WHERE INTD_ID= 'user' ;

SELECT INTD_ID,INTD_CONTENT
FROM MEMBER INNER JOIN INTRODUCETABLE
ON MEMBER.MEMBER_ID = INTRODUCETABLE.INTD_ID
WHERE MEMBER_ID  ='user';

DELETE FROM INTRODUCETABLE
WHERE INTD_ID = 'admin'




SELECT *FROM BOOK
INSERT INTO BOOK
VALUES(456789123,'TESTBOOK3','test3','test3','test3',SYSDATE,3000,'TEST3','TEST3',7.5,'Y')




CREATE SEQUENCE SCRAP_NO

SELECT SCRAP_NO,SCRAP_ID,BOOK_ISBN,SCRAP_REGDATE 
FROM SCRAP

INSERT INTO SCRAP
VALUES(SCRAP_NO.NEXTVAL,'woobin',123456789,SYSDATE)

DELETE FROM SCRAP_NO
WHERE SCRAP_ID='woobin'








