
# Towards "Big data"

## NoSQL

###  Introduction

- Facts
  - More and more data are collected (GAFA...)
  - Data are distributed
  - Data are becoming heteregeneous and barely structured
  - The relational model is not enough
- Needs
  - Highly distributed databases
  - Complex and heteregeneous objects
  - Large data volumes
    - hence Not Only SQL (noSQL)

### The relational model

- ACID constraints
  - Atomicity: all or nothing
  - Consistency: from a valid state to another valid state
  - Isolation: every query is executed as it was unique
  - Durability: once done, the update is recorded
- Those properties are difficult to keep in a highly distributed environment while keeping similar performances


### Distributed systems

- 3 main properties: CAP
  - Coherence: All nodes see the same data as the same time
  - Availability: Losing one node does prevent from running
  - Partition Tolerance: Once partitioned, only a total loss of network prevents from running
- CAP theorem (Brewer, 2000): in a distributed system, it is impossible to keep those 3 properties valid at the same time, you can choose at most 2 among 3

### NoSQL vs traditional relational DMS

\center\includegraphics[width=5cm]{fig/noSQL.pdf}


### Examples

\center\includegraphics[width=7cm]{fig/cap.pdf}


### Summary

- noSQL databases
  - Representing non relational data
  - Handling (very) large amount of data
  - Highly distributed data
  - Performance
  - No schema
  - Complex or imbricated data
  - Potential copy of data on several nodes
  - Not completely fulfilling ACID constraints
  - Availability is more important than Coherence
  - Few writes, lots of reads

### noSQL basis

- Main elements
  - Sharding: partitioning data on several servers
  - Consistent hashing: partitioning data on several servers which are themselved partitioned on a segment
  - Map Reduce: parallel programming model
  - MVCC: Multiple version consistency control
  - Vector-Clock: allows concurrent updating by timestamping of data

### Sharding

- Partitioning data on several servers
  - Horizontal partitioning = cutting the population
    - linked data remain on the same server
    - load balancing between servers
    - some nodes are duplicated between servers
  - Vertical partitioning = cutting by column

### Consistent hashing



## Big Data
