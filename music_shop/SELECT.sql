/**    
название и год выхода альбомов, вышедших в 2018 году;
название и продолжительность самого длительного трека;
название треков, продолжительность которых не менее 3,5 минуты;
названия сборников, вышедших в период с 2018 по 2020 год включительно;
исполнители, чье имя состоит из 1 слова;
название треков, которые содержат слово "мой"/"my".
**/

SELECT album_name, DATE_PART('year', release_date)
  FROM albums
 WHERE release_date BETWEEN '2018-01-01' 
 						AND '2018-12-31';
 						
SELECT track_name, duration
  FROM tracks
 ORDER BY duration DESC
 LIMIT 1;
 
SELECT track_name, 
	   FLOOR(duration / 60) ||':'|| 
	   TO_CHAR(MOD(duration, 60), 'FM09') 
	   AS duration
  FROM tracks
 WHERE duration >= 210;
 
SELECT mix_name
  FROM mixes
 WHERE DATE_PART('year', release_date) BETWEEN 2018
 										   AND 2020;
 
SELECT artist_name
  FROM artists
 WHERE SPLIT_PART(artist_name, ' ', 2) = '';
 
SELECT track_name
  FROM tracks
 WHERE track_name ILIKE '%my%'
 	OR track_name ILIKE '%мой%';
 	  
