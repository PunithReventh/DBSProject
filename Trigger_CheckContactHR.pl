CREATE OR REPLACE TRIGGER CheckContactHR
BEFORE INSERT
ON HR_CONTACT
FOR EACH ROW

BEGIN
	IF :NEW.hrContact < 7000000000 AND :NEW.hrContact > 9999999999 THEN
		raise_application_error(-20103, 'Invalid Contact Number Format');
	END IF;
END;
/