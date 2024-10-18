-- ZADATAK 1A
SELECT mbrstud, datprijava, ocjObrane(mbrstud, datprijava) AS UkupnaOcjena
FROM diplom;

-- ZADATAK 1B
SELECT diplom.mbrStud, imeStud, prezStud, 
ocjObrane(diplom.mbrStud, diplom.datPrijava) AS ukupnaOcjena
FROM stud INNER JOIN diplom ON stud.mbrStud=diplom.mbrStud WHERE 
ocjObrane(diplom.mbrStud, diplom.datPrijava)>1;

-- ZADATAK 1C
SELECT AVG(ocjObrane(mbrStud, datPrijava)) FROM diplom WHERE ocjObrane(mbrStud,datPrijava)>1;

-- ZADATAK 2A
DELIMITER //
CREATE FUNCTION prosjekOcjena()
	RETURNS DECIMAL(3,2)
	BEGIN
    DECLARE ocjena1 DECIMAL;
    
    IF @brojac IS NULL THEN
		SET @brojac=0;
	END IF;
    SET @brojac=@brojac+1;
    IF @brojac>1 THEN
		SET ocjena1=NULL;
	ELSE
		SET ocjena1 = (SELECT AVG(ocjena) FROM ispit WHERE ocjena>1);
	END IF;
    RETURN ocjena1;
    END //

-- ZADATAK 2A.2
DELIMITER //
CREATE FUNCTION brojNepristup()
	RETURNS INTEGER
    BEGIN
    DECLARE brojStud INTEGER;
    
    IF @brojac IS NULL THEN
		SET @brojac=0;
	END IF;
    SET @brojac=@brojac+1;
	IF @brojac>1 THEN
		SET brojStud=NULL;
	ELSE 
		SET brojStud=(SELECT COUNT(*) FROM stud
        WHERE NOT EXISTS (SELECT * FROM ispit WHERE mbrStud=stud.mbrStud));
	END IF;
	RETURN brojStud; 
    END//
    
-- ZADATAK 2B
DELIMITER //
CREATE FUNCTION vrijemePrvogPoziva()
	RETURNS CHAR(100)
    BEGIN
		DECLARE rez CHAR(100);
        DECLARE trenutno DATETIME;
        
        IF @prvo IS NULL THEN
			SET @prvo=SYSDATE();
		END IF;
        SET trenutno=SYSDATE();
        SET rez=CONCAT(@prvo, ',', trenutno);
        RETURN rez;
    END//
SELECT vrijemePrvogPoziva();

-- ZADATAK 3
DELIMITER //
CREATE PROCEDURE najboljih_n(n INTEGER)
	BEGIN
		SELECT stud.mbrStud, prezStud, imeStud, AVG(ocjena) FROM stud INNER JOIN ispit ON
        stud.mbrStud=ispit.mbrStud
        GROUP BY 1,2,3
        ORDER BY 4 DESC, 2, 3
        LIMIT n;
	END//
DROP PROCEDURE najboljih_n;
CALL najboljih_n(10);














