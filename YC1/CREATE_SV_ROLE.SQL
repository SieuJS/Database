CONN SYS/123@LOCALHOST:1521/XE AS SYSDBA; 

ALTER SESSION SET CURRENT_SCHEMA = QLDLNB ; 
alter session set container = CDB$ROOT;

CREATE OR REPLACE PROCEDURE USP_GAN_ROLE_SV (
    STRROLE VARCHAR2
) 
AS
    CURSOR CUR IS (
        SELECT
            'C##SV'||MASV
        FROM
            QLDLNB.SINHVIEN
        WHERE
            'C##SV'||MASV IN (
                SELECT
                    USERNAME
                FROM
                    ALL_USERS
            )
    );
    STRSQL VARCHAR2(2000);
    USR    VARCHAR2(10);
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL:= 'GRANT '
                 ||STRROLE
                 ||' TO '
                 ||USR;
        EXECUTE IMMEDIATE (STRSQL);
    END LOOP;

    CLOSE CUR;
END;
/

-- XOA SV

DECLARE
    CURSOR CUR IS (
        SELECT
            'C##SV' ||MASV
        FROM
            QLDLNB.SINHVIEN
        WHERE
            'C##SV' || MASV IN (
                SELECT
                    USERNAME
                FROM
                    ALL_USERS
            )
    );
    STRSQL VARCHAR(2000);
    USR    VARCHAR2(10);            
BEGIN 
    OPEN CUR;

    STRSQL := 'alter session set "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'DROP USER '|| USR || ' CASCADE';
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;

    COMMIT;
    STRSQL := 'alter session set "_ORACLE_SCRIPT" = FALSE';
    EXECUTE IMMEDIATE(STRSQL);
    CLOSE CUR;
END;
/

DECLARE
    CURSOR CUR IS (
        SELECT
            MASV
        FROM
            QLDLNB.SINHVIEN
        WHERE
            'C##SV' || MASV NOT IN (
                SELECT USERNAME
                FROM
                    ALL_USERS
        )
    );
    STRSQL VARCHAR2(2000);
    USR    VARCHAR2(10);
BEGIN
    OPEN CUR;
        STRSQL := 'alter session set container = CDB$ROOT';
    EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'CREATE USER C##SV'
                  ||USR
                  ||' IDENTIFIED BY '
                  ||USR || ' CONTAINER = ALL';
        EXECUTE IMMEDIATE(STRSQL);
        STRSQL:= 'GRANT CREATE SESSION TO C##SV'
                 || USR || ' CONTAINER = ALL';
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;

    COMMIT;
    CLOSE CUR;
END;
/

-- EXEC USP_XOA_SV ; 
-- EXEC USP_TAO_SV ;

