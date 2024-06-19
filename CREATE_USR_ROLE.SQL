CONN SYS/123@LOCALHOST:1521/XE AS SYSDBA; 

ALTER SESSION SET CURRENT_SCHEMA = QLDLNB ; 
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE OR REPLACE PROCEDURE USP_TAO_USR 
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
    STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'CREATE USER NV'
                  ||USR
                  ||' IDENTIFIED BY '
                  ||USR;
        EXECUTE IMMEDIATE(STRSQL);
        STRSQL:= 'GRANT CREATE SESSION TO NV'
                 || USR;
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;

    STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE ';
    EXECUTE IMMEDIATE(STRSQL);
    COMMIT;
    CLOSE CUR;
END;
/


CREATE OR REPLACE PROCEDURE USP_XOA_USR 
AS 
    CURSOR CUR IS (
        SELECT
            'NV' ||MANV
        FROM
            NHANSU
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
    STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'DROP USER '|| USR || ' CASCADE';
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;

    STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE';
    EXECUTE IMMEDIATE(STRSQL);
    COMMIT;
    CLOSE CUR;
END;
/

CREATE OR REPLACE PROCEDURE USP_GAN_ROLE (
    STRROLE VARCHAR2,
    LOAI VARCHAR2
) AS
    CURSOR CUR IS (
        SELECT
            'NV'||MANV
        FROM
            NHANSU
        WHERE
            'NV'||MANV IN (
                SELECT
                    USERNAME
                FROM
                    ALL_USERS
            )
            AND  VAITRO = LOAI
    );
    STRSQL VARCHAR(2000);
    USR    VARCHAR2(10);
BEGIN
    STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE(STRSQL);
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


EXEC USP_XOA_USR ; 
EXEC USP_TAO_USR ;
