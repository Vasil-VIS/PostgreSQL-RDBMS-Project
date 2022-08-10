SELECT DISTINCT d.DirectorId, d.DirectorName, d.DirectorYearOfBirth, d.DirectorGender
FROM Director as d, AssistantDirectorOf as a, TVShowEpisode as ep, TVShow as s
WHERE s.TVShowName = %1% AND ep.TVShowEpisodeAirDate = %2% AND d.DirectorId = a.DirectorId AND a.TVShowEpisodeId = ep.TVShowEpisodeId AND ep.TVShowId = s.TVShowId
ORDER BY d.DirectorId;