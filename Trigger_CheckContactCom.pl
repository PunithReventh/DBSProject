CREATE OR REPLACE TRIGGER CheckCompany
BEFORE INSERT
ON COMPANY
FOR EACH ROW

BEGIN
	IF :NEW.companyContact < 7000000000 AND :NEW.companyContact > 9999999999 THEN
		raise_application_error(-20103, 'Invalid Contact Number Format');
	END IF;
END;
/