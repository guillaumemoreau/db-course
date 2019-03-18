
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
  - MVCC: Multiversion consistency control
  - Vector-Clock: allows concurrent updating by timestamping of data

### Sharding

- Partitioning data on several servers
  - Horizontal partitioning = cutting the population
    - linked data remain on the same server
    - load balancing between servers
    - some nodes are duplicated between servers
  - Vertical partitioning = cutting by column

### Consistent hashing

- Valid for horizontal partitioning only
- Data and servers are /hashed/ by the same function
- Data are mapped the server just behind on a ring representing the hash values


### Map-Reduce

- Parallel programming model for handling large datasets in a distributed environment
- Used by the big web players
  - indexing (Google)
  - spam detection (Yahoo)
  - Data mining (Facebook)
  - ...
- But also
  - space image analysis
  - bio-computing
  - weather forecasting
  - machine learning
  - ...

### Properties

- Load balancing between servers
- Transparent handling of data distribution, load balancing, fault tolerance...
- Improves performance by adding servers
- API available for several programming languages


### Principles

- Uses two operators
  - *Map*: handles a key-value pair to generate a pair of intermediary keys - values
  - *Reduce*: merges all intermediary values mapped to the same intermediary key
- How it works
  - iterate through a large number of records
  - extract something of interest from each record
  - regroup and sort all intermediary results
  - Aggregate results
  - Generate a final result

### Practically

- 2 functions are implemented
  - map(key,value) -> list(inter-key,inter-value)
  - reduce(inter-key,list(inter-value)) -> value
- 5 steps
  - initialisation
  - Map
  - Regrouping
  - Sort
  - Reduce

### Example

- Count the number of words contained in a file
- Classical approach
  - Iterate through lines
    - For each line, count the words and add
- Parallel version: synchronizing the sum process

### Example

- Map-Reduce approach
  1. *Initialisation*: line cutting for balancing between processes
  2. *Map*: processing a line=create a mapping (word, number of occurrences)
  3. *Regrouping*: group the number of occurrences for a same word
  4. *Sort*: Each process handles a word: it sums the number of occurrences
  5. *Reduce*: Regrouping the the pairs word-number of occurrences

### Example

\center\includegraphics[width=7cm]{fig/map-reduce.pdf}

### MVCC: mutiversion concurrency control

- Handles concurrent access to data, more specifically for updates
  - ticks old data
  - add a new version of data and timestamps them
  - regularly sweeps through data and deletes outdated data

### Server classes

- Key-Value model
  - Every object has a unique key
- Column model
  - Every line has numerous values
- Document model
  - Handling document collections
- Graph model
  - Handling multiple relationships between objects

### Key-value model

- somehow works like a traditional hash table
- Data are represented by a (key,value) pair
- Access to a data is possible through its key


### Pros and cons

- Pros
  - Simple model
  - Horizontal partitioning eased
    - can change the number of servers
    - availability
    - no significant maintenance when changing column number
- Cons
  - Too simple!
    - poor for handling complex data
    - query only on keys
    - forwards complexity to the application

### Server examples

- Voldemort: https://www.project-voldemort.com/voldemort/
- Redis: https://redis.io
- Riak: https://riak.com/products/riak-ts/
- DynamoDB: https://aws.amazon.com/fr/dynamodb/
- ....

### Column model

- Data are stored on a column-basis rather than a line-basis
- Model close to relational model ... but with a dynamic number of columns which does not have to be identical between lines
- Data of a same column can be compressed when they /look the same/
- We can distinguish between:
  - column: data field, defined a (key,value) pair
  - column family: can group columns or super-columns
  - super-column: used as the lines of a join table in a relational model

### Pros and cons

- Pros
  - handles semi-structured data
  - naturally indexed (columns)
  - scales up horizontally
- Cons
  - Should be avoided if data are too much connected
  - Should be avoided if data are complex
  - Maintenance required in case columns are added/removed
  - A forecast on the queries is necessary to design the model

### Server examples

- Hadoop/Hbase: https://hadoop.apache.org, https://hbase.apache.org
- Cassandra: http://cassandra.apache.org
- Hypertable: http://www.hypertable.org

### Document model

- Stores a collection of documents
- Based on the (key,value) model, the value itself being a document
- Documents does not have a schema but a tree-like structure. They contain a list of fields along with their values
- The fields of a document are not necessarily predefined
- Documents can be heterogeneous
- Allows to query on documents content
- Mainly used in CMS

### Pros and cons

- Pros
  - Simple but powerful data model
  - Scales up well
  - No maintenance for adding/removing columns
  - Can perform complex queries
- Cons
  - Cannot be used for connected data
  - Query model limited
  - Can be slow

### Server examples

- MongoDB: https://www.mongodb.com
- CouchDB: http://couchdb.apache.org
- CouchBase: https://www.couchbase.com


### Graph model

- Model  the storage and the handling of complex data linked by non trivial and/or variable relationships
- Based on graph theory
  - Relies on nodes, relationships and properties
- Uses
  - a storage engine for objects
  - a specific mechanism for describing the edges (the relationships between objects)
- More efficient than relational databases for network problems

### Pros and cons

- Pros
  - Powerful data model
  - Fast for linked data
  - Powerful query model
- Cons
  - Data fragmentation

### Server examples

- Neo4J: https://neo4j.com
- InfiniteGraph: https://www.objectivity.com/products/infinitegraph/
- DEX/Sparksee: http://www.sparsity-technologies.com
- OrientDB: https://orientdb.com

## Big Data
