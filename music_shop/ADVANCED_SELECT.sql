/**
количество исполнителей в каждом жанре;
количество треков, вошедших в альбомы 2019-2020 годов;
средняя продолжительность треков по каждому альбому;
все исполнители, которые не выпустили альбомы в 2020 году;
названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
название альбомов, в которых присутствуют исполнители более 1 жанра;
наименование треков, которые не входят в сборники;
исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
название альбомов, содержащих наименьшее количество треков.
**/

SELECT genre_name, COUNT(ag.artist_id)
  FROM genres g
  JOIN artists_genres ag ON g.genre_id = ag.genre_id
 GROUP BY genre_name;
 
SELECT COUNT(track_id)
  FROM tracks t
  JOIN albums a ON t.album_id = a.album_id
 WHERE DATE_PART('year', release_date) BETWEEN 2019 AND 2020;
 
SELECT album_name, 
       FLOOR((AVG(duration))/60)||':'||
       TO_CHAR( MOD((AVG(duration)), 60), 'FM09') 
       AS avg_duration
  FROM albums a
  JOIN tracks t ON a.album_id = t.album_id
 GROUP BY album_name;
  
SELECT artist_name
  FROM artists ar
  JOIN albums_artists aa ON ar.artist_id = aa.artist_id 
  JOIN albums ab ON ab.album_id = aa.album_id 
 WHERE artist_name NOT IN 
       (SELECT artist_name 
          FROM artists ar2
          JOIN albums_artists aa2 ON ar2.artist_id = aa2.artist_id 
          JOIN albums ab2 ON ab2.album_id = aa2.album_id
         WHERE DATE_PART('year', release_date) = 2020)
 GROUP BY artist_name
 ORDER BY artist_name;

SELECT DISTINCT mix_name
  FROM mixes m
  JOIN tracks_mixes tm ON m.mix_id = tm.mix_id
  JOIN tracks t ON tm.track_id = t.track_id
  JOIN albums ab ON ab.album_id = t.album_id
  JOIN albums_artists aa ON ab.album_id = aa.album_id
  JOIN artists ar ON aa.artist_id = ar.artist_id
 WHERE artist_name ILIKE '%eminem%';

SELECT DISTINCT album_name
  FROM albums ab
  JOIN albums_artists aa ON ab.album_id = aa.album_id
  JOIN artists ar ON aa.artist_id = ar.artist_id
  JOIN artists_genres ag ON ar.artist_id = ag.artist_id
 WHERE ag.artist_id IN
       (SELECT ag2.artist_id
          FROM artists_genres ag2
         GROUP BY ag2.artist_id
        HAVING COUNT(ag2.artist_id) > 1);

SELECT track_name
  FROM tracks t
 WHERE t.track_id NOT IN
       (SELECT tm.track_id
          FROM tracks_mixes tm);

SELECT artist_name 
  FROM artists ar
  JOIN albums_artists aa ON ar.artist_id = aa.artist_id
  JOIN albums ab ON ab.album_id = aa.album_id
  JOIN tracks t ON ab.album_id = t.album_id
 WHERE t.track_id IN 
       (SELECT t.track_id
          FROM tracks t
         GROUP BY duration, t.track_id
        HAVING duration = 
               (SELECT MIN(duration)
                  FROM tracks));

SELECT DISTINCT album_name
  FROM albums ab
  JOIN tracks t ON t.album_id = ab.album_id
 WHERE t.album_id = (SELECT album_id
                      FROM tracks
                     GROUP BY album_id
                    HAVING COUNT(track_id) = (SELECT MIN(num_tracks)
                                               FROM (SELECT DISTINCT COUNT(track_id)
                                                 AS num_tracks
                                               FROM tracks
                                              GROUP BY album_id) AS subq));

 

          

  


 
