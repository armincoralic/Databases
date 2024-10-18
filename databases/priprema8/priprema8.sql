START TRANSACTION;
SET autocommit=0;
ALTER TABLE nastavnik MODIFY sifOrgjed INTEGER;
ALTER TABLE nastavnik MODIFY pbrStan INTEGER;
ALTER TABLE nastavnik ADD CONSTRAINT FOREIGN KEY (sifOrgjed) REFERENCES orgjed (sifOrgjed);
ALTER TABLE nastavnik ADD CONSTRAINT FOREIGN KEY (pbrStan) REFERENCES mjesto (pbr);

-- PRVI ZADATAK
UPDATE nastavnik SET sifOrgjed = NULL
WHERE sifOrgjed = (SELECT sifOrgjed FROM orgjed
WHERE nazOrgjed='Zavod za primijenjenu fiziku'); -- 8 z.
UPDATE pred SET sifOrgjed = NULL
WHERE sifOrgjed = (SELECT sifOrgjed FROM orgjed
WHERE nazOrgjed='Zavod za primijenjenu fiziku'); -- 12 z.
CREATE TEMPORARY TABLE orgjedTmp AS SELECT * FROM orgjed;
UPDATE orgjed SET sifNadOrgjed = NULL
WHERE sifNadOrgjed = (SELECT sifOrgjed FROM orgjedTmp
WHERE nazOrgjed='Zavod za primijenjenu fiziku'); -- 2 z.
DELETE FROM orgjed WHERE nazOrgjed='Zavod za primijenjenu fiziku';

-- DRUGI ZADATAK
UPDATE nastavnik SET pbrStan=null
WHERE prezNastavnik LIKE 'J%' AND imeNastavnik LIKE 'D%';

-- TRECI ZADATAK
SELECT COUNT(*) FROM nastavnik
WHERE pbrStan IS NULL OR sifOrgjed IS NULL;

-- CETVRTI ZADATAK
SELECT COUNT(*) FROM pred WHERE sifOrgjed=100002;

SELECT COUNT(*) FROM pred WHERE sifOrgjed<>100002;

SELECT COUNT(*) FROM pred;

-- PETI ZADATAK
SELECT * FROM pred WHERE sifOrgjed IS NOT NULL;

-- SESTI ZADATAK
SELECT * FROM pred WHERE sifOrgjed IS NULL;

-- SEDMI ZADATAK
SELECT COUNT(*) FROM pred WHERE sifOrgjed IS NOT NULL;

-- OSMI ZADATAK
SELECT COUNT(DISTINCT sifOrgjed) FROM nastavnik;

-- DEVETI ZADATAK
SELECT brojSatiTjedno, sifOrgjed, COUNT(sifPred) FROM pred
GROUP BY 1,2;

-- DESETI ZADATAK
SELECT * FROM stud WHERE pbrStan NOT IN (SELECT DISTINCT pbrRod FROM stud
WHERE pbrRod IS NOT NULL);

-- JEDANAESTI ZADATAK
SELECT sifNastavnik, prezNastavnik, imeNastavnik, nastavnik.sifOrgjed,
	IF(nastavnik.sifOrgjed IS NULL, 'NULL', nazOrgjed) AS nazOrgjed
FROM nastavnik LEFT OUTER JOIN orgjed ON nastavnik.sifOrgjed=orgjed.sifOrgjed;

-- DVANAESTI ZADATAK
SELECT sifNastavnik, prezNastavnik, imeNastavnik, o.sifOrgjed, o.nazOrgjed, n.nazOrgjed
FROM nastavnik LEFT OUTER JOIN (orgjed o INNER JOIN orgjed n ON o.sifNadOrgjed=n.sifOrgjed)
ON nastavnik.sifOrgjed=o.sifOrgjed;

-- TRINAESTI ZADATAK 
SELECT sifNastavnik, prezNastavnik, imeNastavnik, pbr, nazMjesto, nastavnik.sifOrgjed,
nazOrgjed FROM nastavnik LEFT OUTER JOIN mjesto on nastavnik.pbrStan=mjesto.pbr
LEFT OUTER JOIN orgjed ON nastavnik.sifOrgjed=orgjed.sifOrgjed
ORDER BY 5, 2;

-- CETRNAESTI ZADATAK
SELECT sifNastavnik, imeNastavnik, prezNastavnik, pbr, nazMjesto, nazZupanija FROM nastavnik
LEFT OUTER JOIN (mjesto INNER JOIN zupanija ON mjesto.sifZupanija=zupanija.sifZupanija)
ON pbrStan=mjesto.pbr;

-- PETNAESTI ZADATAK
SELECT kratPred, nazPred, orgjed.sifOrgjed, nazOrgjed FROM pred
LEFT OUTER JOIN orgjed ON pred.sifOrgjed=orgjed.sifOrgjed
WHERE nazPred LIKE 'F%';

-- SESNAESTI
SELECT kratPred, nazPred, pred.sifOrgjed, nazOrgjed FROM pred
LEFT OUTER JOIN orgjed ON pred.sifOrgjed = orgjed.sifOrgjed
WHERE SUBSTRING(nazOrgjed,1,1) = 'Z' OR nazOrgjed IS NULL; 
