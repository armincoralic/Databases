USE stusluarco;

SELECT * FROM stud 
WHERE mbrStud NOT IN (SELECT mbrStud FROM ispit WHERE
ocjena=1);

SELECT * FROM stud
WHERE mbrStud NOT IN
(SELECT DISTINCT mbrStud FROM ispit
WHERE ocjena>= (SELECT AVG(ocjena) FROM ispit WHERE 
ocjena>1));

SELECT * FROM mjesto
WHERE pbr NOT IN (SELECT pbrStan FROM stud)
AND pbr NOT IN (SELECT pbrRod FROM stud);

SELECT * FROM ispit
WHERE mbrStud IN (SELECT mbrStud FROM stud WHERE 
pbrStan IN (SELECT pbr FROM mjesto WHERE 
nazMjesto='Koprivnica'));

SELECT * FROM stud WHERE mbrStud 
NOT IN (SELECT mbrStud FROM ispit WHERE 
ocjena>1 AND sifPred NOT IN (SELECT sifOrgjed FROM orgjed
WHERE 
nazOrgjed='Zavod za primijenjeno računarstvo'));

SELECT * FROM ispit 
WHERE mbrStud NOT IN 
(SELECT mbrStud FROM ispit INNER JOIN nastavnik
ON ispit.sifNastavnik=nastavnik.sifNastavnik 
INNER JOIN
orgjed ON nastavnik.sifOrgjed=orgjed.sifOrgjed WHERE
ocjena>1 AND nazOrgjed='Zavod za primijenjeno računarstvo');

SELECT kratPred, nazPred FROM pred
WHERE sifPred NOT IN (SELECT upisanoStud FROM pred INNER JOIN
ispit ON pred.sifPred=ispit.sifPred WHERE 
upisanoStud>(ocjena>1));