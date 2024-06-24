CONN SYS/123@LOCALHOST:1521/XEPDB1 AS SYSDBA; 
ALTER SESSION SET CURRENT_SCHEMA = QLDLNB;
SET SERVEROUTPUT ON ;
SELECT * FROM SINHVIEN WHERE MANGANH = 'HTTT' AND COSO = 'Cơ sở 1';
SELECT* FROM SINHVIEN WHERE COSO = 'Cơ sỏ 2';
SELECT * FROM NHANSU WHERE MANV = 600;

/
DECLARE 
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
    SV_LABEL VARCHAR2(100);
    MASV_ VARCHAR2(100);
    MANGANH_ VARCHAR(100);
    COSO_ VARCHAR(100);
BEGIN
OPEN CUR;
LOOP
   FETCH CUR INTO MASV_;
   EXIT WHEN CUR%NOTFOUND;
   
   BEGIN
      SELECT MANGANH, COSO INTO MANGANH_, COSO_
      FROM SINHVIEN
      WHERE 'SV'||MASV = MASV_;
      
      IF COSO_ = 'Cơ sở 1' THEN 
         COSO_ := 'CS1';
      ELSIF COSO_ = 'Cơ sở 2' THEN 
         COSO_ := 'CS2';
      END IF;
      
      SV_LABEL := 'SV:' || MANGANH_ || ':' || COSO_;
      DBMS_OUTPUT.PUT_LINE(SV_LABEL || '|' || MASV_);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         -- Handle the case where no data is found for the provided condition
         DBMS_OUTPUT.PUT_LINE('No data found for MASV: ' || MASV_);
   END;
END LOOP;

CLOSE CUR;

END ;
/

SELECT MANGANH, COSO FROM SINHVIEN WHERE 'SV'||MASV = 'SV772';
SELECT * FROM DONVI;
SELECT * FROM NHANSU WHERE VAITRO = 'Trưởng đơn vị' ;
SELECT * FROM NHANSU WHERE MANV = 502;
