CONN SYS/123@LOCALHOST:1521/XEPDB1 AS SYSDBA; 

ALTER SESSION SET CURRENT_SCHEMA = QLDLNB ; 

--XOA USR
CREATE OR REPLACE PROCEDURE USP_XOA_NV
AS
    CURSOR CUR IS (
        SELECT
            'NV' ||MANV
        FROM
            QLDLNB.NHANSU
        WHERE
            'NV' || MANV IN (
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
        STRSQL := 'DROP USER '|| USR || ' CASCADE' ;
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;
    COMMIT;
            STRSQL := 'alter session set "_ORACLE_SCRIPT" = FALSE';
    EXECUTE IMMEDIATE(STRSQL);
    CLOSE CUR;
END;
/

CREATE OR REPLACE PROCEDURE USP_TAO_NV
AS
CURSOR CUR IS (
        SELECT
            MANV
        FROM
            NHANSU
        WHERE
            'NV' || MANV NOT IN (
                SELECT USERNAME
                FROM
                    ALL_USERS
        )
    );
    STRSQL VARCHAR(2000);
    USR    VARCHAR2(10);
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'CREATE USER NV'
                  ||USR
                  ||' IDENTIFIED BY '
                  ||USR;
        EXECUTE IMMEDIATE(STRSQL);
        STRSQL:= 'GRANT CREATE SESSION TO NV'
                 || USR ;
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;
    COMMIT;
    CLOSE CUR;
END;
/

CREATE OR REPLACE PROCEDURE USP_GAN_ROLE_NV (
    STRROLE VARCHAR2,
    LOAI VARCHAR2
) AS
    CURSOR CUR IS (
        SELECT
            'NV'||MANV
        FROM
            QLDLNB.NHANSU
        WHERE
            VAITRO = LOAI
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
        STRSQL:= 'GRANT '
                 ||STRROLE
                 ||' TO '
                 ||USR;
        EXECUTE IMMEDIATE (STRSQL);
    END LOOP;
    STRSQL := 'alter session set "_ORACLE_SCRIPT" = FALSE';
    EXECUTE IMMEDIATE(STRSQL);
    CLOSE CUR;
END;
/
EXEC USP_XOA_NV;
EXEC USP_TAO_NV;
