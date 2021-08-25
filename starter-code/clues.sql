-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.

SELECT name FROM countries WHERE region = 'Southern Europe' ORDER BY population ASC LIMIT 5;
name Holy See
world=# SELECT name, population FROM countries WHERE region = 'Southern Europe';
population: 1000;
SELECT name, code FROM countries WHERE region = 'Southern Europe';
Holy See (Vatican Cities State) | VAT

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.

world=# SELECT language, isofficial FROM countrylanguages WHERE countrycode='VAT';
 language | isofficial 
----------+------------
 Italian  | t

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
--  nearby country speaks nothing but that language.

world=# SELECT countrycode, percentage FROM countrylanguages WHERE language ='Italian';
 countrycode | percentage 
-------------+------------
 ITA         |       94.1
 SMR         |        100
 VAT         |          0
 ARG         |        1.7
 AUS         |        2.2
 LIE         |        2.5
 BEL         |        2.4
 BRA         |        0.4
 LUX         |        4.6
 MCO         |       16.1
 CHE         |        7.7
 CAN         |        1.7
 FRA         |        0.4
 DEU         |        0.7
 USA         |        0.6
(15 rows)

world=# SELECT name FROM countries WHERE code='SMR';
    name    
------------
 San Marino
(1 row)


-- Clue #4: We're booking the first flight out – maybe we've actually t a chance to catch her this time.
 -- There are only two cities she could be flying to in the country. One is named the same as the country – that
 -- would be too obvious. We're following our gut on this one; find out what other city in that country she might
 --  be flying to.

world=# SELECT id, name, population FROM cities WHERE countrycode ='SMR';
  id  |    name    | population 
------+------------+------------
 3170 | Serravalle |       4802
 3171 | San Marino |       2294
(2 rows)



-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!
------------------+------
 Argentina        | ARG
 Bolivia          | BOL
 Bolivia          | BOL
 Brazil           | BRA
 Chile            | CHL
 Ecuador          | ECU
 Falkland Islands | FLK
 Guyana           | GUY
 Colombia         | COL
 Paraguay         | PRY
 Peru             | PER
 French Guiana    | GUF
 Suriname         | SUR
 Uruguay          | URY
 Venezuela        | VEN

world=# SELECT countrycode, name FROM cities WHERE name LIKE'Serra%';
 countrycode |    name    
-------------+------------
 BRA         | Serra
 SMR         | Serravalle
(2 rows)

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
 -- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
 -- follow right behind you!
world=# select name, capital FROM countries WHERE code = 'BRA';
  name  | capital 
--------+---------
 Brazil |     211
(1 row)
world=# SELECT name, district FROM cities WHERE id = '211';
   name   |     district     
----------+------------------
 Bras�lia | Distrito Federal


-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
 -- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
 -- landing dock.
-- Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.

-- Our play date of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.



-- She's in ____________________________!
world=# SELECT id, name, district FROM cities WHERE population = '91084';
  id  |     name     |  district  
------+--------------+------------
 4060 | Santa Monica | California
