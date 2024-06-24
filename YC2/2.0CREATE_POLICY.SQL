
CONN lbacsys/123@LOCALHOST:1521/XEPDB1; 

select name, status, description from dba_ols_status;

BEGIN 
SA_SYSDBA.CREATE_POLICY ( 
 'PC_OLS_QLDLNB','OLS_THONGBAO', 'NO_CONTROL'
); 
END; 
/ 
DISCONNECT;