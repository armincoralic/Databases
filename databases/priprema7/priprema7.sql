CREATE UNIQUE INDEX predOrgjed ON pred (nazPred, sifOrgjed);

-- DRUGI ZADATAK
CREATE TEMPORARY TABLE orgjedPred 
( 
sifOrgjed		INTEGER 	NOT NULL,
nazOrgjed		NCHAR(100) 	NOT NULL,
sifNadOrgjed 	INTEGER 	NOT NULL
);
CREATE TEMPORARY TABLE orgjedNast
(
sifOrgjed		INTEGER 	NOT NULL,
nazOrgjed		NCHAR(100) 	NOT NULL,
sifNadOrgjed 	INTEGER 	NOT NULL
);

CREATE UNIQUE INDEX sifraPred ON orgjedPred(sifOrgjed);
CREATE UNIQUE INDEX sifraNast ON orgjedNast(sifOrgjed);

INSERT INTO orgjedPred 
SELECT * FROM orgjed WHERE sifOrgjed IN (SELECT sifOrgjed FROM pred);

INSERT INTO orgjedNast 
SELECT * FROM orgjed WHERE sifOrgjed IN (SELECT sifOrgjed FROM nastavnik);
-- KRAJ ZADATKA

-- TRECI
CREATE TEMPORARY TABLE tabela 
(
serBr 	SERIAL,
ime		NCHAR(30)
);

INSERT INTO tabela VALUES (0, 'prvi');
INSERT INTO tabela VALUES (300, 'drugi');
INSERT INTO tabela VALUES (0, 'treci');

SELECT * FROM tabela;
-- KRAJ ZADATKA


-- CETVRTI
CREATE TEMPORARY TABLE nastTemp 
(
rbrNast			SERIAL,
sifNastavnik	INTEGER		NOT NULL,
imeNastavnik 	NCHAR(60)	NOT NULL,
prezNastavnik	NCHAR(60)	NOT NULL,
pbrStan			INTEGER		NOT NULL,
sifOrgjed		INTEGER 	NOT NULL,
koef			DECIMAL(3,2)	NOT NULL

);
DROP TEMPORARY TABLE nastTemp;
INSERT INTO nastTemp SELECT 0,nastavnik.*  FROM nastavnik;

CREATE TEMPORARY TABLE studT AS SELECT * FROM stud;
CREATE TEMPORARY TABLE predT AS SELECT * FROM pred;
CREATE TEMPORARY TABLE nasT AS SELECT * FROM nastavnik;
CREATE TEMPORARY TABLE ispitT AS SELECT * FROM ispit;

CREATE TEMPORARY TABLE predTT
(
sifPred 		INTEGER 		NOT NULL,
kratPred		NCHAR(100)		NOT NULL,
nazPred 		NCHAR(100)		NOT NULL,
sifOrgjed		INTEGER			NOT NULL,
upisanoStud		INTEGER			NOT NULL,
brojSatiTjedno	INTEGER
);
DROP temporary table predtt;
INSERT INTO predTT SELECT * FROM pred;
-- PETI
UPDATE predTT SET nazPred=CONCAT(kratPred, '-', nazPred);

SELECT * FROM predTT;


-- ZADATAK 6
UPDATE nasT SET koef=(koef-0.1*koef) WHERE sifNastavnik IN (SELECT sifNastavnik FROM ispit
WHERE ocjena>1
GROUP BY 1
HAVING AVG(ocjena)<2.2) OR sifNastavnik IN (SELECT sifNastavnik FROM ispit
WHERE ocjena=1
GROUP BY 1
HAVING COUNT(*)>8);

-- zadatak 7
UPDATE predT SET brojSatiTjedno=brojSatiTjedno+1 WHERE (brojSatiTjedno BETWEEN 1 AND 5)
AND sifPred IN (SELECT sifPred FROM ispit
WHERE datIspit>=DATE_ADD(curdate(), INTERVAL -15 YEAR) AND ocjena=1
GROUP BY 1
HAVING COUNT(*)>10);


-- zadatak 8
UPDATE predT SET brojSatiTjedno=brojSatiTjedno-1 WHERE sifPred IN (SELECT sifPred FROM ispit
WHERE ocjena=5
GROUP BY 1
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM ispit
WHERE ocjena=5
GROUP BY sifPred));

LOAD DATA INFILE "C:\Users\Armin\Desktop\tmp\stud.unl" INTO TABLE stud FIELDS TERMINATED BY '#'
LINES STARTING BY '\n' TERMINATED BY '#\r';
CREATE TABLE stud
 ( mbrStud INTEGER NOT NULL
 , imeStud NCHAR(25) NOT NULL
 , prezStud NCHAR(25) NOT NULL
 , pbrRod INTEGER
 , pbrStan INTEGER NOT NULL
 , datRodStud DATE
 , jmbgStud CHAR(13)
 );
 INSERT INTO stud 
 SELECT * FROM studT;
 SELECT * FROM stud;
CREATE UNIQUE INDEX studUnique ON stud (mbrStud);
-- zadatak 10
DELETE FROM studT WHERE prezStud RLIKE '^[aeiou]';
