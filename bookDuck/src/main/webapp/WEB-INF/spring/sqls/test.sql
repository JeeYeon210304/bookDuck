CREATE SEQUENCE MEMBERSEQ;

INSERT INTO MEMBER VALUES(1, 'admin', 'admin1234', 20, 'F', 'admin@admin.com', 'Y', 'Y', 'ADMIN', 'GENERAL', 'N');

SELECT * FROM MEMBER


INSERT INTO PAYTABLE
VALUES (PAY_NO.NEXTVAL,'5000','회원권',SYSDATE,'admin')

SELECT * FROM PAYTABLE

DELETE FROM PAYTABLE
WHERE PAY_ID = 'admin'

UPDATE MEMBER SET MEMBER_PAYROLE = 'Y'
WHERE MEMBER_ID ='user'