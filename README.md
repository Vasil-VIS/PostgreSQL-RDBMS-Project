# PostgreSQL RDBMS Project
Designing a relational schema, loading a dataset and optimizing for- and executing a query workload, using PosgreSQL.

## Data
The data is available [here](https://drive.google.com/drive/folders/1s6RCpD-7BdDrkc4r3joF1hQs6IjCjAbI).

## Description of data
 - Network.csv (NetworkId, NetworkName, NetworkSummary): 
    - NetworkId is a unique positive integer. NetworkName is alphabetic, max 70 characters. It can include spaces, i.e., [ a-zA-Z]+. NetworkSummary is alphabetic, max 200 characters. It can include spaces, i.e., [ a-zA-Z]+. 
    - Constraints & semantics: A tuple in this relation represents a distinct TV network and its associated attributes. NetworkId uniquely identifies a network.
 
 - TVShow.csv (TVShowId, TVShowName, TVShowSummary, NetworkId)
    - TVShowId is a unique positive integer. TVShowName is alphanumeric, max 70 characters. It can include spaces, i.e., [ a-zA-Z]+. TVShowSummary is alphanumeric, max 200 characters. It can include spaces, i.e., [ a-zA-Z]+. NetworkId is a foreign key to Network.
    - Constraints & semantics: A tuple in this relation represents a distinct TV show and its associated attributes. TVShowId uniquely identifies a TV show. Hence a show is associated with exactly one network. There is at least one TV show for every network. TVShowName is distinct amongst all TV shows (i.e., there are no two different TV shows with an identical name).

 - TVShowEpisode.csv (TVShowEpisodeId, TVShowId, TVShowEpisodeAirDate, TVShowEpisodeNumberInSeason)
    - TVShowEpisodeId is a unique positive integer. TVShowId is a foreign key to TVShow. TVShowEpisodeAirDate is alphanumeric and follows the format YYYY-MM-DD (e.g., January 31st, 2021 would be 2021-01-31). TVShowEpisodeNumberInSeason is an integer between 1 and 1000. It denotes the number of an 
episode in its season (e.g., the first episode of a season will have number 1, the second 2 etc.)
    - Constraints & semantics: A tuple in this relation represents a distinct TV show episode and its associated attributes. TVShowEpisodeId uniquely identifies an episode. An episode is associated with exactly one TV show and there is at least one episode for every TV show. TV show seasons are defined implicitly by the air dates of their episodes. All episodes that aired in the same year belong to the same season. Any two episodes that aired in different years belong to different seasons. For any TV show season with N episodes, there exists exactly one episode with TVShowEpisodeNumberInSeason = I for all I between 1 and N.
    
 - Director.csv (DirectorId, DirectorName, DirectorAddress, DirectorYearOfBirth, DirectorGender, DirectorAnnualIncome)
    - DirectorId is a unique positive integer. DirectorName is alphabetic, max 70 characters. It can include spaces, i.e., [ a-zA-Z]+. DirectorAddress is alphanumeric, max 200 characters. It can include spaces, i.e., [ a-zA-Z0-9]+. DirectorYearOfBirth is a positive integer, less than 3000. DirectorGender is a character (M or F). DirectorAnnualIncome is a positive integer.
    - Constraints & semantics: A tuple in this relation represents a distinct director and her associated attributes. DirectorId uniquely identifies a director.

 - MainDirectorOf.csv (DirectorId, TVShowEpisodeId)
    - DirectorId is a foreign key to Director. TVShowEpisodeId is a foreign key to TVShowEpisode.
    - Constraints & semantics: A tuple in this relation represents the fact that the director with id DirectorId is the  main director of the TV show episode with id TVShowEpisodeId. For every TV show episode, there is exactly one director that is the main director for that  episode. A director may be the main director of any number of (including zero) episodes.

 - AssistantDirectorOf.csv (DirectorId, TVShowEpisodeId)
    - DirectorId is a foreign key to Director. TVShowEpisodeId is a foreign key to TVShowEpisode.
    - Constraints & semantics: A tuple in this relation represents the fact that the director with id DirectorId is an assistant director of the TV show episode with id TVShowEpisodeId. There can be any number of (including zero) assistant directors for an episode. A director may be an assistant director for any number of (including zero) episodes. A director can be an assistant director for a particular episode at most once. Every director contained in the Director relation, is a main director or an assistant director for at least one episode.

 - Consumer.csv (ConsumerId, ConsumerName, ConsumerAddress, ConsumerYearOfBirth, ConsumerGender)
    - ConsumerId is a unique positive integer. ConsumerName is alphabetic, max 70 characters. It can include spaces, i.e., [ a-zA-Z]+. ConsumerAddress is alphabetic, max 200 characters. It can include spaces, i.e., [ a-zA-Z0-9]+. ConsumerYearOfBirth is a positive integer, less than 3000. ConsumerGender is a character (M or F).
    - Constraints & semantics: A tuple in this relation represents a distinct consumer and her associated attributes. ConsumerId uniquely identifies a consumer.

 - Subscription.csv (SubscriptionId, ConsumerId, NetworkId, SubscriptionStartYear)
    - SubscriptionId is a unique positive integer. ConsumerId is a foreign key to Consumer. NetworkId is a foreign key to Network. SubscriptionStartYear is a positive integer, less than 3000.
    - Constraints & semantics: A tuple in this relation represents an ongoing subscription that a consumer has with a 
network. SubscriptionId uniquely identifies a subscription. Every consumer has at least one subscription. A consumer can have multiple subscriptions, but only one per network. Every network has at least one subscriber (i.e., there exists at least one consumer that has a subscription for that network).

 - TVShowEpisodeReview.csv (TVShowEpisodeId, SubscriptionId, Score)
    - TVShowEpisodeId is a foreign key to TVShowEpisode. SubscriptionId is a foreign key to Subscription. Score is an integer between 1 and 10 (inclusive).
    - Constraints & semantics: A tuple in this relation represents a review of an episode associated with a particular subscription and score. There can be any number of (including zero) reviews per episode.
    - There can be any number of (including zero) reviews per subscription, but at most one for a particular episode per subscription (i.e., a consumer can review a particular episode only once).

## Loading data
 - create_tables.sql creates the tables according to a schema based on the description of the data
 - load_data.sql which reads the input files (such as Network.csv, TVShow.csv, etc.) and inserts the data into the tables that have just been created.
 - verification_query_1.sql solves the following task:
     - For the TV show episode with TVShowEpisodeId equal to 1, return the following attributes in the described order: All attributes for the episode, the TV show, the network on which this episode was broadcast, and the director that was the main director for the episode.
 - verification_query_2.sql solves the following task:
     - For the director with DirectorId equal to 2790847 return all attributes describing the episodes for which this director was an assistant director.
 - verification_query_3.sql solves the following task:
     - For the consumer with ConsumerId equal to 6943, return the consumer's name and the average review score of all the reviews given by the consumer, considering all their subscriptions.

## Optimize database for an Expected Workload
 - build_structures.sql creates indices, views, and performs other type of operations that improve query performance.
 - query_1.sql solves the following task:
     - Returns the consumer ids, names and addresses of those consumers that have a subscription with network named %1%, which started in year %2%. The results are ordered by consumer id and contain no duplicates. The query will be executed 50 times with different parameter values.
 - query_2.sql solves the following task:
     -  A director is said to have performed inconsistently in the past when he was the main director for at least two different TV shows with inconsistent reviews. Two TV shows are said to have inconsistent reviews if there exist two episodes, one for each show, such that the difference in the average review score for those episodes is at least %1% (e.g., at least 2 points). Return the ids of the directors that have performed inconsistently. The result should be ordered by director id and contain no duplicates. The parameter value %1% is between 4 and 6. The query will be executed 1 time.
 - query_3.sql solves the following task:
     -  Investigate the properties of main directors that influence their performance. The properties under consideration are a director's gender and year of birth. The criterion by which their performance is evaluated is the average review score of all episodes directed by a particular director. Write an SQL query that constructs a cube on these attributes in the aforementioned order. The results should be ordered by gender (Female precedes Male) and year of birth. This query will be executed 2 times.
 - query_4.sql solves the following task:
     -  Given a consumer id %1% as a parameter, return all review scores that this consumer gave through any subscription. The results should be ordered by episode id and contain no duplicates. This query will be executed 50 times with different parameter values.
 - query_5.sql solves the following task:
     -  Given a consumer id as parameter %1% and a number as parameter %2%, return the ids and names of main directors of at least two different episodes (not necessarily of the same show/network), and the score given by the consumer for these episodes was at least %2% higher than the average score of these episodes. The results should be ordered by director id and contain no duplicates. Parameter %2% should be between 2 and 4. This query will be executed 50 times with different parameters values.
 - query_6.sql solves the following task:
     -  Let X denote the average review score over all episodes that aired in a period P. A TV show is said to have top reviews if it has at least %1% episodes that aired in period P and have an average review score of at least X + 2. A period is given as two dates %2% and %3% of the format YYYY-MM-DD with %2% being the same or an earlier date than %3%. The following parameters are given: %1% the number of episodes that need to have received top reviews, and %2% and %3% two dates with %2% being the same or earlier date than %3%. Return the ids of TV shows and the number of episodes of that TV show with top reviews in the given period. The results should be ordered by TV show id and contain no duplicates. Parameter %1% should be between 3 and 5. Parameters %2% and %3% should be between 2018-01-01 and 2020-12-31 (both inclusive). This query will be executed 10 times with different parameter values.
 - query_7.sql solves the following task:
     -  Given a TV show name as parameter %1% and a TV show episode's air date as parameter %2%, return the ids, names, years of birth and genders of those directors that worked as assistant directors on the specified episode. The results should be ordered by director id and should not contain any duplicates. This query will be executed 50 times with different parameter values.

## Description of the optimization process
Primary keys were created on Network(NetworkId), TVShow(TVShowId), Director(DirectorId), Consumer(ConsumerId), Subscription(SubscriptionId), TVShowEpisode(TVShowEpisodeId) as they will be used to join the tables. The “EXPLAIN ANALYZE” command which showed which actions took the most time. Analyzing query 1 showed that almost all the runtime is taken by a parallel sequential scan on Subscription.NetworkId when joining the Subscription and Network tables on the NetworkId. Adding an index idx_sub_net on Subscription(NetworkId) solves this problem. Since queries 2, 5, 6 needed the average score for each episode, this information was pre-computed in a materialized view called “AvgReview”. Since query 3 is executed 2 times and since it does not depend on parameters it makes sense to compute the query in a materialized view called “q3”. By analyzing query 4 it was found that most of the time is taken by 2 parallel sequential scans (on TVShowEpisodeReview.SubscriptionId and on Subscription.ConsumerId). Adding indexes idx_sub_con on Subscription(ConsumerId) and index idx_rev_sub on TVShowEpisodeReview (SubscriptionId) improves the efficiency of the query. By analyzing query 5 it was seen that the parallel sequential scan on TVShowEpisodeReview for the parallel hash join on TVShowEpisodeReview.SubscriptionId and Subscription.SubscriptionId was expensive so the index idx_rev_sub was beneficial here. Furthermore, because of the search on Subscription (ConsumerId), the index idx_sub_con further improved the performance. The parallel sequential scan on MainDirectorOf for the parallel hash join on MainDirectorOf.TVShowEpisodeId and TVShowEpisodeReview.TVShowEpisodeId was expensive so the index idx_mdir_ep was created on MainDirectorOf(TVShowEpisodeId). Finally, the parallel sequential scan on AvgReview for the parallel hash join on AvgReview.TVShowEpisodeId and TVShowEpisodeReview.TVShowEpisodeId was expensive so the index idx_avg_ep was created on AvgReview(TVShowEpisodeId), which improved the performance further. Since for query 6 it is known that %2% and %3% are between 2018-01-01 and 2020-12-31, a view “epInP” was created that takes only the episodes in this range to make the repeated computation faster. Analyzing query 7 showed that the parallel sequential scan on AssistantDirectorOf for the parallel hash join on AssistantDirectorOf.TVShowEpisodeId and TVShowEpisode.TVShowEpisodeId was expensive so index idx_ass_ep was created on AssistantDirectorOf(TVShowEpisodeId). Because of the search on TVShow(TVShowName) and TVShowEpisode(TVShowEpisodeAirDate), the indexes idx_show_name on TVShow(TVShowName) and idx_air_date on TVShowEpisode(TVShowEpisodeAirDate) further improved the performance.

## Impact of the optimizations
For query 1 the index idx_sub_net takes around 5s to be created. Executing query 1 a single time locally takes around 600 ms without the index, while with the index it takes 30ms. The 50 runs are executed for 1s. For queries 2, 5, 6 “AvgReview” takes 45s to be made. Query 3 in the query_3.sql file, used the command “select * from q3;”. Thus, instead of computing the query 2 times for 2m30s, the view “q3”  is computed for around 1m15s and the result is fetched 2 times for around 200ms. For query 4 and 5 creating idx_sub_con takes around 40s and idx_rev_sub takes around 5s. Executing query 4 only once without these indexes takes 14s, while with them it takes 5ms. The 50 runs are executed for 359ms. For query 5 index idx_mdir_ep is created for 10s, and index idx_avg_ep takes 25s. Executing query 5 only once locally without these indexes takes 15s, while with them it takes 100ms. The 50 runs are executed for 4s. Executing query 6 only once locally without the “epInP” view takes 6s, while with the view it takes 3s. The view “epInP” is created for 1 second. The 10 runs are executed for 20s. For query 7 the indexes idx_ass_ep, idx_show_name and idx_air_date are created for 18s, 1s, 10s respectively. Executing query 7 only once locally without these indexes takes 4s, while with them it takes 8ms. The 50 runs are executed for 1s
