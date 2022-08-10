SELECT DISTINCT s.ConsumerId, r.TVShowEpisodeId, r.Score
FROM TVShowEpisodeReview as r, Subscription as s
WHERE s.ConsumerId = %1% AND s.SubscriptionId = r.SubscriptionId
ORDER BY r.TVShowEpisodeId;