SELECT DISTINCT mdir1.DirectorId
FROM AvgReview as r1, TVShowEpisode as ep1, MainDirectorOf as mdir1
WHERE EXISTS (
 SELECT mdir1.DirectorId
 FROM AvgReview as r2, TVShowEpisode as ep2, MainDirectorOf as mdir2
 WHERE ep1.TVShowEpisodeID = r1.TVShowEpisodeID AND ep1.TVShowEpisodeId = mdir1.TVShowEpisodeId
  AND ep2.TVShowEpisodeID = r2.TVShowEpisodeID AND ep2.TVShowEpisodeId = mdir2.TVShowEpisodeId
  AND mdir1.DirectorId = mdir2.DirectorId AND ep1.TVShowId <> ep2.TVShowId AND ABS(r1.AvgScore - r2.AvgScore) >= %1%
 ) 
ORDER BY mdir1.DirectorId;