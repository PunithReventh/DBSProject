CREATE SEQUENCE comSeq
	START WITH 1
	INCREMENT BY 1;
CREATE SEQUENCE HRSeq
	START WITH 1
	INCREMENT BY 1;
CREATE SEQUENCE conSeq
	START WITH 1
	INCREMENT BY 1;
CREATE SEQUENCE indepAppl
	START WITH 1
	INCREMENT BY 1;
CREATE SEQUENCE indepConf
	START WITH 1
	INCREMENT BY 1;	

CREATE TABLE ROLE(
roleId INTEGER,
roleName VARCHAR(10) CHECK (roleName IN ('Student', 'Faculty', 'CDC')),
PRIMARY KEY(roleId)
);

CREATE TABLE USERLOGIN (
userEmail VARCHAR(20),
userPassword VARCHAR(35) NOT NULL,
userRoleId INTEGER NOT NULL,
PRIMARY KEY (userEmail),
CONSTRAINT FK_ROLE FOREIGN KEY (userRoleId) REFERENCES ROLE (roleId) ON DELETE CASCADE
);

CREATE TABLE FACULTY(
facultyName VARCHAR(20) NOT NULL,
facultyBranch VARCHAR(20),
facultyEmail VARCHAR(20),
facultyMobile INTEGER,
facultyAddress VARCHAR(40), 
facultyAdvisingBatch INTEGER NOT NULL,
PRIMARY KEY(facultyEmail),
CONSTRAINT facBatchUnique UNIQUE(facultyBranch,facultyAdvisingBatch) ON DELETE CASCADE,
CONSTRAINT FK_facMail FOREIGN KEY (facultyEmail) REFERENCES USERLOGIN (userEmail) ON DELETE CASCADE
);

CREATE TABLE STUDENT (
studentId VARCHAR(10),
studentName VARCHAR(30) NOT NULL,
studentMobile INTEGER,
studentEmail VARCHAR(20) NOT NULL UNIQUE,
studentAddress VARCHAR(50),
studentPermAddress VARCHAR(40),
studentWorkExperience VARCHAR(50),
studentBatch VARCHAR(10),
studentBranch VARCHAR(20),
studentCGPA NUMBER(4,2),
PRIMARY KEY (studentID),
CONSTRAINT FK_stuMail FOREIGN KEY (studentEmail) REFERENCES USERLOGIN (userEmail) ON DELETE CASCADE
);

CREATE TABLE STAFF (
staffName VARCHAR(30),
staffEmail VARCHAR(20),
staffMobile INTEGER,
staffAddress VARCHAR(35),
staffPosition VARCHAR(20),
PRIMARY KEY (staffEmail),
CONSTRAINT FK_stafMail FOREIGN KEY (staffEmail) REFERENCES USERLOGIN (userEmail) ON DELETE CASCADE
);

CREATE TABLE HR_CONTACT(
hrId INTEGER,
hrName VARCHAR(20) NOT NULL,
hrEmail VARCHAR(20) NOT NULL,
hrContact INTEGER NOT NULL,
PRIMARY KEY(hrId)
);
	
CREATE TABLE COMPANY(
companyId INTEGER,
companyName VARCHAR(20) NOT NULL UNIQUE,
companyType VARCHAR(20),
companyAddressLine1 VARCHAR(20),
companyAddressLine2 VARCHAR(20),
companyAddressCity VARCHAR(15),
companyAddressState VARCHAR(20),
companyAddressCountry VARCHAR(15),
companyAddressPincode VARCHAR(10),
companyWebsite VARCHAR(20),
companyContact INTEGER NOT NULL,
companyIndustrySector VARCHAR(20),
companyHRId INTEGER NOT NULL UNIQUE,
PRIMARY KEY(companyId),
CONSTRAINT fk_HRID FOREIGN KEY (companyHRId) REFERENCES HR_CONTACT (hrId) ON DELETE CASCADE
);

CREATE TABLE COMPANY_SCHEDULE (
companyId INTEGER,
deadline TIMESTAMP,
testTime TIMESTAMP,
testDuration INTEGER,
testType VARCHAR(10) CHECK (testType IN ('Internship','Full-time','Both')),
testEligibilityCGPA NUMBER(4,2),
testEligibilityBranch VARCHAR(15),
PRIMARY KEY (companyID, testTime),
CONSTRAINT FK_SCHD_COMPID FOREIGN KEY (companyId) REFERENCES COMPANY(companyID) ON DELETE CASCADE
);

CREATE TABLE JOB (
jobId INTEGER,
jobName VARCHAR(30) NOT NULL,
jobType VARCHAR(10) CHECK (jobType IN ('Internship', 'Full-time')),
jobLocation VARCHAR(10),
jobPay INTEGER,
jobEligibility VARCHAR(30),
jobBenefits VARCHAR(30),
PRIMARY KEY (jobID)
);

CREATE TABLE OFFEREDJOB (
jobId INTEGER NOT NULL,
companyId INTEGER NOT NULL,	
CONSTRAINT FK_OFFER_JOBID FOREIGN KEY (jobId) REFERENCES JOB(jobId) ON DELETE CASCADE,
CONSTRAINT FK_OFFER_COMPID FOREIGN KEY (companyId) REFERENCES COMPANY(companyId) ON DELETE CASCADE
);

CREATE TABLE SCREENING (
studentId VARCHAR(10) NOT NULL,
companyId INTEGER NOT NULL,
CONSTRAINT FK_JOB_COMPID FOREIGN KEY (companyId) REFERENCES COMPANY(companyId) ON DELETE CASCADE,
CONSTRAINT fk_sIdScreen FOREIGN KEY (studentId) REFERENCES STUDENT (studentId) ON DELETE CASCADE
);

CREATE TABLE INTERVIEW(
companyId INTEGER NOT NULL, 
jobId INTEGER NOT NULL,
studentId VARCHAR(10) NOT NULL,
PRIMARY KEY (studentId, companyId),
CONSTRAINT sInterviewUnique UNIQUE(companyId,studentId),
CONSTRAINT fk_cIdIntrvw FOREIGN KEY (companyId) REFERENCES COMPANY (companyId) ON DELETE CASCADE,
CONSTRAINT fk_sIdIntrvw FOREIGN KEY (studentId) REFERENCES STUDENT (studentId) ON DELETE CASCADE,
CONSTRAINT fk_jIdIntrvw FOREIGN KEY (jobId) REFERENCES JOB (jobId) ON DELETE CASCADE
);

CREATE TABLE ONCAMP_CONFIRMATION(
studentId VARCHAR(10) UNIQUE NOT NULL,
companyId INTEGER NOT NULL,
jobId INTEGER NOT NULL,
CONSTRAINT fk_sIdOncmpCnfn FOREIGN KEY (studentId, companyId) REFERENCES INTERVIEW (studentId, companyID) ON DELETE CASCADE,
CONSTRAINT fk_jIdOncmpCnfn FOREIGN KEY (jobId) REFERENCES JOB (jobId) ON DELETE CASCADE
);

CREATE TABLE OTHER_CONTACTS(
contactId INTEGER,
contactType VARCHAR(10) CHECK (contactType IN ('University', 'Company')), 
organisationName VARCHAR(40) NOT NULL,
field VARCHAR(30) NOT NULL,
eligibility VARCHAR(30),
pointOfContact VARCHAR(20) NOT NULL,
PRIMARY KEY(contactId)
);

CREATE TABLE INDEP_APPLICATION (
organisationId INTEGER,
studentId VARCHAR(10) NOT NULL,
organisationName VARCHAR(50) NOT NULL,
organisationType VARCHAR(10) CHECK (organisationType IN ('University', 'Company')),
internDetails VARCHAR(40),
PRIMARY KEY (organisationId, studentId),
CONSTRAINT fk_sIdIndpAppl FOREIGN KEY (studentId) REFERENCES STUDENT (studentId) ON DELETE CASCADE	
);

CREATE TABLE INDEP_CONFIRMATION(
studentId VARCHAR(10) NOT NULL,
confirmed CHAR(1) CHECK (confirmed IN ('Y', 'N')),
organisationId INTEGER NOT NULL,
CONSTRAINT fk_sIdIndpCnfm FOREIGN KEY (organisationId, studentId) REFERENCES INDEP_APPLICATION (organisationId, studentId) 
ON DELETE CASCADE
);
