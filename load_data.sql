\COPY Network(NetworkId, NetworkName, NetworkSummary) FROM 'data\Network.csv' DELIMITER ',' CSV HEADER;

\COPY TVShow(TVShowId, TVShowName, TVShowSummary,NetworkId) FROM 'data\TVShow.csv' DELIMITER ',' CSV HEADER;

\COPY TVShowEpisode(TVShowEpisodeId,TVShowId, TVShowEpisodeAirDate, TVShowEpisodeNumberInSeason) FROM 'data\TVShowEpisode.csv' DELIMITER ',' CSV HEADER;

\COPY Director(DirectorId,DirectorName, DirectorAddress, DirectorYearOfBirth,DirectorGender,DirectorAnnualIncome) FROM 'data\Director.csv' DELIMITER ',' CSV HEADER;

\COPY AssistantDirectorOf(DirectorId,TVShowEpisodeId) FROM 'data\AssistantDirectorOf.csv' DELIMITER ',' CSV HEADER;

\COPY MainDirectorOf(DirectorId,TVShowEpisodeId) FROM 'data\MainDirectorOf.csv' DELIMITER ',' CSV HEADER;

\COPY Consumer(ConsumerId,ConsumerName,ConsumerAddress,ConsumerYearOfBirth,ConsumerGender) FROM 'data\Consumer.csv' DELIMITER ',' CSV HEADER;

\COPY Subscription(SubscriptionId,ConsumerId,NetworkId,SubscriptionStartYear) FROM 'data\Subscription.csv' DELIMITER ',' CSV HEADER;

\COPY TVShowEpisodeReview(TVShowEpisodeId,SubscriptionId,Score) FROM 'data\TVShowEpisodeReview.csv' DELIMITER ',' CSV HEADER;

ANALYZE VERBOSE;