
# Towards "Big data"

## noSQL

###  Introduction

- Facts
  - More and more data are collected (GAFA...)
  - Data are distributed
  - Data are becoming heterogeneous and barely structured
  - The relational model is not enough
- Needs
  - Highly distributed databases
  - Complex and heterogeneous objects
  - Large data volumes
    - hence Not Only SQL (noSQL)

### The relational model

- ACID constraints
  - *Atomicity*: all or nothing
  - *Consistency*: from a valid state to another valid state
  - *Isolation*: every query is executed as if it was unique
  - *Durability*: once done, the update is recorded
- Those properties are difficult to keep in a highly distributed environment while keeping similar performances


### Distributed systems

- 3 main properties: CAP
  - *Consistency*: All nodes see the same data at the same time, i.e. answers to queries are consistent and correct
  - *Availability*: the system is available all the time and answers its users, i.e. operations are executed in a finite amount of time
  - *Partition Tolerance*: Once partitioned, only a total loss of network prevents from running

\begin{block}{CAP theorem (Brewer, 2000)}
In a distributed system, it is impossible to keep those 3 properties valid at the same time, you can choose at most 2 among 3
\end{block}

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
  - Availability is more important than Consistency
  - Few writes, lots of reads

### noSQL basis

- Main elements
  - Sharding: partitioning data on several servers
  - Consistent hashing: partitioning data on several servers which are themselves partitioned on a segment
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

### Reminder

- A hash function $f : S \longrightarrow N$ such as $f(s) = n$ provides a *signature* of $s$
  - $S$ being a general set of arbitrary size
  - $N$ being a well specified set of fixed size (usually much smaller)
  - $f$ may keep some properties 
    - equality, probable equality, non-equality, ordering
  - more or less an injection 
  - used in data structures, cryptography
  - example hash functions: `md5`, `SHA-1`, `CRC`...


### Consistent hashing

- Valid for horizontal partitioning only
- Data and servers are *hashed* by the same function
- Data are mapped to the preceding server on a ring representing the hash values

\center\includegraphics[width=3cm]{fig/hash-ring.pdf}

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
  - initialization
  - Map
  - Regrouping
  - Sort
  - Reduce

### Example

- Count the number of occurrences of words contained in a file
- Classical approach
  - Iterate through lines
    - For each line, count the words and add
- Parallel version: synchronizing the sum process

### Example

- Map-Reduce approach
  1. *Initialization*: line cutting for balancing between processes
  2. *Map*: processing a line=create a mapping (word, number of occurrences)
  3. *Regrouping*: group the number of occurrences for a same word
  4. *Sort*: Each process handles a word: it sums the number of occurrences
  5. *Reduce*: Regrouping the the pairs word-number of occurrences

### Example

\center\includegraphics[width=9cm]{fig/map-reduce.pdf}

### MVCC: mutiversion concurrency control

- Handles concurrent access to data, more specifically for updates
  - ticks old data
  - adds a new version of data and timestamps them
  - regularly sweeps through data and deletes outdated data

### Server classes

- **Key-Value** model
  - Every object has a unique key
- **Column** model
  - Every line has numerous values
- **Document** model
  - Handling document collections
- **Graph** model
  - Handling multiple relationships between objects

### Key-value model

- Somehow works like a traditional hash table
- Data are represented by a $(key,value)$ pair
- Access to a data is possible through its key


### Pros and cons

- Pros
  - Simple model
  - Horizontal partitioning eased
    - can change the number of servers
    - availability
    - no significant maintenance when changing the number of columns
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

- Data are stored on a column-basis rather than on a line-basis
- Close to the relational model ... but with a dynamic number of columns which does not have to be identical between lines
- Data of a same column can be compressed when they *look the same*
- We can distinguish between:
  - column: data field, defined a $(key,value)$ pair
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
- Based on the $(key,value)$ model, the value itself being a document
- Documents do not have a schema but a tree-like structure. They contain a list of fields along with their values
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

- Models  the storage and the handling of complex data linked by non trivial and/or variable relationships
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


### Why Choose a noSQL server? 

- SQL and noSQL do not provide the same type of service
- Relational databases
  - Structured data 
  - Interconnected data 
  - ACID properties
- noSQL
  - Large amount of data 
  - Distributed data 
  - Limited connection between data 


## Big Data

### Towards 'big data'

- Every day, 2.5 trillion bytes of data are generated
  - 1 minute (2017): 3.4M status change on Facebook, 300k queries on Google, 325k tweets
  - Walmart produces 25000Tb data a day!
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
- 3D map of 1/3 of the celestial vault
  - 470 millions stars
  - 2000 galaxies
- 10-year project to understand the Milky way and discover exoplanets
- images: 1 peta-pixels ($10^{15}$ pixels)
  - 500000 HD screens for visualizing
  - 71 petabyte

### Other examples

- Deforestation: Planetary skin 7Tb data
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
  - Data volumes are getting even bigger
- Variety
  - Data are more and more complex ... and less and less structured
- Velocity
  - Data are acquired (and processed) on the fly

### Volume

- Data storage price is still decreasing
- Several reliable storage solutions
- How to determine which data are worth storing?
- GDPR...


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

### Another view to data 

- Social networks 
- Recommendation services 
- Market analysis and prediction 
- Massive customer personalized relationship 
- Targeted ads 
- Reactivity
- ...

### Towards new jobs 

- Example: Data scientist 
  - IT specialist 
  - Development and tool deployment 
  - Parallelism handling
  - Statistics 
  - Manager 

### How does it change the game? 

- Data are there. What do we do with them?
  - Identify available data 
  - Data exploration platform 
  - What kind of analysis? 
  - Introducing new technology to acquire new information 

### Big data tools 

- 2 main types
  - Computer Science tools 
  - Mathematical tools 


### Mathematical tools 

- Using
  - analysis models 
  - predictive models 
  - ...
- Average  and standard deviation are far from being enough!
- Remind that correlation is not causality 

### Computer Science tools 

- Memorize information 
- Process information 


### Memorize information 

- Big Data
  - Lots of data 
  - Data is not always well structured 
  - Usually no time for real-time processing 
- Consequence
  - Towards NoSQL instead of the relationel model 
  - If possible, use distribution 


### Process information 

- Powerful processing models
  - Distributed data 
  - Large amount of data 
- Parallel computing tools
  - Hadoop, Spark... 


### Conclusion 

- RDBMS / NoSQL - Big data 
  - Very different approach to data 
    - Acquisition (massive data)
    - Manipulation (using server farms)
    - Processing (see Map-Reduce)
  - Very different way of thinking
  - Not the same use!






## noSQL with Cassandra

### Cassandra

- Distributed database
- Initially used as Facebook internal messaging system
- Today maintained by Apache
- Widely used distributed database

### Principles

- Non-centralized database
  - no main node or *central server*
  - all nodes are equal (somehow)
- Highly fault-tolerant
  - multiple node replication
- noSQL column model
  - rich model
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

### Who's using Cassandra?

- Apple has a 75000 nodes Cassandra cluster
  - Maps, iCloud...
  - More than $10^{16}$ bytes of data
- Netflix is running 2000 nodes with more than $10^6$ writes/s 

### Why?

- There are **large** volumes of data 
- Load balancing and availability are key issues 
- hundreds of thousands of writes / s 
- Low latency required 
- Add/remove nodes on the fly 


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
- If the consistency degree is greater than the number of *writes*, database is supposed to be consistent
  - consistency=number of of nodes which have finished updating data

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
  - relational equivalent: column family=table
- Every column family contains lines
  - relational equivalent: a line=line, tuple
- Every line has keys and columns
  - relational equivalent: column=attribute
- Column is the basic entity

### Cassandra model: column

- The smallest unit that can be recorded
- Triple (key, value, timestamp)
  - key = the name (max 64kb)
  - value = the content (max 2Gb)
    - may be omitted
    - has a type
    - it can have several values
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

Key  | Lastname  | Firstname  | Address  |  Phone  
--|---|---|---|--
Pascal  | DAVID  | Pascal  | Saint-Nazaire  |  +33 665 ....

Key  | Lastname  | Firstname  | Role
--|---|---|---|--
Carole  |  ROQUES | Carole  | Designer  |  


### Column families

- Logical group of lines
- *Persons* family

Key  | Lastname  | Firstname  | Address  |  Phone  
--|---|---|---|--
Pascal  | DAVID  | Pascal  | Saint-Nazaire  |  +33 665 ....

Key  | Lastname  | Firstname  | Role
--|---|---|---|--
Carole  |  ROQUES | Carole  | Designer  |  

### Column types

- Static
  - columns are defined when creating or updating a column family
- Dynamic
  - columns are defined when creating or updating a line

### Keyspaces

- Logical group of column families
- Examples: a keyspace composed of *Persons* and *Services*
  - **not** linked with the relational model

### Information distribution

- To what extent can we take it into account?
- Problem
  - The database is spread among several nodes and among several clusters
  - How to organize things such as a query does not have to be executed on all nodes to gain execution time?
- Solution
  - Know where are the data we are looking for?
    - Plan data distribution
    - use a hashing mechanism for distribution and retrieval of objects
    - provide a partitioning key

### Partitioning

- Lines are grouped into partitions. A partition is always located on a **single node**
- Partitioning keys are added to distribute lines on the cluster
- Partitioning keys are computed as parts of the primary key
- Practically
  - The primary key is cut into two parts
    - A common part to several keys which is the partition
    - The remainder of the key
  - As many partitions as necessary are created
    - Cassandra will ensure that the lines belonging to the same partition are stored on the same node
  - As the partitioning keys are identical throughout a partition, they are stored only once
  - Lines are ordered along a partition thanks to the remainder of the key

### Example

\center\includegraphics[width=4cm]{fig/partition.pdf}

### Example

\center\includegraphics[width=7cm]{fig/partitioning-1.pdf}

### Example

\center\includegraphics[width=7cm]{fig/partitioning-2.pdf}

### Node organization

\center\includegraphics[width=9cm]{fig/cassandra-nodes.pdf}

## A very short introduction to CQL

### CQL

- CQL = Cassandra Query Language
  - Inspired from SQL
  - Specific to Cassandra
- Command line usage: `cqlsh`
- A few (limited) graphical tools
- Ref: https://docs.datastax.com/en/cql/3.3/cql/cql_reference/cqlReferenceTOC.html

### Commands

- Creation
- Manipulation: CRUD
- Non case sensitive
  - if you want case sensitive names, use double quotes
  - `table = TABLE <> "Table"`
- Strings use single quotes, a quote in a string must be doubled


### Data types

- int, smallint, bigint, varint, float, double, boolean
- text, varchar
- date, time, timestamp
- counter
- uuid, timeuuid
- blob
- list, map, set
- ...
- user defined types

### A few commands

- `CREATE KEYSPACE myKeyspace`
- `DROP KEYSPACE myKeySpace`
- `CREATE TABLE myTable ...`
- `DROP TABLE myTable`
- `ALTER TABLE myTable ...`
- `INSERT INTO...`
- `SELECT ... FROM ...`
- `UPDATE ...`
- `DELETE ...`

### cqsl commands

- `EXIT`
- `SHOW`: displays information on Cassandra
- `SOURCE file`: runs a CQL script
- `COPY ...`: imports/exports CSV files


### CRUD: creation

~~~sql
INSERT INTO [keyspace.]table (list_of_columns)
VALUES (list_of_values)
[IF NOT EXISTS]
[USING TTL seconds | TIMESTAMP epoch_in_microseconds]
~~~

- the column list MUST contain the primary key
- `IF NOT EXISTS` is used to return a value (true/false)
- `USING TTL` tells that the data will be outdated (and thus removable) after a given amount of time (TTL=time to live)
- `USING TIMESTAMP` indicates the timestamp to use for inserting the values of the columns
- Warning: `IF NOT EXISTS` and `USING TIMESTAMP` are not compatible

### Remarks

- Non mentioned values are set to `NULL`
- You can not include counters values. Those values can only be set with `UPDATE`
- Clustering columns can not be more than 64kb
- Values can be
  - of standard type
  - collections
    - sets `{ ... }`
    - lists `[ ... ]`
    - maps `{key:value ...}`

### CRUD: update

~~~sql
UPDATE [keyspace.]table
[USING TTL seconds | USING TIMESTAMP epoch_in_microseconds] SET assignement [, assignement] . . .
WHERE conditions
[IF EXISTS | IF condition [AND condition] . . .] ;
~~~

- `USING TIMESTAMP` and `USING TTL`: same as insert
- `IF EXISTS` and `IF` return a boolean information to indicate what has been updated
- Assignments allow to assign values (terminal values and collections)
- Conditions work the same as in SQL. The condition must act on:
  - the partitioning key when a static column is updated
  - all the primary key otherwise

### CRUD: delete

~~~sql
DELETE [column_name (term)][, ...] FROM [keyspace.]table
[USING TIMESTAMP timestamp_value] WHERE PK_column_conditions
[IF EXISTS | IF static_column_conditions]
~~~

- Warning: removal is not performed immediately
- By default, delete removes the indicated columns. If no column is indicated, the whole line is removed
- If `USING TIMESTAMP` is specified, older values than the indicated timestamp will be removed
- The condition lays on the primary key and can only use = and `IN`

### SELECT

\scriptsize 

~~~sql
SELECT * | expression | DISTINCT partition FROM [keyspace.] table
[WHERE partition_value
[AND clustering_filters
[AND static_filters]]]
[ORDER BY PK_column_name ASC|DESC] [LIMIT N]
[ALLOW FILTERING]
~~~

### Notes

- `SELECT` can only occur on a column family. There are no joins
- Sorting can only be done on a column of the primary key
- Conditions are limited. They can be related to:
  - the partition, which allows to know on which node is the information stored
  - on static columns - they are linked to the partition
  - on clustering columns because they are complementary to the primary key. This condition will only be evaluated on the nodes matching with the searched partitions

### Selection constraints

- In CQL, you can only have conditions on the partitioning key and related things
- If you try conditions on static columns, you will get error messages
  - because the result is not guaranteed
  - that you may overcome by adding `ALLOW FILTERING` to your query
- On other columns, you also get error messages
  - because you would need to search for all data on all servers
  - and you cannot overcome it. You need to change the model!

### SELECT

- In a `SELECT`, you can use:
  - `*`: all columns
  - a list of identified columns
  - `DISTINCT` partitions
  - agreggation functions on partitions (count, sum, add...)
  - `WRITETIME(column)` = write date for the column
    - warning: does not work on lists, sets and maps


### Infrastructure creation

- Create a keyspace

~~~sql
CREATE KEYSPACE keySpaceName [ IF NOT EXISTS ]
WITH REPLICATION = {
‘class’ : ‘SimpleStrategy’,
};
~~~

- Use a keyspace

~~~sql
USE keySpaceName;
~~~

- Describe a keyspace

~~~sql
DESCRIBE keySpaceName;
~~~

### Infrastructure updating

~~~sql
ALTER KEYSPACE keyspaceName
WITH strategy_class=SimpleStrategy
AND strategy_options:replication_factor=1;
~~~


~~~sql
DROP KEYSPACE keyspaceName;
~~~

### Creating column families

~~~sql
CREATE TABLE myFamily (
aColumn itsType,
anotherColumn itsType,
....
PRIMARY KEY ( key_column, clustering_keys )
);
~~~

- the first column of `PRIMARY KEY` is the partitioning key (used for defining the table partitioning)
- the other columns of `PRIMARY KEY` are the clustering keys. Among other things, they are used for ordering lignes inside the partition
- Static columns can be added by adding the `STATIC` key word to the column definition

### Updating a column family

\scriptsize


~~~sql
ALTER TABLE [keyspace_name.] table_name [ALTER column_name TYPE cql_type]
[ADD (column_definition_list)]
[DROP column_list | COMPACT STORAGE ] [RENAME column_name TO column_name]
[WITH table_properties];
~~~
