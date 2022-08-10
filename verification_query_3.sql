SELECT c.ConsumerName, AVG(r.Score)
FROM Consumer as c, TVShowEpisodeReview as r, Subscription as s
WHERE c.ConsumerId = 6943 AND c.ConsumerId = s.ConsumerId AND s.SubscriptionId = r.SubscriptionId
GROUP BY c.ConsumerName;