--Dentist office
--Mason LaBruyere, Connor Gillman, Adam Schonhoff

--Create the databse
CREATE DATABASE dentist;

--Use database dentist
USE dentist;

--Create tables

/*
Patient
no foreign keys so it can be inserted first
*/
CREATE TABLE patient (
	patient_id SMALLINT IDENTITY (1000, 1) CONSTRAINT pk_patient PRIMARY KEY,
	patient_first VARCHAR (25),
	patient_last VARCHAR (25),
	patient_address VARCHAR (35),
	patient_city VARCHAR (25),
	patient_state CHAR (2),
	patient_zip CHAR (5),
	patient_phone CHAR (10),
	patient_ssn CHAR (9),
	patient_dob DATE,
	patient_gender CHAR (1)
);

/*
Procedure (named pro)
no foreign keys so it can be inserted first
*/

CREATE TABLE pro (
	pro_id SMALLINT IDENTITY (1, 1) CONSTRAINT pk_pro PRIMARY KEY,
	pro_name VARCHAR (25) NOT NULL,
	pro_charge MONEY NOT NULL
);

/*
Supply
no foreign keys so it can be inserted first
example of a non-identity (sqlserver) pk
instead we are using letters
*/

CREATE TABLE supply (
	supply_id CHAR (1) CONSTRAINT pk_supply PRIMARY KEY,
	supply_name VARCHAR (25) NOT NULL
);

/*
Procedure & Supply intersection table
This table has foreign keys, so it will be inserted last
Couldn't use 'procedure' or 'proc' because of SQL server naming conventions
Used this syntax to insert foreign keys to make a composite primary
*/

CREATE TABLE pro_supply (
	ps_pro_id SMALLINT FOREIGN KEY REFERENCES pro(pro_id),
	ps_supply_id CHAR (1) FOREIGN KEY REFERENCES supply(supply_id)
);

/*
Visit
This table has foreign keys, so it will be inserted last
*/

CREATE TABLE visit(
	visit_id SMALLINT IDENTITY (100, 1) CONSTRAINT pk_visit PRIMARY KEY,
	visit_date DATE NOT NULL,
	visit_patient_id SMALLINT FOREIGN KEY REFERENCES patient(patient_id),
	visit_pro_id SMALLINT FOREIGN KEY REFERENCES pro(pro_id)
);

/*
Populate patient
We use INSERT INTO with columns specified due to auto increment of pk
*/

INSERT INTO patient (patient_first, patient_last, patient_address, patient_city, patient_state, patient_zip, patient_phone, patient_ssn, patient_dob, patient_gender) VALUES
	('Harriet', 'Maness', '9368 Hillcrest Street', 'Bucklin', 'MO', '64631', '4177716403', '237763124', '1954-6-16', 'F'),
	('Jess', 'Fraga', '30 Polygon St.', 'Oronogo', 'MO', '64855', '8168921621', '448299828', '2003-10-11', 'F'),
	('Arcelia', 'Ibarra', '35 Smoky Hollow Dr.', 'Scotts City', 'MO', '65756', '8168322641', '546754766', '1991-12-6', 'F'),
	('Kelli', 'Holiman', '128 Golden Star Ave.', 'Saginaw', 'MO', '64864', '3142802397', '390395751', '1929-5-4', 'F'),
	('Iona', 'Piatt', '8981 Galvin St.', 'Ionia', 'MO', '65335', '8169433490', '271523900', '2004-8-24', 'F'),
	('Bert', 'Llewellyn', '18 Autumn Street', 'Bernie', 'MO', '63822', '8168719454', '22941209', '1993-12-28', 'M'),
	('Loni', 'Asmussen', '6 Swanson St.', 'Eminence', 'MO', '65466', '5735989702', '807762312', '1991-12-6', 'F');

SELECT * FROM patient;

--Populate procedure, same scenario as patient
INSERT INTO pro (pro_name, pro_charge) VALUES
	('Braces', 3500),
	('Cleaning', 200),
	('Fillings and Repairs', 185),
	('Crowns and Caps', 1200),
	('Dentures', 950),
	('Extractions', 263),
	('Root Canal', 2550);

SELECT * FROM pro;

--Populate supply
INSERT INTO supply VALUES
	('A', 'Impression Materials'),
	('B', 'Impression Trays'),
	('C', 'Flouride and Cleaners'),
	('D', 'Numbing Agent'),
	('E', 'Crowns and Caps'),
	('F', 'Filling Material');

SELECT * FROM supply;

--Populate pro_supply
INSERT INTO pro_supply VALUES
	('1', 'A'),
	('1', 'B'),
	('2', 'C'),
	('3', 'D'),
	('4', 'E'),
	('4', 'D'),
	('5', 'A'),
	('5', 'B'),
	('6', 'D'),
	('7', 'F'),
	('7', 'D');

SELECT * FROM pro_supply;

--Populate visit
INSERT INTO visit (visit_patient_id, visit_pro_id, visit_date) VALUES
	(1000, 1, '2015-10-7'),
	(1000, 2, '2015-8-25'),
	(1001, 2, '2016-9-15'),
	(1001, 3, '2014-3-9'),
	(1002, 1, '2015-7-23'),
	(1002, 2, '2017-1-31'),
	(1002, 4, '2016-9-9'),
	(1003, 2, '2015-3-1'),
	(1003, 2, '2015-5-22'),
	(1003, 5, '2017-11-24'),
	(1003, 3, '2014-6-10'),
	(1004, 2, '2016-5-18'),
	(1004, 4, '2014-7-18'),
	(1004, 6, '2016-10-13'),
	(1004, 3, '2017-7-22'),
	(1005, 2, '2015-2-9'),
	(1005, 5, '2015-11-27'),
	(1005, 3, '2016-8-29'),
	(1006, 3, '2014-4-27'),
	(1006, 7, '2014-9-6');

SELECT * FROM visit;