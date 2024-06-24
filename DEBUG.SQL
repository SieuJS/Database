CONN SYS/123@LOCALHOST:1521/XE AS SYSDBA; 
ALTER SESSION SET CURRENT_SCHEMA = QLDLNB;
alter session set container = CDB$ROOT;
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


SELECT * FROM SINHVIEN;