CREATE TABLE USERLOGIN (
userEmail VARCHAR(20),
userPassword VARCHAR(130) NOT NULL,
userRoleId VARCHAR(2) NOT NULL,
PRIMARY KEY (userEmail)
CONSTRAINT FK_ROLE FOREIGN KEY userRoleId REFERENCES ROLE (roleID));

CREATE TABLE JOB (
jobId INTEGER,
jobName VARCHAR(30) NOT NULL,
jobType VARCHAR(1) CHECK (jobType IN ('I', 'F')),
jobLocation VARCHAR(10),
jobPay INTEGER,
jobEligibility VARCHAR(30),
jobBenefits VARCHAR(30),
PRIMARY KEY (jobID));

CREATE TABLE STUDENT (
studentId VARCHAR(10),
studentName VARCHAR(30) NOT NULL,
studentMobile INTEGER,
studentEmail VARCHAR(20) NOT NULL UNIQUE,
studentAddress VARCHAR(30),
studentPermAddress VARCHAR(30),
studentWorkExperience VARCHAR(30),
studentBatch VARCHAR(10),
studentBranch VARCHAR(15),
studentCGPA NUMBER(4,2),
studentResume VARCHAR(30),
resumeApproved VARCHAR(1) CHECK (resumeApproved IN ('Y','N')),
PRIMARY KEY (studentID)
CONSTRAINT FK_stuMail FOREIGN KEY (studentEmail) REFERENCES USERLOGIN (userEmail));

CREATE TABLE STAFF (
staffName VARCHAR(30),
staffEmail VARCHAR(20),
staffMobile INTEGER,
staffAddress VARCHAR(30),
staffPosition VARCHAR(10),
PRIMARY KEY (staffEmail)
CONSTRAINT FK_stafMail FOREIGN KEY (staffEmail) REFERENCES USERLOGIN (userEmail));

CREATE TABLE INDEPENDENT_APPLICATION (
organisationId INTEGER,
organisationName VARCHAR(20) NOT NULL,
internDetails VARCHAR(20),
applicationLetter VARCHAR(30) NOT NULL,
PRIMARY KEY (organisationID));

CREATE TABLE COMPANY_SCHEDULE (
companyId INTEGER,
deadline DATETIME,
testTime DATETIME,
testDuration INTEGER,
testType VARCHAR(1) CHECK (testType IN ('I','F','B')),
testEligibilityCGPA NUMBER(4,2),
testEligibilityBranch VARCHAR(15),
PRIMARY KEY (companyID, testTime),
CONSTRAINT FK_SCHD_COMPID FOREIGN KEY companyID REFERENCES COMPANY(companyID));
