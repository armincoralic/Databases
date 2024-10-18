CREATE DATABASE ac21165;
CREATE TABLE stud(
mbrStud NCHAR(8) NOT NULL,
prezStud NCHAR(20) NOT NULL,
imeStud NCHAR(20) NOT NULL,
datRodStud DATE,
pbrRodStud INTEGER,
adrStud NCHAR(40),
prosjOcjena DECIMAL(3, 2) NOT NULL
);

CREATE UNIQUE INDEX studentUnique ON stud (mbrStud);

SELECT * FROM stud;

INSERT INTO stud VALUES ('123', 'Coralic', 'Armin', '1111-11-1', '232323', 
'232323', '9.11');

INSERT INTO stud VALUES ('122', 'Gedza', 'Huso', '1111-11-1', '232323', 
'232323', '9.11');

INSERT INTO stud VALUES ('121', 'Dzenan', 'Dzeko', '1111-11-1', '232323', 
'232323', '9.11');

SELECT * FROM stud;

UPDATE stud SET mbrStud='101' WHERE mbrStud='121';

SELECT * FROM stud;

DELETE FROM stud WHERE mbrStud='101';

LOAD DATA INFILE '/tmp/studenti.unl' INTO TABLE stud FIELDS
TERMINATED BY '#' LINES TERMINATED BY '\n';

DROP TABLE stud;

DROP DATABASE ac21165;