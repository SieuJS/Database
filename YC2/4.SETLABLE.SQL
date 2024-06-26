CONN lbacsys/123@LOCALHOST:1521/XEPDB1; 
ALTER SESSION SET CURRENT_SCHEMA = QLDLNB;

BEGIN
SA_POLICY_ADMIN.REMOVE_TABLE_POLICY(
    POLICY_NAME  => 'PC_OLS_QLDLNB',
    SCHEMA_NAME  => 'QLDLNB',
    TABLE_NAME  => 'THONGBAO',
);
END;
/

BEGIN
SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    POLICY_NAME  => 'PC_OLS_QLDLNB',
    SCHEMA_NAME  => 'QLDLNB',
    TABLE_NAME  => 'THONGBAO',
    TABLE_OPTIONS  => NULL
);
END;
/

UPDATE THONGBAO SET OLS_THONGBAO=CHAR_TO_LABEL('PC_OLS_QLDLNB', 'TDV') WHERE MaTB=1;
UPDATE THONGBAO SET OLS_THONGBAO=CHAR_TO_LABEL('PC_OLS_QLDLNB', 'GVU') WHERE MaTB=2;
UPDATE THONGBAO SET OLS_THONGBAO=CHAR_TO_LABEL('PC_OLS_QLDLNB', 'TDV') WHERE MaTB=3;
UPDATE THONGBAO SET OLS_THONGBAO=CHAR_TO_LABEL('PC_OLS_QLDLNB', 'SV:HTTT:CS1') WHERE MaTB=4;
UPDATE THONGBAO SET OLS_THONGBAO=CHAR_TO_LABEL('PC_OLS_QLDLNB', 'TDV:KHMT') WHERE MaTB=5;
UPDATE THONGBAO SET OLS_THONGBAO=CHAR_TO_LABEL('PC_OLS_QLDLNB', 'TDV:KHMT:CS1') WHERE MaTB=6;

COMMIT;


BEGIN
SA_POLICY_ADMIN.REMOVE_TABLE_POLICY(
    POLICY_NAME  => 'PC_OLS_QLDLNB',
    SCHEMA_NAME  => 'QLDLNB',
    TABLE_NAME  => 'THONGBAO',
    DROP_COLUMN => FALSE
);
END;
/
BEGIN
SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    POLICY_NAME  => 'PC_OLS_QLDLNB',
    SCHEMA_NAME  => 'QLDLNB',
    TABLE_NAME  => 'THONGBAO',
    TABLE_OPTIONS  => 'READ_CONTROL, WRITE_CONTROL, CHECK_CONTROL'
);
END;
/
