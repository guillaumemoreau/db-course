
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

### Towards 'big data'

- Every day, 2.5 trillion bytes of data are generated
- 90% of data in the world have been generated in the last years
  - sensors
  - messages on social media
  - images and videos
  - online sales and advertising
  - GPS tracks
  - internet cookies
  - ...

### Example: SDSS

- Sloan Digital Survey
- 3D map of 1/3 of the canopy of heaven
  - 470 millions stars
  - 2000 galaxies
- 10 year project to understand the Milky way and discover exoplanets
- images: 1 peta-pixels ($10^{15} pixels)
  - 500000 HD screen for visualizing
  - 71 petabyte

### Other examples

- Deforestation: Planetary skin: 7Tb data
- Astronomy: LSST 30Tb / night
- Marine micro-organisms: GOS project 2Tb of data
- Biochemistry: BSrC 100 millions of molecules
- Liver cancer: ICGC project 200Tb of analysis data
- real time epidemiology
- ...

### Issues

- How to store such data volumes?
- How to make them available?
- How to process such data volumes?


### Big Data=Intersection of 3V

- Volume
  - Data volume are getting even bigger
- Variety
  - Data are more and more complex ... and less and less structured
- Velocity
  - Data are acquired (and processed) on the fly

### Volume

- Data storage price is still decreasing
- Several reliable storage solutions
- How to determine which data are worth storing?


### Variety

- Data are more and more non-structured (or semi-structured)
- Should data be stored under one or several format, type?
- "Outdated" data may be useful for making decisions
  - When/how to keep them?
  - Under what form?

### Velocity

- Data must be processed more and more rapidly (stock exchange...)
  - processing times, i.e. CPU issues
  - in the processing chain

## noSQL with Cassandra

### Cassandra

- Distributed database
- Initially used as Facebook internal messaging system
- Today maintained by Apache
- Widely used distributed database

### Principles

- Non-centralized database
  - no main node or /central server/
  - all nodes are equal
- Highly fault-tolerant
  - multiple node replication
- noSQL column model
  - rich Model
  - flexible

### Principles

- Why?
  - Handling *large* data volumes
  - Load balancing, availability
- How?
  - Data distribution (nodes can be added)
  - Data replication (can be reconfigured)
  - Consistency (can be reconfigured)
  - No master / slave architecture


### Technical stuff

- Apache 2.0 License
  - Open Source
- Written in java
- Data model based on
  - BigTable (Google)
  - DynamoDB (Amazon)
- Thrift interface
  - Ruby, Perl, Python, Scala, Java
  - CQL language (Cassandra Query Language)
- P2P based exchanges


### Architecture

- *Node*: instance of a server which stores data
- *Cluster*: Logical set which contains several nodes
  - no node is privileged inside a cluster
  - but there is a coordinator
- *Data Center*: Node sets

\center\includegraphics[height=3.5cm]{fig/cassandra-model.pdf}

### Data distribution

Node  | Line  | Key  |  Value  
--|---|---|--
1  | 3  | 1  | xxxx  
1  | 6  | 2  |  xxxx
1  | 7  | 3  |  xxxx
2  | 1  | 4  |  xxxx
2  | 2  | 5  |  xxxx
3  | 5  | 6  |  xxxx
3  | 4  | 7  |  xxxx


- Looking for the value mapped to key 5

### Node 2 is crashed

Node  | Line  | Key  |  Value  
--|---|---|--
1  | 3  | 1  | xxxx  
1  | 6  | 2  |  xxxx
1  | 7  | 3  |  xxxx
~~2~~  | ~~1~~  | ~~4~~  |  ~~xxxx~~
~~2~~  | ~~2~~  | ~~5~~  |  ~~xxxx~~
3  | 5  | 6  |  xxxx
3  | 4  | 7  |  xxxx

- Value mapped to key 5 cannot be reached


### Duplicating data on nodes

\tiny

Node  | Line  | Key  | Value  
--|---|---|--
1  | 3  |  1 |  xxxx
1  | 6  |  2 |  xxxx
1  | 7  |  3 |  xxxx
1  | 1 |   4 |  xxxx
1  | 2  |  5  |  xxxx
2  | 1  |  4 |  xxxx
2  | 2  |  5 |  xxxx
2  | 5  |  6 |  xxxx
2  | 4  |  7 |  xxxx
3  | 5  |  6 |  xxxx
3  | 4  |  7 |  xxxx
3  | 3  |  1 |  xxxx
3  | 6  |  2 |  xxxx
3  | 7 |  3  |  xxxx

- Replication depends on topology

### Duplicating data on nodes

\tiny

Node  | Line  | Key  | Value  
--|---|---|--
1  | 3  |  1 |  xxxx
1  | 6  |  2 |  xxxx
1  | 7  |  3 |  xxxx
1  | 1 |   4 |  xxxx
1  | 2  |  5  |  xxxx
~~2~~  | ~~1~~  |  ~~4~~ |  xxxx
~~2~~  | ~~2~~  |  ~~5~~ |  xxxx
~~2~~  | ~~5~~  |  ~~6~~ |  xxxx
~~2~~ | ~~4~~  |  ~~7~~ |  xxxx
3  | 5  |  6 |  xxxx
3  | 4  |  7 |  xxxx
3  | 3  |  1 |  xxxx
3  | 6  |  2 |  xxxx
3  | 7 |  3  |  xxxx

- Still works if node 2 becomes unavailable


### Synchronizing

\tiny

Node  | Line  | Key  | Value  
--|---|---|--
1  | 3  |  1 |  xxxx
1  | 6  |  2 |  xxxx
1  | 7  |  3 |  xxxx
1  | 1 |   4 |  xxxx
1  | 2  |  5  |  xxxx
2  | 1  |  4 |  xxxx
2  | 2  |  5 |  \textcolor{red}{yyyy}
2  | 5  |  6 |  xxxx
2  | 4  |  7 |  xxxx
3  | 5  |  6 |  xxxx
3  | 4  |  7 |  xxxx
3  | 3  |  1 |  xxxx
3  | 6  |  2 |  xxxx
3  | 7 |  3  |  xxxx

- timestamp required

### Synchronizing

\tiny

Node  | Line  | Key  | Value | Timestamp
--|---|---|--|-----
1  | 3  |  1 |  xxxx | 09:01
1  | 6  |  2 |  xxxx | 09:02
1  | 7  |  3 |  xxxx | 09:03
1  | 1 |   4 |  xxxx | 09:04
1  | 2  |  5  |  xxxx | 09:05
2  | 1  |  4 |  xxxx | 09:04
2  | 2  |  5 |  \textcolor{red}{yyyy} | \textcolor{red}{17:15}
2  | 5  |  6 |  xxxx | 09:06
2  | 4  |  7 |  xxxx | 09:07
3  | 5  |  6 |  xxxx | 09:06
3  | 4  |  7 |  xxxx | 09:07
3  | 3  |  1 |  xxxx | 09:01
3  | 6  |  2 |  xxxx | 09:02
3  | 7 |  3  |  xxxx | 09:03

### Writing

- The coordinator transmits the update to all nodes sharing the information
- Data will be updated as a background task
- If consistency greater than the number of /writes/, database is supposed to be consistent
  - consistency=number of of nodes which have finished updating date

### Inserting new data

\tiny

Node  | Line  | Key  | Value | Timestamp
--|---|---|--|-----
1  | 3  |  1 |  xxxx | 09:01
1  | 6  |  2 |  xxxx | 09:02
1  | 7  |  3 |  xxxx | 09:03
1  | 1 |   4 |  xxxx | 09:04
1  | 2  |  5  |  xxxx | 09:05
2  | 1  |  4 |  xxxx | 09:04
2  | 2  |  5 |  xxxx | 09:05
\textcolor{green}{2}  | \textcolor{green}{8}  | \textcolor{green}{8}  |  \textcolor{green}{xxxx} | \textcolor{green}{11:00}
2  | 5  |  6 |  xxxx | 09:06
2  | 4  |  7 |  xxxx | 09:07
3  | 5  |  6 |  xxxx | 09:06
3  | 4  |  7 |  xxxx | 09:07
3  | 3  |  1 |  xxxx | 09:01
3  | 6  |  2 |  xxxx | 09:02
3  | 7 |  3  |  xxxx | 09:03

- Line number consistency
- Replication needed

### Removing data

\tiny

Node  | Line  | Key  | Value | Timestamp
--|---|---|--|-----
1  | 3  |  1 |  xxxx | 09:01
1  | 6  |  2 |  xxxx | 09:02
1  | 7  |  3 |  xxxx | 09:03
1  | 1 |   4 |  xxxx | 09:04
1  | 2  |  5  |  xxxx | 09:05
2  | 1  |  4 |  xxxx | 09:04
2  | 2  |  5 |  xxxx | 09:05
2  | 5  |  6 |  xxxx | 09:06
**2**  | **4**  |  **7** |  **xxxx** | **09:07**
3  | 5  |  6 |  xxxx | 09:06
3  | 4  |  7 |  xxxx | 09:07
3  | 3  |  1 |  xxxx | 09:01
3  | 6  |  2 |  xxxx | 09:02
3  | 7 |  3  |  xxxx | 09:03

- need to look for all nodes having data about line 4 / key 7

### Removing data

\tiny

Node  | Line  | Key  | Value | Timestamp
--|---|---|--|-----
1  | 3  |  1 |  xxxx | 09:01
1  | 6  |  2 |  xxxx | 09:02
1  | 7  |  3 |  xxxx | 09:03
1  | 1 |   4 |  xxxx | 09:04
1  | 2  |  5  |  xxxx | 09:05
2  | 1  |  4 |  xxxx | 09:04
2  | 2  |  5 |  xxxx | 09:05
2  | 5  |  6 |  xxxx | 09:06
**2**  | **4**  |  **7** |  **xxxx** | **09:07**
3  | 5  |  6 |  xxxx | 09:06
**3**  | **4**  |  **7** |  **xxxx** | **09:07**
3  | 3  |  1 |  xxxx | 09:01
3  | 6  |  2 |  xxxx | 09:02
3  | 7 |  3  |  xxxx | 09:03

- All corresponding lines on all nodes are marked for removal

### Removing data

\tiny

Node  | Line  | Key  | Value | Timestamp
--|---|---|--|-----
1  | 3  |  1 |  xxxx | 09:01
1  | 6  |  2 |  xxxx | 09:02
1  | 7  |  3 |  xxxx | 09:03
1  | 1 |   4 |  xxxx | 09:04
1  | 2  |  5  |  xxxx | 09:05
2  | 1  |  4 |  xxxx | 09:04
2  | 2  |  5 |  xxxx | 09:05
2  | 5  |  6 |  xxxx | 09:06
3  | 5  |  6 |  xxxx | 09:06
3  | 3  |  1 |  xxxx | 09:01
3  | 6  |  2 |  xxxx | 09:02
3  | 7 |  3  |  xxxx | 09:03

- Data are actually removed

### Consequences

- Impossible to do *rollbacks*: Every update is recorded, more or less rapidly
- At a given instant, all replicated data are not identical. They will be when the nodes are eventually synchronized
- A removed line may appear, as empty, in a query. Columns are marked for removal but as long as the removal is not performed, the line still exists
- An information (column) that has been removed may re-appear after a given amount of time. It may happen when a node has been out of service for long enough to have the information re-appear when the node is on again

### Summary on Cassandra

- Consistency
- Atomicity at the line level
- Basic queries: using a dedicated language (CQL)
- Scalability
  - High availability
  - Distribution
  - Configurable

### Summary on Cassandra

- In details
  - Loss of ACID properties
  - No joins
  - Pre-defined queries
  - No sort other than the explicitly planned ones
  - A few (disturbing) side effects
- But
  - Allows to handle large amount of data
  - Structuring -> fast access to information
  - Reconfigurable depending on circumstances
  - Can be coupled with Hadoop (Map-Reduce)

### Conclusion

- Do not use if you need ACID properties
  - stick to the relational model then
- Do not use if you do not know your queries first
- Beware of modeling issues: no joins -> specific modeling
- But you get
  - Large data size
  - Priority to data availability
  - real-time access
  - easily extendable
  - highly fault-tolerant

### Cassandra data model

- Column model!
- *Keyspace*: the data container
  - relational equivalent: keyspace=database, schema
- The keyspace contains at least 1 column family
  - relational equivalent: column familiy=table
- Every column family contains lines
  - relational equivalent: a line=line, tuple
- Every line has keys and columns
  - relational equivalent: column=attribute
- Column is the basis entity

### Cassandra model: column

- The smallest unit that can be recorded
- Triple (key, value, timestamp)
  - key = the name (max 64kb)
  - value = the content (max 2Gb)
    - may be omitted
    - has a type
  - timestamp to determine the last version
- Also has
  - a *comparator*: datatype of the column name
  - a *validator*: datatype of the column value


### Cassandra model: line

- Set of columns (Max $10^{9}$)
- Identified by a key (max 64kb)
- Remarks
  - lines do not have to have the same number of columns
  - neither the same columns (also time depending)
