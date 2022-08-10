SELECT DISTINCT c.ConsumerId, c.ConsumerName, c.ConsumerAddress
FROM Network as n, Consumer as c, Subscription as s
WHERE n.NetworkName = %1% AND s.SubscriptionStartYear = %2% AND c.ConsumerId = s.ConsumerId AND s.NetworkId = n.NetworkId
ORDER BY c.ConsumerId;