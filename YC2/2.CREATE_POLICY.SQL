
CONN lbacsys/123@LOCALHOST:1521/XEPDB1; 

select name, status, description from dba_ols_status;

BEGIN 
SA_SYSDBA.DROP_POLICY ( 
policy_name => 'PC_OLS_QLDLNB'
); 
END; 
/ 

DISCONNECT;