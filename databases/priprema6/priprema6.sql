SELECT kratPred, nazPred, AVG(ocjena) FROM pred INNER JOIN
ispit ON pred.sifPred=ispit.sifPred WHERE
ocjena>1
GROUP BY ispit.sifPred, 1, 2;

SELECT COUNT(*), zupanija.sifZupanija FROM ispit 
INNER JOIN nastavnik ON
ispit.sifNastavnik=nastavnik.sifNastavnik 
INNER JOIN mjesto ON nastavnik.pbrStan=mjesto.pbr 
INNER JOIN
zupanija ON mjesto.sifZupanija=zupanija.sifZupanija WHERE
ocjena=1
GROUP BY 2;

SELECT DISTINCT imeNastavnik, COUNT(*) FROM nastavnik
INNER JOIN ispit ON nastavnik.sifNastavnik=ispit.sifNastavnik
WHERE 
ocjena>1
GROUP BY 1;

SELECT podOrgjed.sifOrgjed, podOrgjed.nazOrgjed, 
COUNT(*) FROM orgjed INNER
JOIN orgjed podOrgjed ON 
orgjed.sifnadOrgjed=podOrgjed.sifOrgjed
GROUP BY 1, 2;

SELECT stud.*, AVG(ocjena) FROM stud INNER JOIN ispit ON
stud.mbrStud=ispit.mbrStud WHERE 
ocjena>1
GROUP BY 1,2,3,4,5,6
HAVING AVG(ocjena)>3;

SELECT pbr, nazMjesto, COUNT(*) FROM stud INNER JOIN mjesto ON
stud.pbrStan=mjesto.pbr
GROUP BY 1, 2
HAVING COUNT(mbrStud)>2;

SELECT ispit.mbrStud, prezStud, 
CONCAT(SUBSTRING(prezStud, 1, 1),'.',SUBSTRING(imeStud,1,1),'.') FROM
stud INNER JOIN ispit ON stud.mbrStud=ispit.mbrStud
WHERE ocjena=1
GROUP BY 1, 2, 3, sifPred
HAVING COUNT(*)>=3;

SELECT mbrStud, ocjena FROM ispit 
GROUP BY 1,2
HAVING COUNT(DISTINCT nazMjesto)>1;

SELECT pbr, sifZupanija FROM mjesto
group by 1,2 
HAVING COUNT(DISTINCT nazMjesto)>1;

SELECT imeNastavnik FROM nastavnik
GROUP BY 1
HAVING COUNT(DISTINCT prezNastavnik)>1;

SELECT sifPred, datIspit, ocjena FROM ispit
GROUP BY 1, 2, 3 
HAVING COUNT(DISTINCT mbrStud)>1;

SELECT imeStud, prezStud, COUNT(*) FROM ispit INNER JOIN stud
ON ispit.mbrStud=stud.mbrStud WHERE
ocjena>1
GROUP BY ispit.mbrStud, 1,2
ORDER BY 3 DESC, 2, 1;

CREATE TEMPORARY TABLE mjestoTmp AS
SELECT mjesto.*, COUNT(*) brojNast FROM mjesto INNER JOIN
nastavnik ON mjesto.pbr=nastavnik.pbrStan
GROUP BY 1, 2, 3;
SELECT * FROM mjestoTmp;

SELECT MONTH(datRodStud) mjesec, COUNT(*) FROM stud 
GROUP BY 1
ORDER BY 2 DESC;