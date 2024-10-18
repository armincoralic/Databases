-- 1
SELECT sifNastavnik, imeNastavnik, prezNastavnik, koef FROM 
nastavnik;

-- 2
SELECT * FROM pred;

-- 3
SELECT distinct imeStud from stud;

-- 4
SELECT DISTINCT sifNastanvik FROM ispit WHERE sifpred=146 AND
ocjena=1;

-- 5
SELECT mbrStud FROM ispit WHERE sifpred=262 AND ocjena>1;

-- 6
SELECT preznastavnik, imenastavnik, 800*(koef+0.4) as Plata;

-- 7
SELECT preznastavnik FROM nastavnik WHERE 
800*(koef*0.4) BETWEEN 3500 AND 8000;

-- 8
SELECT prezNastavnik, SUBSTRING(imeNastavnik,1,1) FROM nastavnik;

-- 9
SELECT imestud, prezstud, CONCAT(SUBSTRING(imestud, 1, 1),'.',
SUBSTRING(prezstud,1,1),'.') FROM stud;

-- 10
SELECT * FROM ispit WHERE MONTH(datIspit)=7;

-- 11
SELECT * FROM ispit WHERE WEEKDAY(datIspit)=2 AND 
MONTH(datIspit)=8;

-- 12
SELECT mbrStud, ocjena, datIspit, CURDATE(), 
DATEDIFF(current_date(), datIspit) FROM ispit;

-- 13
SELECT * FROM stud WHERE datRodStud = DATE_ADD(datRodStud, INTERVAL -30 YEAR); 

-- 14
SELECT sifNastavnik, mbrStud, ocjena, STR_TO_DATE('1,1,2009','%d,%m,%Y') -
datIspit FROM ispit;

-- 15
SELECT mbrStud, sifPred, ocjena, DATE_ADD(datIspit, INTERVAL 4800 DAY) FROM
ispit WHERE DATE_ADD(datIspit, INTERVAL 4800 DAY) >= CURRENT_DATE;

-- 16
SELECT mbrStud, sifPred, ocjena, datIspit, ADDDATE(datIspit, INTERVAL 3 YEAR)
FROM ispit;

-- 17
SELECT oznDvorana, oznVrstaDan, sat, sifPred AS predmet FROM rezervacija;

-- 18
SELECT DISTINCT pbrrod, pbrstan FROM stud;
