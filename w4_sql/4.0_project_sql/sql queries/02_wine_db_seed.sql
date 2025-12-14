USE wine;
LOAD DATA INFILE '/Users/milenko/My Drive (1307mile@gmail.com)/bootcamp/w4/4.0_project/data/red.csv'
INTO TABLE red
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/Users/milenko/My Drive (1307mile@gmail.com)/bootcamp/w4/4.0_project/data/rose.csv'
INTO TABLE rose
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/Users/milenko/My Drive (1307mile@gmail.com)/bootcamp/w4/4.0_project/data/sparkling.csv'
INTO TABLE sparkling
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/Users/milenko/My Drive (1307mile@gmail.com)/bootcamp/w4/4.0_project/data/white.csv'
INTO TABLE white
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;