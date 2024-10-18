CREATE TABLE diplom (
 mbrStud INTEGER NOT NULL
, datPrijava DATE NOT NULL -- datum prijave
, sifMentor INTEGER -- mentor (nastavnik)
, ocjenaRad SMALLINT -- ocjena pismenog rada
, datObrana DATE -- datum odbrane
, ukupOcjena SMALLINT -- ukupna ocjena diplomskog ispita
, PRIMARY KEY (mbrStud, datPrijava)
, FOREIGN KEY (mbrStud) REFERENCES stud (mbrStud)
, FOREIGN KEY (sifMentor) REFERENCES nastavnik (sifNastavnik)
);

LOAD DATA INFILE '/tmp/diplom.unl' INTO TABLE diplom FIELDS TERMINATED BY
'#' LINES STARTING BY '\n' TERMINATED BY '#\r';

CREATE TABLE dipkom (
 mbrStud INTEGER NOT NULL
, datPrijava DATE NOT NULL -- datum prijave
, sifNastavnik INTEGER NOT NULL
, oznUloga CHAR(1) -- uloga člana komisije
, ocjenaUsm SMALLINT -- ocjena usmenog ispita
, PRIMARY KEY (mbrStud, datPrijava, sifNastavnik)
, FOREIGN KEY (mbrStud, datPrijava) REFERENCES diplom (mbrStud,
datPrijava)
, FOREIGN KEY (mbrStud) REFERENCES stud (mbrStud)
, FOREIGN KEY (sifNastavnik) REFERENCES nastavnik (sifNastavnik)
); 

LOAD DATA INFILE '/tmp/dipkom.unl' INTO TABLE dipkom FIELDS TERMINATED BY '#' LINES
STARTING BY '\n' TERMINATED BY '#\r';

SET GLOBAL log_bin_trust_function_creators = 1;
-- log_bin_trust_function_creators = 1;


-- ZADATAK 1
DELIMITER //
CREATE FUNCTION orgjedNast (snastavnik INTEGER)
	RETURNS nchar(175)
	BEGIN
    DECLARE povrat nchar(175);
    SELECT CONCAT(imeNastavnik, '.', prezNastavnik, ':', O.nazOrgjed, '.', N.nazOrgjed)
		INTO povrat
        FROM nastavnik INNER JOIN orgjed O ON nastavnik.sifOrgjed=O.sifOrgjed
        INNER JOIN orgjed N ON O.sifNadorgjed=N.sifOrgjed
        WHERE sifNastavnik=snastavnik;
	RETURN povrat;
END//
SELECT orgjedNast(203);


-- ZADATAK 2
DELIMITER //
CREATE FUNCTION novKoef (snastavnik INTEGER)
	RETURNS DECIMAL(3,2)
    BEGIN 
    DECLARE koef1 DECIMAL(3,2);
    DECLARE brPoz INTEGER;
    DECLARE brNeg INTEGER;
    DECLARE prosPoz DECIMAL(3,2);
    DECLARE prosUkupno DECIMAL(3,2);
    
    SELECT koef INTO koef1 FROM nastavnik WHERE sifNastavnik=snastavnik;
    
    SELECT COUNT(*) INTO brPoz FROM ispit WHERE ocjena>1 AND sifNastavnik=snastavnik;
    
    SELECT COUNT(*) INTO brNeg FROM ispit WHERE ocjena=1 AND sifNastavnik=snastavnik;
    
    SELECT AVG(ocjena) INTO prosPoz FROM ispit 
    WHERE ocjena>1;
    
    SELECT AVG(ocjena) INTO prosUkupno FROM ispit INNER JOIN nastavnik ON 
    ispit.sifNastavnik=nastavnik.sifNastavnik AND sifNastavnik=snastavnik;
    
    IF(brPoz>brNeg AND prosPoz>prosUkupno) THEN
		SET koef1=koef1+koef1*0.1;
    ELSEIF(brNeg>brPoz AND prosPoz<prosUkupno) THEN 
		SET koef1=koef1-koef1*0.1;
	END IF;
    RETURN koef1;
	END//
SELECT novKoef(277); -- stari 3.50, novi 3.85 



 -- ZADATAK 3
 DELIMITER //
 CREATE FUNCTION ocjObrane1(matbr integer, datPrijave DATE)
	RETURNS Integer
    BEGIN
    DECLARE ukupnaOcjena INTEGER;
    DECLARE mentorOcjena INTEGER;
    DECLARE ocjenaIspitivac INTEGER;
    DECLARE brojNeupisanih INTEGER;
    DECLARE brojNegUpisanih INTEGER;
    
    SELECT ocjenaRad INTO mentorOcjena FROM diplom;
    SELECT ocjenaUsm INTO ocjenaIspitivac FROM dipkom;
    SELECT ocjenaRad INTO Uocjena FROM diplom WHERE mbrStud=matbr AND datPrijava=datPrijave;
   
	SELECT COUNT(*) INTO brojNeupisanih FROM dipkom INNER JOIN diplom ON 
    dipkom.mbrStud=diplom.mbrStud WHERE ocjenaUsm IS NULL AND ocjenaRad IS NULL;
    
    SELECT COUNT(*) INTO brojNegUpisanih FROM dipkom INNER JOIN diplom ON 
    dipkom.mbrStud=diplom.mbrStud WHERE ocjenaUsm=1 AND ocjenaRad=1;
    
    IF(mentorOcjena=1 OR ocjenaIspitivac=1) THEN
		SET ukupnaOcjena=1;
	ELSEIF NOT EXISTS(SELECT mbrStud FROM diplom WHERE mbrStud=matbr AND 
    datPrijava=datPrijave) THEN 
		SET ukupnaOcjena=NULL;
    END IF;
    
    END//
    



DELIMITER //
CREATE FUNCTION ocjObrane (mbrS INTEGER, datP DATE)
 RETURNS SMALLINT
 BEGIN
 DECLARE UOcjena SMALLINT;
 IF NOT EXISTS (SELECT mbrstud FROM diplom
 WHERE mbrstud=mbrs AND datPrijava=datP) THEN
 SET UOcjena = NULL;
 ELSE
 SELECT ocjenarad INTO UOcjena FROM diplom
 WHERE mbrstud=mbrs AND datPrijava=datP;
 IF UOcjena IS NULL THEN
 SET UOcjena=0;
 ELSEIF UOcjena <> 1 THEN
 IF (SELECT COUNT(*) FROM dipkom
 WHERE mbrstud=mbrs
 AND datPrijava=datP AND ocjenaUsm=1) > 0 THEN
 SET UOcjena=1;
 ELSEIF (SELECT COUNT(*) FROM dipkom
 WHERE mbrstud=mbrs AND datPrijava=datP) < 3 THEN
 SET UOcjena=0;
 ELSE
 SELECT AVG(ocjenaUsm) INTO UOcjena FROM dipkom
 WHERE mbrstud=mbrs AND datPrijava=datP;
 SET UOcjena = ROUND(UOcjena, 0);
END IF;
 END IF;
 END IF;
 RETURN UOcjena;
END//
SELECT ocjObrane(1127, '2045-01-21')




DELIMITER//
CREATE FUNCTION orgjedNast (maticni INTEGER)
	RETURNS NCHAR(100)
    BEGIN 
    DECLARE rez NCHAR(150);
    
    SELECT CONCAT(imeNastavnik,'.', prezNastavnik':', O.nazOrgjed, ',', N.nazOrgjed,'.')
    FROM nastavnik INNER JOIN orgjed O ON nastavnik.sifOrgjed=O.sifOrgjed INNER JOIN 
    nazOrgjed N ON nastavnik.sifOrgjed=N.siforgjed WHERE sifNastavnik=maticni;
    RETURN rez;
    END//
