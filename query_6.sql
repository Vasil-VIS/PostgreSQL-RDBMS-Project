-- compute average score in period
WITH avgScoreP AS (
SELECT AVG(avgR.AvgScore) as Score
FROM epInP as ep, AvgReview as avgR
WHERE ep.TVShowEpisodeAirDate >= %2% AND ep.TVShowEpisodeAirDate <= %3% AND ep.TVShowEpisodeId = avgR.TVShowEpisodeId 
),

-- show | nr of top episodes
topEpisodes AS (
SELECT ep.TVShowId, COUNT(ep.TVShowEpisodeId) as NrTopEpisodes
FROM epInP as ep, AvgReview as avgR, avgScoreP as avgP
WHERE ep.TVShowEpisodeAirDate >= %2% AND ep.TVShowEpisodeAirDate <= %3% AND ep.TVShowEpisodeId = avgR.TVShowEpisodeId AND avgR.AvgScore >= avgP.Score + 2
GROUP BY ep.TVShowId
)

-- maybe remove distinct
SELECT DISTINCT t.*
FROM topEpisodes as t
WHERE t.NrTopEpisodes >= %1%
ORDER BY t.TVShowId;