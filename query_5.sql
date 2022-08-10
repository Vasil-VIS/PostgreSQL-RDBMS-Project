SELECT DISTINCT d.DirectorId, d.DirectorName
FROM Director d, Subscription s1, Subscription s2, TVShowEpisode ep1, TVShowEpisode ep2, MainDirectorOf mdir1, MainDirectorOf mdir2,
TVShowEpisodeReview r1, TVShowEpisodeReview r2, AvgReview a1, AvgReview a2
WHERE s1.ConsumerId = %1% AND s2.ConsumerId = %1% AND s1.SubscriptionId = r1.SubscriptionId AND s2.SubscriptionId = r2.SubscriptionId 
AND r1.TVShowEpisodeId = ep1.TVShowEpisodeId AND r2.TVShowEpisodeId = ep2.TVShowEpisodeId AND ep1.TVShowEpisodeId <> ep2.TVShowEpisodeId
AND ep1.TVShowEpisodeId = mdir1.TVShowEpisodeId AND ep2.TVShowEpisodeId = mdir2.TVShowEpisodeId
AND mdir1.DirectorId = d.DirectorId AND mdir2.DirectorId = d.DirectorId AND a1.TVShowEpisodeId = r1.TVShowEpisodeId 
AND r1.Score >= %2%+a1.AvgScore AND a2.TVShowEpisodeId = r2.TVShowEpisodeId AND r2.Score >= %2%+a2.AvgScore
ORDER BY d.DirectorId;