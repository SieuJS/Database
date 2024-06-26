CONN SYS/123@LOCALHOST:1521/XEPDB1 AS SYSDBA; 

ALTER SESSION SET CURRENT_SCHEMA = QLDLNB; 
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--Trưởng đơn vị role base access;

-- Thêm xoá sửa trên phân công đối với học phần mình làm chủ 
-- Xem thông tin phân công đối với giáo viên thuộc đơn vị của mình.


CREATE OR REPLACE VIEW UV_TDV_XEMTT_PHANCONG
AS SELECT * FROM PHANCONG WHERE MAGV IN (
    SELECT MANV FROM NHANSU WHERE MADV IN (
        SELECT MADV FROM DONVI WHERE 'NV'||TRGDV = 
        SYS_CONTEXT('USERENV', 'SESSION_USER')
    ) 
);
CREATE OR REPLACE TRIGGER TRG_TDV_INS_PHANCONG
INSTEAD OF INSERT ON UV_TDV_XEMTT_PHANCONG
FOR EACH ROW 
BEGIN 
    INSERT INTO PHANCONG (MAGV, MAHP, HK, NAM, MACT)
    SELECT :NEW.MAGV, MAHP, :NEW.HK, :NEW.NAM, :NEW.MACT
    FROM HOCPHAN
    WHERE MADV IN (
        SELECT MADV 
        FROM DONVI 
        WHERE  'NV'||TRGDV = SYS_CONTEXT('USERENV', 'SESSION_USER')
    );
END;
/
CREATE OR REPLACE TRIGGER TRG_TDV_SUATT_PHANCONG
INSTEAD OF UPDATE ON UV_TDV_XEMTT_PHANCONG
FOR EACH ROW 
DECLARE 
BEGIN 

    UPDATE PHANCONG SET MAGV = :NEW.MAGV WHERE MAHP IN (SELECT MAHP FROM HOCPHAN WHERE MADV IN (
        SELECT MADV FROM DONVI WHERE 'NV'||TRGDV = SYS_CONTEXT('USERENV', 'SESSION_USER')))  AND MAGV = :OLD.MAGV ;
    UPDATE PHANCONG SET MAHP = :NEW.MAHP WHERE MAHP IN (
        SELECT MAHP FROM HOCPHAN WHERE MADV IN (
            SELECT MADV FROM DONVI WHERE 'NV'||TRGDV = SYS_CONTEXT('USERENV', 'SESSION_USER')
            )
        ) AND MAHP = :OLD.MAHP ; 
    UPDATE PHANCONG SET HK = :NEW.HK 
    WHERE 
        MAHP IN (SELECT MAHP FROM HOCPHAN WHERE MADV IN (
        SELECT MADV FROM DONVI WHERE  'NV'||TRGDV = SYS_CONTEXT('USERENV', 'SESSION_USER'))) AND HK = :OLD.HK;
    UPDATE PHANCONG SET NAM = :NEW.NAM WHERE MAHP IN (SELECT MAHP FROM HOCPHAN WHERE MADV IN (
        SELECT MADV FROM DONVI WHERE 'NV'||TRGDV = SYS_CONTEXT('USERENV', 'SESSION_USER'))) AND NAM = :OLD.NAM;
    UPDATE PHANCONG SET MACT = :NEW.MACT WHERE MAHP = (SELECT MAHP FROM HOCPHAN WHERE MADV IN (
        SELECT MADV FROM DONVI WHERE 'NV'||TRGDV = SYS_CONTEXT('USERENV', 'SESSION_USER'))) AND MACT = :OLD.MACT ;
END;
/
CREATE OR REPLACE TRIGGER TRG_TDV_DEL_PHANCONG
INSTEAD OF DELETE ON UV_TDV_XEMTT_PHANCONG
FOR EACH ROW 
BEGIN 
    DELETE FROM PHANCONG
    WHERE MAHP IN (
        SELECT MAHP 
        FROM HOCPHAN 
        WHERE MADV IN (
            SELECT MADV 
            FROM DONVI 
            WHERE 'NV'||TRGDV = SYS_CONTEXT('USERENV', 'SESSION_USER')
        )
    );
END;
/

DROP ROLE TDV ; 
CREATE ROLE TDV ;
GRANT SELECT, UPDATE, INSERT, DELETE ON UV_TDV_XEMTT_PHANCONG TO TDV;


--GÁN QUYỀN GIÁO VIÊN , NHÂN VIÊN CƠ BẢN .
EXEC USP_GAN_ROLE_NV(STRROLE  => 'NVCB' /*IN VARCHAR2*/, LOAI  => 'Trưởng đơn vị' /*IN VARCHAR2*/)

EXEC USP_GAN_ROLE_NV(STRROLE  => 'GV' /*IN VARCHAR2*/, LOAI  => 'Trưởng đơn vị' /*IN VARCHAR2*/)

EXEC USP_GAN_ROLE_NV(STRROLE  => 'TDV' /*IN VARCHAR2*/, LOAI  => 'Trưởng đơn vị' /*IN VARCHAR2*/)

-- SELECT * FROM PHANCONG;