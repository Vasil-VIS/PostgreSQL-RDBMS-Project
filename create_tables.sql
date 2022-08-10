CREATE UNLOGGED TABLE Network(
NetworkId int,
NetworkName varchar(70),
NetworkSummary varchar(200)
);
 
CREATE UNLOGGED TABLE TVShow(
TVShowId int,
TVShowName varchar(70),
TVShowSummary varchar(200),
NetworkId int
);

CREATE UNLOGGED TABLE TVShowEpisode(
TVShowEpisodeId int,
TVShowId int,
TVShowEpisodeAirDate date,
TVShowEpisodeNumberInSeason int
);

CREATE UNLOGGED TABLE Director(
DirectorId int,
DirectorName varchar(70),
DirectorAddress varchar(200),
DirectorYearOfBirth int,
DirectorGender char(1),
DirectorAnnualIncome int
);

CREATE UNLOGGED TABLE AssistantDirectorOf(
DirectorId int,
TVShowEpisodeId int
);

CREATE UNLOGGED TABLE MainDirectorOf(
DirectorId int,
TVShowEpisodeId int
);

CREATE UNLOGGED TABLE Consumer(
ConsumerId int,
ConsumerName varchar(70),
ConsumerAddress varchar(200),
ConsumerYearOfBirth int,
ConsumerGender char(1)
);

CREATE UNLOGGED TABLE Subscription(
SubscriptionId int,
ConsumerId int,
NetworkId int,
SubscriptionStartYear int
);

CREATE UNLOGGED TABLE TVShowEpisodeReview(
TVShowEpisodeId int,
SubscriptionId int,
Score int
);