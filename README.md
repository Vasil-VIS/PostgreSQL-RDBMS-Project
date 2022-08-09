# PostgreSQL RDBMS Project
Designing a relational schema, loading a dataset and optimizing for- and executing a query workload, using PosgreSQL.

## Input data
 - Network.csv (NetworkId, NetworkName, NetworkSummary): NetworkId is a unique positive integer. NetworkName is alphabetic, max 70 characters. It can include spaces, i.e., [ a-zA-Z]+. NetworkSummary is alphabetic, max 200 characters. It can include spaces, i.e., [ a-zA-Z]+. 
 Constraints & semantics
  - A tuple in this relation represents a distinct TV network and its associated attributes.
  - NetworkId uniquely identifies a network.
