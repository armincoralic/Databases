USE stusluarco;
SELECT * FROM zupanija;
SELECT * FROM mjesto;
SELECT * FROM stud;
-- ----------------------------------------------------------
SELECT DISTINCT sifZupanija FROM mjesto WHERE nazMjesto LIKE
'Z%';
-- ----------------------------------------------------------
SELECT * FROM stud WHERE datRodStud BETWEEN '1.5.1982' AND 
'1.9.1982' AND (prezStud LIKE 'R%' OR prezStud OR 'P%'
OR prezStud LIKE 'S%' OR prezStud LIKE 'V%');
-- ----------------------------------------------------------
SELECT * FROM stud WHERE datRodStud BETWEEN '1.5.1982' AND 
'1.9.1982' AND (prezStud RLIKE '^[RPSV]');
-- ----------------------------------------------------------
SELECT nazMjesto FROM mjesto WHERE nazMjesto NOT RLIKE
'^[AEIOU]' OR nazMjesto NOT RLIKE '[aeiou]$';
-- ----------------------------------------------------------
SELECT * FROM stud WHERE SUBSTRING(jmbgStud, 3, 2)<>MONTH(datRodStud)
OR SUBSTRING(jmbgStud, 1, 2)<>DAY(datRodStud)
OR SUBSTRING(jmbgStud, 5, 3)<>YEAR(datRodStud)-1000;
-- ----------------------------------------------------------
SELECT AVG(koef) FROM nastavnik WHERE pbrStan LIKE '10000';
-- ----------------------------------------------------------
SELECT min(datIspit), max(datIspit) FROM ispit;
-- ----------------------------------------------------------
SELECT COUNT(DISTINCT sifOrgjed) FROM nastavnik WHERE 
pbrStan=10000;
-- ----------------------------------------------------------
SELECT DATEDIFF(MAX(datRodStud),MIN(datRodStud)) FROM stud;
-- ----------------------------------------------------------
SELECT AVG(ocjena) FROM ispit WHERE YEAR(datIspit)=1999 AND
ocjena>1;
-- ----------------------------------------------------------
SELECT AVG(ocjena), COUNT(ocjena) FROM ispit WHERE sifPred=146 AND 
ocjena>1;
-- ----------------------------------------------------------
SELECT AVG(DATEDIFF(CURDATE(), datRodStud)) FROM stud WHERE pbrStan=10000
AND (imeStud RLIKE '^[AEIOU]' OR imeStud RLIKE '[aeiou]$');
-- ----------------------------------------------------------
SELECT COUNT(DISTINCT(sifPred)) FROM rezervacija WHERE oznDvorana LIKE
'B%' AND oznVrstaDan IN ('UT', 'SR');
-- ----------------------------------------------------------
SELECT COUNT(*), AVG(ocjena) FROM ispit
WHERE WEEKDAY(datIspit)=4 AND MONTH(datIspit)=7
AND year(datIspit)+5<=YEAR(current_date());
-- ----------------------------------------------------------
SELECT SUM(upisanoStud) FROM pred
WHERE brojSatiTjedno<3 AND nazPred LIKE '%tehnike%';