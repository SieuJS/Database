CONN SYS/123@LOCALHOST:1521/XE AS SYSDBA; 
alter session set container = CDB$ROOT;

ALTER SESSION SET CURRENT_SCHEMA = QLDLNB ; 

--XOA USR
DECLARE
    CURSOR CUR IS (
        SELECT
            'C##NV' ||MANV
        FROM
            QLDLNB.NHANSU
        WHERE
            'C##NV' || MANV IN (
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

DECLARE
CURSOR CUR IS (
        SELECT
            MANV
        FROM
            NHANSU
        WHERE
            'C##NV' || MANV NOT IN (
                SELECT USERNAME
                FROM
                    ALL_USERS
        )
    );
    STRSQL VARCHAR(2000);
    USR    VARCHAR2(10);
BEGIN
    OPEN CUR;
    STRSQL := 'alter session set container = CDB$ROOT';
    EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'CREATE USER C##NV'
                  ||USR
                  ||' IDENTIFIED BY '
                  ||USR || ' CONTAINER = ALL';
        EXECUTE IMMEDIATE(STRSQL);
        STRSQL:= 'GRANT CREATE SESSION TO C##NV'
                 || USR || ' CONTAINER = ALL';
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;
    COMMIT;
    CLOSE CUR;
END;
/
ALTER SESSION SET CURRENT_SCHEMA = SYS;

CREATE OR REPLACE PROCEDURE USP_GAN_ROLE (
    STRROLE VARCHAR2,
    LOAI VARCHAR2
) AS
    CURSOR CUR IS (
        SELECT
            'C##NV'||MANV
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
    STRSQL := 'alter session set container = CDB$ROOT';
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


