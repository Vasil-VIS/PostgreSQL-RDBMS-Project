--primary keys
ALTER TABLE Network ADD PRIMARY KEY (NetworkId);
ALTER TABLE TVShow ADD PRIMARY KEY (TVShowId);
ALTER TABLE Director ADD PRIMARY KEY (DirectorId);
ALTER TABLE Consumer ADD PRIMARY KEY (ConsumerId);
ALTER TABLE Subscription ADD PRIMARY KEY (SubscriptionId);
ALTER TABLE TVShowEpisode ADD PRIMARY KEY (TVShowEpisodeId);

--q1:
CREATE INDEX idx_sub_net ON Subscription(NetworkId);

--q4 and q5:
CREATE INDEX idx_rev_sub ON TVShowEpisodeReview(SubscriptionId);
CREATE INDEX idx_sub_con ON Subscription(ConsumerId);

--q5:
CREATE INDEX idx_mdir_ep ON MainDirectorOf(TVShowEpisodeId);

--q7:
CREATE INDEX idx_ass_ep ON AssistantDirectorOf(TVShowEpisodeId);
CREATE INDEX idx_show_name ON TVShow(TVShowName);
CREATE INDEX idx_air_date ON TVShowEpisode(TVShowEpisodeAirDate);

--for quiery 2, 5, 6:
--for each episode its avg score
CREATE MATERIALIZED VIEW AvgReview(TVShowEpisodeId, AvgScore) AS 
 SELECT r.TVShowEpisodeId, AVG(r.Score)
 FROM TVShowEpisodeReview as r
 GROUP BY r.TVShowEpisodeID;
 
--q5:
CREATE INDEX idx_avg_ep ON AvgReview(TVShowEpisodeId);

--for quiery 3
CREATE MATERIALIZED VIEW q3(DirectorGender, DirectorYearOfBirth, AverageScore) AS
 SELECT d.DirectorGender, d.DirectorYearOfBirth, AVG(r.Score) as AverageScore
 FROM Director as d, MainDirectorOf as mdir, TVShowEpisodeReview as r
 WHERE d.DirectorId = mdir.DirectorId AND mdir.TVShowEpisodeId = r.TVShowEpisodeId
 GROUP BY CUBE (d.DirectorGender, d.DirectorYearOfBirth)
 ORDER BY d.DirectorGender, d.DirectorYearOfBirth;

--for quiery 6
CREATE MATERIALIZED VIEW epInP(TVShowId, TVShowEpisodeId, TVShowEpisodeAirDate) AS 
 SELECT ep.TVShowId, ep.TVShowEpisodeId, ep.TVShowEpisodeAirDate
 FROM TVShowEpisode as ep
 WHERE ep.TVShowEpisodeAirDate >= '2018-01-01' AND ep.TVShowEpisodeAirDate <= '2020-12-31';