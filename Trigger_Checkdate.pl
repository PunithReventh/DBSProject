CREATE OR REPLACE TRIGGER CheckDate
BEFORE INSERT
ON COMPANY_SCHEDULE
FOR EACH ROW

BEGIN
	IF :NEW.DEADLINE < SYSDATE  THEN
		raise_application_error(-20101, 'Invalid Deadline');
	ELSIF :NEW.TESTTIME < :NEW.DEADLINE THEN
		raise_application_error(-20102, 'Invalid Test Date');
	END IF;
END;
/