CONN lbacsys/123@LOCALHOST:1521/XEPDB1; 

EXECUTE SA_SYSDBA.DROP_POLICY('PC_OLS_QLDLNB');
/
EXECUTE SA_SYSDBA.CREATE_POLICY('PC_OLS_QLDLNB', 'OLS_THONGBAO', 'NO_CONTROL');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('PC_OLS_QLDLNB',6000,'TK', 'TRUONGKHOA');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('PC_OLS_QLDLNB',5000,'TDV', 'TRUONGDONGVI');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('PC_OLS_QLDLNB',4000,'GVIEN', 'GIANGVIEN');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('PC_OLS_QLDLNB',3000,'GVU', 'GIAOVU');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('PC_OLS_QLDLNB',2000,'NVCB', 'NHANVIENCOBAN');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('PC_OLS_QLDLNB',1000,'SV', 'SINHVIEN');


EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT ('PC_OLS_QLDLNB', 60, 'HTTT','HETHONGTHONGTIN');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT ('PC_OLS_QLDLNB', 50, 'CNPM','CONGNGHEPHANMEM');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT ('PC_OLS_QLDLNB', 40, 'KHMT','KHOAHOCMAYTINH');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT ('PC_OLS_QLDLNB', 30, 'CNTT','CONGNGHETHONGTIN');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT ('PC_OLS_QLDLNB', 20, 'TGMT','THIGIACMAYTINH');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT ('PC_OLS_QLDLNB', 10, 'MMT','MANGMAYTINH');


EXECUTE SA_COMPONENTS.CREATE_GROUP('PC_OLS_QLDLNB',10,'HCMUS','KHTN');

EXECUTE SA_COMPONENTS.CREATE_GROUP('PC_OLS_QLDLNB',30,'CS1','COSO1','HCMUS');

EXECUTE SA_COMPONENTS.CREATE_GROUP('PC_OLS_QLDLNB',50,'CS2','COSO2','HCMUS');

-- CREATE LABEL;

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL ('PC_OLS_QLDLNB',60000,'TK');

-- TRUONG BO MON CO SO 2
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('PC_OLS_QLDLNB',50010,'TDV::CS2');
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('PC_OLS_QLDLNB',50020,'TDV::CS1');

-- GIAO VU
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('PC_OLS_QLDLNB',30000,'GVU');

-- TRUONG DON VI
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('PC_OLS_QLDLNB',50000,'TDV');

-- SINH VIEN NGANH HTTT CS 1
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('PC_OLS_QLDLNB',11010,'SV:HTTT:CS1');

--TRUONG BM KHTMT CS1
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('PC_OLS_QLDLNB',53010,'TDV:KHMT:CS1');

--
EXECUTE SA_LABEL_ADMIN.CREATE_LABEL('PC_OLS_QLDLNB',53030,'TDV:KHMT');

EXECUTE SA_LABEL_ADMIN.CREATE_LABEL ('PC_OLS_QLDLNB', 200020,'NVCB::CS1');


/*
    EXECUTE SA_LABEL_ADMIN.DROP_LABEL ('PC_OLS_QLDLNB',60000);

-- TRUONG BO MON CO SO 2
EXECUTE SA_LABEL_ADMIN.DROP_LABEL('PC_OLS_QLDLNB',50010);

-- GIAO VU
EXECUTE SA_LABEL_ADMIN.DROP_LABEL('PC_OLS_QLDLNB',30000);

-- TRUONG DON VI
EXECUTE SA_LABEL_ADMIN.DROP_LABEL('PC_OLS_QLDLNB',50000);

-- SINH VIEN NGANH HTTT CS 1
EXECUTE SA_LABEL_ADMIN.DROP_LABEL('PC_OLS_QLDLNB',11010);

--TRUONG BM KHTMT CS1
EXECUTE SA_LABEL_ADMIN.DROP_LABEL('PC_OLS_QLDLNB',53010);

--
EXECUTE SA_LABEL_ADMIN.DROP_LABEL('PC_OLS_QLDLNB',53030);

*/
