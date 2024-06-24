CONN SYS/123@LOCALHOST:1521/XEPDB1 AS SYSDBA; 

ALTER SESSION SET CURRENT_SCHEMA = QLDLNB ; 

CREATE OR REPLACE PROCEDURE USP_GAN_ROLE_SV (
    STRROLE VARCHAR2
) 
AS
    CURSOR CUR IS (
        SELECT
            'SV'||MASV
        FROM
            QLDLNB.SINHVIEN
        WHERE
            'SV'||MASV IN (
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
CREATE OR REPLACE PROCEDURE USP_XOA_SV
AS
    CURSOR CUR IS (
        SELECT
            'SV' ||MASV
        FROM
            QLDLNB.SINHVIEN
        WHERE
            'SV' || MASV IN (
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
        STRSQL := 'DROP USER '|| USR;
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;

    COMMIT;
    STRSQL := 'alter session set "_ORACLE_SCRIPT" = FALSE';
    EXECUTE IMMEDIATE(STRSQL);
    CLOSE CUR;
END;
/
CREATE OR REPLACE PROCEDURE USP_TAO_SV 
AS 
    CURSOR CUR IS (
        SELECT
            MASV
        FROM
            QLDLNB.SINHVIEN
        WHERE
            'SV' || MASV NOT IN (
                SELECT USERNAME
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
        STRSQL := 'CREATE USER SV'
                  ||USR
                  ||' IDENTIFIED BY '
                  ||USR;
        EXECUTE IMMEDIATE(STRSQL);
        STRSQL:= 'GRANT CREATE SESSION TO SV'
                 || USR ;
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;

    COMMIT;
    CLOSE CUR;
END;
/

EXEC USP_XOA_SV ; 
EXEC USP_TAO_SV ;

