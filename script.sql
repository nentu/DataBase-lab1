CREATE TABLE ITEM(
	ITEM_ID serial PRIMARY KEY,
	ITEM_NAME char(20) NOT NULL,
	DESCRIPTION text
);

CREATE TABLE BODY_PART(
	BODY_PART_ID serial PRIMARY KEY,
	PART_NAME char(25) NOT NULL
);

CREATE TABLE PERSON(
	PERSON_ID serial PRIMARY KEY,
	PERSON_NAME char(25) NOT NULL,
	PERSON_AGE smallint NOT NULL
						CHECK(PERSON_AGE > 0),
	PROFESSION_NAME char(50) NOT NULL,
	ITEM_ID integer UNIQUE REFERENCES ITEM ON DELETE SET NULL
);

CREATE TABLE BODY_PART_ACTION(
	PERSON_ID integer REFERENCES PERSON,
	BODY_PART_ID integer REFERENCES BODY_PART UNIQUE,
	ACTION_NAME text NOT NULL
);

CREATE TABLE FLASHLIGHT(
	FLASHLIGHT_ID serial PRIMARY KEY,
	LAMP_TYPE char(20)
);

CREATE TABLE SHIP(
	SHIP_ID serial PRIMARY KEY,
	SHIP_NAME char(50),
	SHIP_TYPE char(25),
	FLASHLIGHT_ID integer UNIQUE REFERENCES FLASHLIGHT ON DELETE SET NULL
);

CREATE TABLE PORT(
	PORT_ID serial PRIMARY KEY,
	PERSON_ID integer REFERENCES PERSON(PERSON_ID) ON DELETE SET NULL,
	SHIP_ID integer REFERENCES SHIP(SHIP_ID) ON DELETE SET NULL,
	PORT_NAME char(25) NOT NULL,
	SITY_NAME char(25) NOT NULL
);

CREATE TABLE WACHED_SHIP (
	PERSON_ID integer REFERENCES PERSON ON DELETE CASCADE,
	SHIP_ID integer REFERENCES SHIP ON DELETE CASCADE,
	PRIMARY KEY (PERSON_ID, SHIP_ID)
);

CREATE TABLE TIME(
	TIME_NAME char(25) PRIMARY KEY,
	START_TIME time,
	END_TIME time,
	UNIQUE(START_TIME, END_TIME)
);

CREATE TABLE LIGHTS_ON_TIME (
	FLASHLIGHT_ID integer REFERENCES FLASHLIGHT ON DELETE CASCADE,
	TIME_NAME char(25) REFERENCES TIME ON DELETE CASCADE,
	PRIMARY KEY (FLASHLIGHT_ID, TIME_NAME)
);

INSERT INTO ITEM (ITEM_NAME, DESCRIPTION)
VALUES
	('binoculars', 'item for super vision'),
	('book', 'book with pictures'),
	('gun', 'personnel gun'),
	('map', 'map of this place');

INSERT INTO BODY_PART(PART_NAME)
VALUES
	('hand'),
	('head'),
	('leg'),
	('elbow');


INSERT INTO PERSON(PERSON_NAME, PERSON_AGE, PROFESSION_NAME, ITEM_ID)
VALUES
	('Artem', 22, 'student', NULL),
	('Grant', 43, 'archaeologist', 2);

INSERT INTO BODY_PART_ACTION(PERSON_ID, BODY_PART_ID, ACTION_NAME)
VALUES
	(2, 4, 'push out'),
	(1, 1, 'shake'),
	(2, 3, 'tap');

INSERT INTO FLASHLIGHT(LAMP_TYPE)
VALUES
	('LED'),
	('LED'),
	('LED'),
	('incandescent lamp'),
	('incandescent lamp'),
	('incandescent lamp');

INSERT INTO SHIP(SHIP_NAME, SHIP_TYPE, FLASHLIGHT_ID)
VALUES
	('Titanic', 'passenger ship', 1),
	('Titanic', 'passenger ship', 4),
	('black Pearl', 'Pirates ship', 5),
	('black Pearl', 'Pirates ship', 6),
	('Gilda', 'vessel', 2),
	('Gilda', 'vessel', 3);

INSERT INTO PORT (PERSON_ID, SHIP_ID, PORT_NAME, SITY_NAME)
VALUES
	(2, 1, 'sevkabel', 'Saint Petersburg'),
	(2, 5, 'sevkabel', 'Saint Petersburg'),
	(1, 3, 'Samara river port', 'Samara');
	
INSERT INTO WACHED_SHIP (PERSON_ID, SHIP_ID)
VALUES
	(1, 3),
	(2, 5);

INSERT INTO TIME (TIME_NAME, START_TIME, END_TIME)
VALUES
	('twilight', '16:38:00', '18:23:00'),
	('night', '18:23:00', '07:58:00');

INSERT INTO LIGHTS_ON_TIME(FLASHLIGHT_ID, TIME_NAME)
VALUES
	(2, 'twilight'),
	(3, 'twilight'),
	(5, 'night'),
	(6, 'night');