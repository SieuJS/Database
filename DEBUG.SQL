CONN SV701/701@LOCALHOST:1521/XE; 
alter session set tracefile_identifier = SV3;
set serveroutput on format wrapped;
ALTER SESSION SET CURRENT_SCHEMA = QLDLNB; 
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
DECLARE
    STRSQL VARCHAR(100);
    MAHP_ VARCHAR2(10);
    MAHP_N NUMBER(5);
    CUR_USER VARCHAR2(10);
    LIST_MAHP VARCHAR2(300);
    PRED VARCHAR2(300);
    CURSOR CUR IS (
        SELECT MAHP FROM KHMO 
        WHERE MACT IN (
            SELECT MACT FROM SINHVIEN WHERE 'SV'||MASV = 
            SYS_CONTEXT('USERENV', 'SESSION_USER') 
        )
    );
BEGIN

    CUR_USER := SYS_CONTEXT('USERENV', 'SESSION_USER');

    OPEN CUR ;
    LIST_MAHP := ' ';
    DBMS_OUTPUT.PUT_LINE('LIST_MAHP: ' || LIST_MAHP);

    LOOP 
        FETCH CUR INTO MAHP_N;
        EXIT WHEN CUR%NOTFOUND; 
            IF (LIST_MAHP != ' ') THEN 
                LIST_MAHP := LIST_MAHP || ','; 
            END IF;
            LIST_MAHP := LIST_MAHP || ' ' || MAHP_N ; 
    END LOOP ; 
    CLOSE CUR;
    PRED := ' MAHP IN ('||LIST_MAHP||')';
    DBMS_OUTPUT.put_line(PRED);
    
END ;
/
SELECT * FROM HOCPHAN WHERE ''|| MAHP IN ('301','302','303');