CONN SYS/123@LOCALHOST:1521/XE AS SYSDBA; 

ALTER SESSION SET CURRENT_SCHEMA = QLDLNB; 
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE OR REPACE CONTEXT QLDLNB_CTX USING QLDLNB_CTX_PKG;

CREATE OR REPLACE PACKAGE QLDLNB_CTX_PKG IS 
    PROCEDURE SET_SINHVIEN;
END;
/

CREATE OR REPLACE PACKAGE BODY QLDLNB_CTX_PKG IS 
PROCEDURE SET_SINHVIEN
AS 
    USR