CONN SV701/701@LOCALHOST:1521/XEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = QLDLNB; 
SELECT * FROM SINHVIEN ;

UPDATE SINHVIEN SET DCHI = 'HCM';
SELECT * FROM SINHVIEN ;

SELECT * FROM HOCPHAN;
SELECT * FROM SINHVIEN;
SELECT * FROM DANGKY;
DISCONNECT;


