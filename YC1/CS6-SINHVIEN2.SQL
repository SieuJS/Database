CONN SYS/123@LOCALHOST:1521/XEPDB1 AS SYSDBA; 
ALTER SESSION SET CURRENT_SCHEMA = QLDLNB; 
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE OR REPLACE FUNCTION is_valid_day (
    MAHP_ IN NUMBER,
    NAM_ IN NUMBER,
    MACT_ IN VARCHAR2
) RETURN BOOLEAN IS
    -- Variable to hold the start date of the semester
    start_date DATE;
    -- Variable to hold the current date
    current_date DATE := SYSDATE;
    -- Variable to hold the difference in days
    day_difference NUMBER;
    -- Variable to hold the semester number
    HK_ NUMBER;
BEGIN
    -- Fetch the semester number (HK) from the KHMO table
    SELECT HK
    INTO HK_
    FROM KHMO
    WHERE MAHP = MAHP_ AND NAM = NAM_ AND MACT = MACT_;
    -- Determine the start date of the semester based on the HK value
    CASE HK_
        WHEN 1 THEN
            start_date := TO_DATE('01-01-' || NAM_, 'DD-MM-YYYY');
        WHEN 2 THEN
            start_date := TO_DATE('01-05-' || NAM_, 'DD-MM-YYYY');
        WHEN 3 THEN
            start_date := TO_DATE('01-09-' || NAM_, 'DD-MM-YYYY');
        ELSE
            RETURN FALSE; -- Invalid semester number
    END CASE;
    
    -- Calculate the difference in days betSDASASDASADween the current date and the start date
    day_difference := current_date - start_date;

    -- Check if the current date is within 14 days from the start date
    IF day_difference >= 0 AND day_difference <= 14 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE; -- No data found for the given parameters
    WHEN TOO_MANY_ROWS THEN
        RETURN FALSE; -- Multiple records found for the given parameters
    WHEN OTHERS THEN
        RETURN FALSE; -- An unexpected error occurred
END;
/

CREATE OR REPLACE TRIGGER TRG_DANGKYHP
BEFORE INSERT OR UPDATE ON DANGKY
FOR EACH ROW
DECLARE
    valid_day BOOLEAN;
BEGIN
    -- Call the is_valid_day function to check if the current day is within the valid range
    valid_day := QLDLNB.is_valid_day(:NEW.MAHP, :NEW.NAM, :NEW.MACT);
    IF :NEW.TH IS NOT NULL OR :NEW.DIEMQT IS NOT NULL OR :NEW.DIEMCK IS NOT NULL OR :NEW.DIEMTK IS NOT NULL THEN
        RETURN ;
    END IF;
    -- If the day is not valid, raise an exception
    IF NOT valid_day THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid day: Registration is not allowed more than 14 days after the start of the semester.');
    END IF;
END;
/

