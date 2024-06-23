CONN sys/123@LOCALHOST:1521/XE AS SYSDBA; 
set serveroutput on format wrapped;
ALTER SESSION SET CURRENT_SCHEMA = QLDLNB; 
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
DECLARE
    -- Variable to hold the start date of the semester
    start_date DATE ;
    -- Variable to hold the current date
    current_date DATE := SYSDATE;
    -- Variable to hold the difference in days
    day_difference NUMBER;
    -- Variable to hold the semester number
    HK NUMBER;
    NAM_ NUMBER := 2024;
    MAHP_ NUMBER :=301;
BEGIN
    -- Fetch the semester number (HK) from the KHMO table
    dbms_output.enable; 
    SELECT HK
    INTO HK
    FROM KHMO
    WHERE MAHP = MAHP_ AND NAM = NAM_ AND MACT = 'VP';
    -- Determine the start date of the semester based on the HK value
    CASE HK
        WHEN 1 THEN
            start_date := TO_DATE('01-01-' || NAM_, 'DD-MM-YYYY');
        WHEN 2 THEN
            start_date := TO_DATE('01-05-' || NAM_, 'DD-MM-YYYY');
        WHEN 3 THEN
            start_date := TO_DATE('20-06-' || NAM_, 'DD-MM-YYYY');
        ELSE
            DBMS_OUTPUT.PUT_LINE('NONE');
            
    END CASE;
    
    -- Calculate the difference in days betSDASASDASADween the current date and the start date
    day_difference := current_date - start_date;
    DBMS_OUTPUT.PUT_LINE(day_difference);
END;
/
DECLARE
    LAM BOOLEAN;
BEGIN
    LAM := IS_VALID_DAY(301,2024,'VP');
    IF(LAM = TRUE) THEN 
        
    DBMS_OUTPUT.PUT_LINE('TRUE');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('FALSE');

    END IF;
END;
/

SELECT * FROM PHANCONG;

select * from NHANSU;

SELECT * FROM HOCPHAN;





