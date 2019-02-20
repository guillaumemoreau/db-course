% Databases
% Guillaume Moreau
% January 2019

### Database course

- Contents
  - Lectures
  - Tutorials
  - Labs (using PostgreSQL)
- Grading
  - Labs (EVC)
  - Exam (EVI)
- Course material
  - On *hippocampus*

### Goals

- Analyze information
- Build schemas for relational databases
  - Conceptual models
  - Logical models
  - Physical models
- Implement / update a relational database
- Connect to databases from programs
- Programming inside a relational database
- Gain insight about other databases types

### Course outline

- Introduction
- Functional modeling
- Relational model, relational algebra
- Logical model, physical model
- Normal forms
- SQL
- Accessing databases
- PL/SQL
- Business Intelligence
- noSQL - Big Data

### Credits

Most of the slides used in this course are based on Jean-Yves Martin's database course (translated to English).

### Table of contents

\tableofcontents


# Introduction

### Introduction: DIKW

- Data: elementary data
  - *445345.33*
- Information: connections between data
  - *Your bank balance has jumped 8087\% to $445,345.53*
- Knowledge: interpretation
  - *Nobody owes me that much money*
- Wisdom: enough to make a decision
  - *I’d better talk to my bank before I spend it, because of what has happened to other people*

### Let's stop there!


| Information is not knowledge,
| Knowledge is not wisdom,
| Wisdom is not truth,
| Truth is not beauty,
| Beauty is not love,
| Love is not music,
| And Music is THE BEST


*Franck Zappa, Packard Goose*


## From Excel to databases

### Starting point: the book

- Books
  - Handwritten information at first
  - Neither organization nor structure
  - Updating is an issue
- They already contain some encoded information

\center\includegraphics[height=4cm]{fig/chinese-book.png}

### Structuring data

Have a look at this bill

\center\includegraphics[height=6cm]{fig/bill-lu.png}


### What can you see?

- Columns
  - Product, unit price, quantity, total amount
- Customer numbers
- References

### Looking for information: ordering

\center\includegraphics[height=6cm]{fig/rolodex.png}

### About ordering

- pre-requisite: an ordering relationship!
  - various sorting algorithms
- Only one order?
  - billing date
  - customer name? or customer number?
- What kind of questions?
  - Find a particular element
  - Establish a synthesis:
    - who bought what?
    - how many items XX were bought in December?

### Let's use a computer

- Why?
  - Computers have a much larger memory than us (at least to some extent)
  - It is easier to add information in a digital file than in a book
  - Computers are good at sorting
- What do we need?
  - Information coding
  - Information organization
  - Information query algorithms

### ASCII encoding

  \center\includegraphics[height=6cm]{fig/ascii.png}

### Information coding


- Information coding: transform letters, numbers, drawings etc. into digital information
  - but also transform relationships between those into information...
  - ASCII is history
    - basically: any letter/figure/symbol is mapped to an integer $\in [0..127]$
    - what about diacritics?
    - what about Chinese characters?
  - New standard: UTF8/16
- We assume this problem is solved


\begin{block}{For more information}
  See Algorithms and Programming course
\end{block}

### Flat files

- Flat files are text or binary files used for information storage
- They have no *a priori* structure
- Examples: HTML or CSV files
- Access: random or sequential
- Issues
  - Information search
    - Usually requires a complete file traversal
    - Indexing: Google does not (and should not) know everything
  - Structure
    - Being able to automatically read/write the file through a *syntax* and a *grammar*
    - **You** define the structure!

### Example

~~~~~
LFRS 210730Z AUTO 31005KT 3700 BR BKN003 BKN013 OVC020 08/08
Q1040 TEMPO 2000 -DZ BR VV///
~~~~~

- What does that mean?
  - LFRS: Nantes Atlantique Airport
  - Day 21st, 07:30 local time
  - Automatic station
  - Wind: from 310deg. 10 knots
  - Horizontal visibility 3700m
  - Mist
  - Clouds (5/8 to 7/8) at 300ft
  - Clouds (5/8 to 7/8) at 1300ft
  - Overcast 2000ft
  - Temperature: 8 degrees C, dew point: 8 degrees C
  - MSL pressure: 1040hPa
  - ...

### Structured files: columns

- The (false) magic of Excel
- Note: Excel is considered as a generic term, all of this applies to other spreadsheets (Numbers, OpenOffice...)
- Idea (temptation): organize data as Excel spreadsheets
  - Column=the structuring element
  - See also CSV files: columns separated by comas


### Example

Name          First Name       Phone          Address
-----------   ---------------  -------------  ---------------------------------
Doe           John             56165156       22 3rd Street, New York, USA
Obama         Barack           56156285       55 Washington Avenue, Chicago
Trump         Donald           32151133       The White House, Washington
Macron        Emmanuel         12561325       Palais de l'Elysée, Paris, France

### Pros

- Updating/inserting/deleting information is easy
- Easy to search for information
- Tools to make synthesis

### Issues

- How to share information?
- How to tell who lives in Washington?
- How to separate data processing and results display?

### Information sharing

- Objective: gather a file with everybody's address and phone numbers
- How to update information?
- Common Issues
  - multiple versions of an Excel file
  - divergent versions
- After a few iterations, nobody knows
  - if he/she has the last version
  - who has it (if anybody has)

### Hint: shared spreadsheets

- Example: Google spreadsheet

\center\includegraphics[height=5cm]{fig/googlesheets.png}

### Underlying model

- Client-Server mode
  - Data are stored only once: the server
  - (multiple) clients may access the data at the same time
- Access may depend on rights
  - read
  - write
  - update the structure


### Next step: several information types

\tiny

Name          First Name       Phone          Address
-----------   ---------------  -------------  ---------------------------------
Doe           John             56165156       22 3rd Street, New York, USA
Obama         Barack           56156285       55 Washington Avenue, Chicago
Trump         Donald           32151133       The White House, Washington
Macron        Emmanuel         12561325       Palais de l'Elysée, Paris, France


Name         First name        Birth date     License#  Home address
-----------  ---------------- -----------  -----------  ----------------------------
Doe          John              1990/02/22     54545685  22 3rd Street, New York, USA
Sarkozy      Nicolas           1955/05/14      1651631  Mairie de Neuilly, Neuilly
Hilton       Paris             1984/12/12       000000  The Beach, Miami, USA
Hamilton     Lewis             1983/10/22     34995599  Monaco, Monaco
Obama        Barack            1960/01/01     34994333  The White House, Washington


### Issues

- Some people appear twice
- Some people appear twice and have different address
- Still an issue with unstructured search: e.g. who is living in Paris?
- Addresses are called in two different ways
- *Idea*: align all data in a single table
  - does not work for people who do not appear in both tables
- *Idea*: try to avoid repeating things (redundant storage)
  - add numbers in tables
  - separate concerns in tables

### Step 1: gather common data: persons

1. Determine what is common between those tables: *persons*
2. Create a *person* table with common data
  1. for all persons, whether they have a license or not
3. Give *numbers* to persons, which we will call *id*

  Id  Name         First name        Birth date
----  -----------  ---------------- -----------
   1  Doe          John              1990/02/22
   2  Sarkozy      Nicolas           1955/05/14
   3  Hilton       Paris             1984/12/12
   4  Hamilton     Lewis             1983/10/22
   5  Obama        Barack            1960/01/01
   6  Trump        Donald
   7  Macron       Emmanuel

### Step 2: Simplify address table

1. Replace naming information by persons number in address table
2. Solve conflicts between address table and license table
3. make address column name consistent


  person_id  Address
-----------  ---------------------------------
1            22 3rd Street, New York, USA
5            55 Washington Avenue, Chicago
6            The White House, Washington
7            Palais de l'Elysée, Paris, France
2            Mairie de Neuilly, Neuilly
3            The Beach, Miami, USA
4            Monaco, Monaco

### Step 3: Do the same for the license table

  person_id          License#
-----------  ----------------
1             54545685
2               1651631
3             000000
4             34995599
5            34994333


### Summary

- This is the principle for the 'relational' model
  - Regroup what is common in a **table**
    - e.g. the *person* table
  - Add **keys**
  - Create other table without this information and add **foreign keys**
    - e.g. the *license* key
    - foreign keys refer to information stored elsewhere
  - Queries will be making the link between tables, i.e. **joins**
- This is what we will see next in relational algebra and databases

### Not that simple...

> So, why is Microsoft Access (generic name) not a real database management system?

### Constraints

- Data removal in several tables
- Simplistic Examples
  - If someone dies, we need to remove all data from all tables
    - `person_id` is not valid any more
  - If someone loses his license, we shouldn't remove data from other tables
    - `person_id` remains valid!
- But also data consistency
  - France is divided into administrative regions that are themselves divided into "départements"
  - hence the sum of area of "départements" of a region should be the area of the region

### Région Pays de la Loire


\center\includegraphics[height=5cm]{fig/pdl.jpg}

### What about the population?

> - Pays de la Loire: 3658000
>   - Loire-Atlantique: 1329000
>   - Maine-et-Loire: 800000
>   - Sarthe: 569000
>   - Mayenne: 307000
>   - Vendée: 650000
> - Issues
>   - rounding
>   - census dates
> - Consistency and integrity are different concepts

### Example 2: booking a seat in an aircraft (1/4)

17h30: Passenger A is looking at the seat map

\center\includegraphics[height=5cm]{fig/seatmap1.png}

### Example 2: booking a seat in an aircraft (2/4)

17h32: Passenger B is looking at the seat map

\center\includegraphics[height=5cm]{fig/seatmap1.png}

### Example 2: booking a seat in an aircraft (3/4)

17h32: Passenger B chooses seat 36J

\center\includegraphics[height=5cm]{fig/seatmap2.png}

### Example 2: booking a seat in an aircraft (2/4)

17h40: Passenger A eventually chooses seat 36J

\center\includegraphics[height=5cm]{fig/seatmap2.png}

### Concurrent access

- Simultaneous access to a resource (the plane seat)
  - problem: only one seat 36J
  - X and Y book the seat *at the same moment*
  - Solution: forbid the update of a variable between read and write
  - Computer Science: see semaphors, mutual exclusion, critical sections...
  - Beware of customer requirements versus CS issues!

### Example 3: Money transfer

Ideal case

- Bank 1:
  - 15h28: 5000$ on account
  - 15h30: money transfer order 2000$ to Bank 2
  - 15h31: 3000$ on account
  - 15h31: send 2000$ by network to Bank 2
- Bank 2:
  - 15h28: 1000$ on account
  - 15h31: receive 2000$ by network
  - 15h32: 3000$ on account

### Example 3: Money transfer

  What happens if the network transfer does not work?

  - Bank 1:
    - 15h28: 5000$ on account
    - 15h30: money transfer order 2000$ to Bank 2
    - 15h31: 3000$ on account
  - Bank 2:
    - 15h28: 1000$ on account

Notion of transaction: either **everything** is completed or **nothing**

### What's next?

- Data are not only numbers and characters...
  - CAD data (see the PLM concept)
  - Same issues: Store, Search, Share
- Other data types: spatial data

### Example

What are the neighbors of Cantal (15)?

\center\includegraphics[height=5cm]{fig/cartefrance.png}

### What is the problem?

- Data now have a spatial component
  - i.e. we must store some kind of $(x,y)$ data
- Spatial components: 0D, 1D, 2D...
  - départements would require storing polygons
  - Spatial relationships
    - can be stored (easy) or computed (more dynamic)
    - Spatial DB provide goemetry functions (area, intersection...)
- Data still have standard types also (called thematic data)


### Spatial query: an example

Which département has the best Digital TV coverage?

\center\includegraphics[height=4cm]{fig/cartefrance.png} \includegraphics[height=4cm]{fig/tnt.png}


### Summary

A database is:

- **Large** compared to human memory
- **Persistent** throughout time (fault-tolerant)
- **Set of ** mathematical notion
- **Structured** organized, having relationships
- **Consistent** integrity constraints are defined and enforced
- **Simultaneous** parallelism of access, shared data
- **Usable** query, updates and evolution are possible
- **Data** i.e. typed information

### Data versus applications

Application change but Data remain

\center\includegraphics[height=5cm]{fig/ordi.png}


### But it is hard!!

- Sustainability of
  - file formats
  - data supports
- compared to what they describe

\center\includegraphics[height=2cm]{fig/disquettes.png} \includegraphics[height=2cm]{fig/md82.png} \includegraphics[height=2cm]{fig/aa.png}


### Just for information

Evolution of standard hard disk capacity. **log** scale (source Wikipedia)

\center\includegraphics[height=5cm]{fig/dd.png}

### Conclusion: Information systems are much more than computer science!

- Have a look at this screenshot
  - SERSE is an app for submitting foreign experience reports...
- What does PEBKAC mean?

\center\includegraphics[height=5cm]{fig/serse.jpg}


### History

- 1950-1960: files started to be stored on computers
  - required access methods and file organization
  - started with sequential access (tapes)
- Then, random access was made possible
  - Direct access
  - required file structuring

### History

- Companies needs
  - financial data, business data, technical data, production data...
  - driven by technological progress
- 1962: the Database concept


### History of databases

- 1st generation: based on access models
  - separation between data + navigation access language
  - hierarchical or network model
- 2nd generation: based on the relational model (1980s)
  - 1997: SQL by IBM
  - 1986: SQL1 becomes an ISO standard
- 3rd generation: other database types
  - object-oriented
  - deductive
  - fuzzy logics
  - multimedia
  - XML
  - ...

### To date

- Relational databases take the biggest share of the database related activity
- noSQL has appeared
- Big Data impact


## Problem statement


### Example

> A rental store has several device types for rent. Devices as well as
> their type are designated by a number and have a label. Every device type
> has a rental rate. Devices may be rented by customers, identified by a number
> and whose name and address are known. A customer may rent several devices.
> The same device may be rented several times by the same customer, therefore
> the rent start date and duration are stored. Customers who have forgotten
> to give back their devices will be contacted and billed.

### Step 1: modeling

- Conceptual data model

\center{\includegraphics[height=.65\textheight]{fig/cmodel-1.pdf}}

### Step 2: transformation into a logical model

- Logical model

\center{\includegraphics[height=.65\textheight]{fig/cmodel-2.pdf}}

### Step 3: Adding type information

- Physical model of data

\center{\includegraphics[height=.65\textheight]{fig/cmodel-3.pdf}}

### Step 4: Translation

\center{\includegraphics[height=.65\textheight]{fig/cmodel-4.pdf}}

### Step 5: Implementation

- The database can now be populated and used

\center{\includegraphics[height=.55\textheight]{fig/cmodel-5.pdf}}

### Operating

\center{\includegraphics[height=.65\textheight]{fig/cmodel-6.pdf}}

### Definitions

- **Modeling** is the activity which consists in elaborating a structured representation of reality
- A **database** is a **representation** of a part of the real world which is of interest for users and applications
- **Modeling a database** is the elaboration of data structures for the data that will be recorded into a database
- The definition of those structures is stored in the **schema** of a database


### Information system

\center{\includegraphics[height=.65\textheight]{fig/is.pdf}}


## Databases

### Definitions

> 'Structured set of data recorded on devices a computer can access to simultaneously satisfy several users in a selective way and at the right time[^da]'


> 'Set of data memorized by a computer, used by several persons and having an organization described by a data model[^mo]'

> 'Set of data handled a dabatase management system used to model a single company[^ga]'

[^da]: Delobel, Adiba
[^mo]: Morejon
[^ga]: Gardarin

### Criteria

1. Good representation of the real world
2. No redundancy of information
3. Independence between data and processings
4. Security and confidentiality of data
5. Performance of applications and queries


### Deploying a database

1. Determine and identify the problem
2. Propose possible solutions
3. Model the system
4. Design the solution
5. Test the solution
6. Maintain and improve the system

### Determine and identify the problem

- What problem are you modeling?
- What are the boundaries of the problem?
  - i.e. what are you **not** modeling?
- Who are the stakeholders?
- What are the reference documents?
- What data? Which processings?
- What are the constraints?

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-1.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-2.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-3.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-4.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-5.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-6.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-7.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-8.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-9.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-10.pdf}}

### Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-11.pdf}}

### How to collect information?

- Written documents
  - existing documents (bills, forms...)
  - documents to write (questionnaires, statistics...)
- Oral enquiry
  - stakeholders interviews (explanations, cross-check, supplementary material)
- Visual enquiry
  - qualitative (acting stakeholder, information circuit...)
    - seeing how it actually works on the desktop  
    - following an information
  - quantitative
    - numbers of computers, servers, forms, processed documents, processing times...

### Propose possible solutions

- Ask questions to the future users
- Gather documents
- Sort information
- Dictionary of the terminology
- *Validate* upon users and managers

### Model the system

- Structure information
- Model information (conceptual model)
- *Validate* upon users and managers

### Conceptual model

- Independent from technologies
  - portability
  - durability
- User-oriented
  - Legible
  - Supporting the dialog between designers and users
  - allows collaboration with and validation by users
- Formal unambiguous specifications
- Support for visual interfaces
- Facilitates information exchange between several DB systems


### Designing a solution

- Translate the conceptual model into a logical model
- Add types to complete the physical model
- Choose a DBMS type
- Translate into SQL
- Implement the SQL file(s) into the DBMS
- If required, add internal functions
- Add security elements

### Test the solution

- Setup a test database
- Add information
- Check primary key presence (same for secondary keys) and that they are normally working
- Test for data required for processings
- Test for response times
- Test for security


### Maintain and improve the system

- Correct errors if any
- If new constraints arise, update the database schema
  - update the conceptual schema
  - deduce the modifications that are required in the database
    - including existing data themselves
  - test evolutions on the test base
  - tell the users!!
  - update the database
- Note: it may happen that you will have to update a database schema for which you do not have all documents
  - reverse engineering

## Database Management Systems (DBMS)

### DBMS

- Software used to organize and handle data
- Main functions
  - Describe the database(s) structure
  - Manipulate data
  - Use data
  - Ensure data integrity and confidentiality
  - Optimize data access

### DBMS

- Characterized by the supported data model
  - 1st generation
    - based on hierarchical and network models
    - navigation-based data language
  - 2nd generation
    - based on the relational model
    - SQL...
  - 3rd generation
    - based on the object model
    - SQL3 and others...

### DBMS users

- System engineer
  - Maintenance, backups & restores
- Database administrator
  - defines the various components of the database
  - description or definition language
- Application administrator
- Application programmer
  - writes programs for an application
  - manipulation language
- Database user
  - uses the DB to obtain information
  - query language

### A few DBMS examples

- Oracle
- SQL Server
- Sybase
- DB2
- PostgreSQL
- mySQL
- H2
- ...


### Using a DBMS

- Setting up the DBMS
  - installation
  - configure
  - secure
- Setting up an administration software
- Dialog between the software through Internet
  - data manipulation language

### Summary

- Analysis: a DB is a representation of a part of reality which is of interest

\center{\includegraphics[width=.6\textwidth]{fig/analysis.pdf}}

### Abstraction

- From perceived reality to representation

\center{\includegraphics[width=.6\textwidth]{fig/summary-1.pdf}}

### Definition of the conceptual schema

- A schema is a collection of stereotypes
- The database will contain the values representing the instances of those stereotypes

\center{\includegraphics[width=.6\textwidth]{fig/ea-model.pdf}}

### Definition of the physical schema

- Translation to a logical model
- Then to a physical model

\center{\includegraphics[width=.8\textwidth]{fig/ea-model2.pdf}}

### Implementation of the physical schema

- Choose a DBMS (compatible with the physical schema)
- Implement the physical model into the DBMS

\center{\includegraphics[width=.8\textwidth]{fig/ea-model3.pdf}}
# Functional modeling

### Before starting

- There exists several model types
  - Entity-Association model
  - UML model
  - SysML model
  - ...
- We cannot study all of them

## Entity-Association Model

### The Entity-Relationship model

- Was created around 1975
  - In France by Tardieu
  - In the US by Chen
- It integrates Merise (modelling method)

### The Entity-Relationship model

- Goal: allow the design/description of the conceptual structure of data for an application
- The base principals are equivalent to real-life abstraction concepts
  - object vs entity
  - link vs relationship
  - property vs attribute
  - representation of multiple links: link *is-a*

### The Entity-Relationship model

  Entity

  - Either a concrete or abstract  object
  - Exists as an instance of itself
  - Is of interest for the information system
  - Needs to be managed

### Entity

  - Entity: it represents an object of the real world having a life of its own
  - Entity Type: representation of a set of entities perceived as similar and having the same characteristics

  \center\includegraphics[height=2.9cm]{fig/entity.png}

### Entity: properties

  - Must define at least 1 characteristic of the entity that it depends on
  - It is needed for use in the information systems
  - Elementary data
  - It needs to be managed
  - Has a definite domain: {possible values}
  - Some properties may be impossible to define
  - Occurences
    - of properties
    - of entities

### Entity: properties

Properties: the characteristics of an entity

\center\includegraphics[height=2.9cm]{fig/book.png}

### Properties

- Simple (atomic)
  - cannot be decomposed
  - examples: day, first name
- Domain: atomic values
  - day: belongs to $\{ 1, 2, ... , 31 \}$
  - predefined sets, intervals, enumerations

### Properties

- Complex (can be decomposed into other properties)
  - try to avoid and prefer decompose into simpler elements
  - examples
    - address
    - dates (can be an exception)
- A complex property does not have a proper value (no directly associated domain)
  - its value is the composition of the values of the component properties
- A component of a complex property can also be a complex property and thus will be also decomposed

### Properties

- **single value**: one value per occurrence (max cardinality = 1)
  - example: StudentID, Licence number, degree name
- **multiple value**: several values per occurrence (max cardinality >1)
  - Avoid!
  - examples: first names, phone numbers
  - the value of a multiple value property is a set (or a list or a multiset) of values, each of which belongs to the domain associated with the property

### Properties

- **mandatory**: at least one value per occurrence (min cardinality >= 1)
  - example: names
- **optional**: may not have a value (min cardinality = 0)
- Whether a value is mandatory or optional is determined by the applications needs
  - if we accept to register someone without knowing his/her birthdate, then the *birthdate* property will be optional (otherwise mandatory)
  - Think about the consequences!


### Occurences

- Occurrence
  - for a property
    - pair (property , its value)
  - for an entity
    - pair (entity , { occurrences of properties } )
- Population { occurrences of entities}

### Example

Entity  |  Property |  Occurrences
--|---|--
Book  | Number  |  15
  $\,$ | $\,$   |  124
  $\,$ | Title  |  Relational Databases
  $\,$ | $\,$   |  The grapes of Wrath
  $\,$ | Author  |  Delobel
  $\,$ | $\,$   |  Steinbeck
  $\,$ | Year  | 1992
  $\,$ | $\,$   |  1939

### Representation

- Textual:
  - name_of_the_entity( list_of_properties )
    - where list_of_properties is a comma-seperated list of properties
- Graphically:

\center\includegraphics[height=2.9cm]{fig/ER-entity.png}

### Example

Book (Number, Title, Author, Year_Published)

\center\includegraphics[height=2.9cm]{fig/ER-book.png}

### Entities versus occurrences

\center\includegraphics[height=5cm]{fig/ea-example.pdf}


### Choosing the properties of an entity

- A property is directly linked to the entity it belongs to
- A property cannot evolve under the influence of time (i.e. choose birth date rather than age)
- Avoid property introducing information redundancy

### Relationship

- Semantic link among a set of entities
- Non-directional link
- Is of interest for the information system
- Needs to be managed
- Examples
  - has-written between Author and Book
  - has-published between Publisher and Book
  - has-borrowed between a Book, a Reader and a Date  

### Remarks

- A relationship **always** occurs between entities
- A relationship can **never** occur between relationships
- An entity is **never** directly related to another entity

### Representation

- Textual:
  - relationship_name = < entity_1, ...,  entity_n >
- Graphically:

\center\includegraphics[height=2.6cm]{fig/ER-relationship.png}

### Mapping - association

- Mapping: represents a non oriented link between several entities (which play a predetermined part)
- Mapping type: represents a set of mappings having the same semantics and described by the same characteristics

\center\includegraphics[height=2.6cm]{fig/mapping-1.pdf}

### Definitions

- **Collection**: set of entities involved in the mapping
- **Dimension**: number of entities involved in the mapping

### Properties of a relationship

The design of the model sometimes imposes some properties to the relationships

\center\includegraphics[height=2.6cm]{fig/ER-relationship2.png}

### Relationships types

- Binary

\center\includegraphics[height=2.6cm]{fig/ER-relationship.png}

### Relationships types

- Ternary

\center\includegraphics[height=5cm]{fig/ER-relationship3.png}

### Ternary mapping

\center\includegraphics[height=3cm]{fig/ER-map3.pdf}

### Relationships types

- Hierarchical / Transitive

\center\includegraphics[height=2.9cm]{fig/ER-relationshiph.png}

### Relationships types

- Symmetrical / Cyclic

\center\includegraphics[height=2.9cm]{fig/ER-relationships.png}

### Symmetrical mapping

\center\includegraphics[width=.5\textwidth]{fig/mapping-sym.pdf}

### Symmetrical mapping (continued)

\center\includegraphics[width=.5\textwidth]{fig/mapping-sym2.pdf}

- Issue: how to know in a couple who is who?

### Symmetrical mapping (continued)

- Solution: specify the role of each entity to solve ambiguities
- 1 "is\_married\_to" = <1 Person/Wife, 1 Person/Husband>

\center\includegraphics[width=.5\textwidth]{fig/mapping-sym3.pdf}

### Cardinalities

\center\includegraphics[height=5cm]{fig/cardinalities.png}

### Cardinalities

\center\includegraphics[width=.5\textwidth]{fig/mapping-c1.pdf}

- Two questions raised (per link)
  - How many cars minimum may someone have?
  - How many cars maximum may someone have?

  \center\includegraphics[width=.5\textwidth]{fig/mapping-c2.pdf}

### Cardinality

- defined on the link between an entity and a relationship
  - minimum number of connections: 0 or 1
  - maximum number of connections: 1 or n
- Possible values
  - 0:1
  - 0:n
  - 1:1
  - 1:n

### Example 1

- An order is placed by only one client
- A client can place no order at all or can place multiple orders
- details
  - It is compulsory that an order is placed, min = 1
  - An order is linked to only 1 client, max = 1
  - A client can place no order at all, min = 0
  - A client can place multiple orders, max = n

\includegraphics[width=\textwidth]{fig/client-order.png}

### Example 2

- A person may not own a car or may own 1 or several cars

\center\includegraphics[width=.5\textwidth]{fig/mapping-c3.pdf}

- A car has one and only one owner

\center\includegraphics[width=.8\textwidth]{fig/mapping-c4.pdf}

### Cardinalities at large

- **0:1** The entity can be linked to a maximum of 1 other...
- **0:n** The entity can be linked to more than 1 other...
- **1:1** The entity can be linked to only 1 other...
- **1:n** The entity can be linked to at least 1 other...

### Identifiers

- Definition: A minimum set of properties such as there is no other occurrence in the entity where the values of the properties are the same.
- All entities must have an identifier
- The identifier of an entity is shown by underlining the properties forming part of the identifier

### Other notations

\center\includegraphics[width=.8\textwidth]{fig/mapping-c5.pdf}

### Other notations

\center\includegraphics[width=.7\textwidth]{fig/mapping-c6.pdf}

### Identifier

*Person(\underline{Number},LastName,FirstName,BirthDate)*

The identifier is composed of a unique attribute

\center\includegraphics[width=.25\textwidth]{fig/person-1.pdf}

### Identifier

*Person(Number,\underline{LastName},\underline{FirstName},BirthDate)*

The identifier is composed of a set of attributes

\center\includegraphics[width=.25\textwidth]{fig/person-2.pdf}

### Identifiers for mappings

The set of linked entities

\center\includegraphics[width=.7\textwidth]{fig/mapping-id.pdf}

Identifier for *HasGrade*: (Student.StudentId + Course.CourseId)

### Identifier for mappings

The set of linked entities

\center\includegraphics[width=.7\textwidth]{fig/mapping-id2.pdf}

\begin{alertblock}{Error}
A customer must be able to order several times the same product
\end{alertblock}

### Identifier for mappings

Solution: transform the mapping into a relation

\center\includegraphics[width=.7\textwidth]{fig/mapping-id3.pdf}

## How to model?

### Functional dependency

- Definition
  - There exists a **functional dependency** (FD) denoted by $X \rightarrow Y$ if and only if to a same value of $X$ always corresponds the same value of $Y$
  - i.e.
    - $X$ determines $Y$
    - $Y$ depends on $X$

### Functional dependencies

- Between properties
  - knowing one occurrence of the source property, one and only one occurrence of the target property is known
  - notation: $OrderId \rightarrow CustomerId$
- Between entities
  - knowing one occurrence of the source entity, one and only one occurrence of the target entity is known
  - notation: $Order \rightarrow Customer$

### Entities and mappings

When the source part of the FD has only one entity, the segment between the entity and the mapping has a cardinality (0,1) or (1,1)

\center\includegraphics[width=.7\textwidth]{fig/df-1.pdf}

### Properties of functional dependencies

- Reflexivity
  - $X \rightarrow X$
  - $CustomerId \rightarrow CustomerId$
- Augmentation
  - If $X \rightarrow Y$, then $\forall Z, XZ \rightarrow Y$
  - If $OrderId \rightarrow CustomerId$ then $OrderId,CustomerName \rightarrow CustomerId$
- Transitivity
  - if $X \rightarrow Y$ and $Y \rightarrow Z$ then $X \rightarrow Z$
  - if $OrderId \rightarrow CustomerId$ and $CustomerId \rightarrow CustomerCompanyId$ then $OrderId \rightarrow CustomerCompanyId$

### Properties of functional dependencies

- Pseudo-Transitivity
  - if $X \rightarrow Y$ and $YZ \rightarrow W$ then $XZ \rightarrow W$
  - if $OrderId \rightarrow CustomerId$ and $CustomerId,City \rightarrow CompanyId$ then $OrderId,City \rightarrow CompanyId$
- Union
  - if $X \rightarrow Y$ and $X \rightarrow Z$ then $X \rightarrow YZ$
  - if $OrderId \rightarrow CustomerId$ and $OrderId \rightarrow OrderDate$ then $OrderId \rightarrow CustomerId,OrderDate$

### Properties of functional dependencies

- Decomposition
  - if $X \rightarrow YZ$ then $X \rightarrow Y$ and $X \rightarrow Z$
- Example
  - $OrderId \rightarrow OrderDate,CustomerId$ then
    - $OrderId \rightarrow OrderDate$
    - $OrderId \rightarrow CustomerId$

### Elementary functional dependency

- Definition: $X \rightarrow Y$ is an **elementary functional dependency** if and only if there is no $Z$ included in X such that $Z \rightarrow Y$
- Examples
  - $OrderId,ArticleId \rightarrow Quantity$ is elementary
  - $OrderId,ArticleId,CustomerId \rightarrow Quantity$ is not elementary

### Direct functional dependency

- Definition: $X \rightarrow Y$ is a **direct functional dependency** if there is no $Z$ such as $X \rightarrow Z$ and $Z \rightarrow Y$
- Examples
  - $OrderId \rightarrow CustomerId$ is direct
  - $OrderId \rightarrow CompanyId$ is not direct because $OrderId \rightarrow CustomerId$ and $CustomerId \rightarrow CompanyId$

### Dependencies graph

- Definition: The **dependencies graph** is the graph representing the $E$ set of elementary functional dependencies for which:
  - the vertices are the attributes
  - the edges are the functional dependencies

### Example

- Set of attributes: $\left\{ Exam, Room, PersonInCharge, Time, Student, Grade \right\}$
- Functional dependencies
  - $Exam \rightarrow PersonInCharge$
  - $Time,Room \rightarrow Exam$
  - $Time,PersonInCharge \rightarrow Room$
  - $Exam,Student \rightarrow Grade$
  - $Time,Student \rightarrow Room$


### Dependency graph

\center\includegraphics[width=.7\textwidth]{fig/depgraph.pdf}

### Transitive closure

- Definition: The **transitive closure** of the dependency graph is the set of all functional dependencies obtained by transitivity on the functional dependencies

### Example

\center\includegraphics[width=.7\textwidth]{fig/depgraph-2.pdf}

### Example

\center\includegraphics[width=.7\textwidth]{fig/depgraph-3.pdf}

### Minimal coverage

- Definition: The **minimal coverage** of $E$ is the set of elementary functional dependencies that has the same transitive closure as a $E$ and such that this property is not true anymore if any functional dependency is removed
- maths: if we define a mapping *has-same-transitive-closure*, it will be an equivalence and thus has equivalences classes which have minimal members

### Example

Here, no single dependency can be removed without altering the transitive closure. It is thus a minimal coverage.

\center\includegraphics[width=.7\textwidth]{fig/depgraph-2.pdf}

### Properties

- All sets of elementary functional dependencies has at least one minimal coverage
- All direct FD belongs to the minimal coverage
- Every FD belonging to the minimal coverage is direct


## The Entity-Association model at work

### Conceptual models

- Entity types
- Mapping types
- Attributes
- Identifiers
- Domains for simple attributes
- Integrity constraints

### Entity types

- Name of the entity type
- Name of the potential *up*-types
- Free definition (comment) providing the semantics of the entity type
- Exact definition of the population related to an entity type
- Description of the attributes
- **\color{red}Define the identifier(s)**
- Composition of the identifiers of the entity type (if any)
- Integrity Constraints related to the Entity Type

### Mapping types

- Name of the mapping type
- Free definition (comment) providing the semantics of the mapping type
- Names of the entity types participating in the mapping type with the name of their role in the mapping
  - For each role, its cardinality
- Description of the attributes (if any)
- Composition of the identifiers of the mapping type (if any)
- Integrity constraints related to the mapping type

### Example problem

> A rental store has several device types for rent. Devices as well
> their type are designated by a number and have a label. Every device type
> has a rental rate. Devices may be rented by customers, identified by a number
> and whose name and address are known. A customer may rent several devices.
> The same device may be rented several times by the same customer, therefore
> the rent start date and duration are stored. Customers who have forgotten
> to give back their devices will be contacted and billed.

### Example
- Customer Rental Balance
  - Customer Number: 1235
  - Name: John DOE
  - Address: Nantes

DeviceId  | M10  | M10  | M05
--|---|---|--
Name  | Camera  | Camera  | Hifi
TypeId  | T3  | T3  | T7  
TypeName  | Video  | Video  |  Sound
Fee  | 20  | 20  | 150
StartDate  | 2018-12-01  | 2018-03-02  |  2008-03-02
ReturnDate  |  2019-01-04  | $\,$  |  $\,$

### STEP 1: determine the set of properties

- 2 lists should established:
  - the list of required information
  - for each information, the list of characteristic properties. One of these properties (or a set of them) will have to uniquely identify the information

### Example STEP 1

- List of required information
  - The customer
  - The device and its type
  - The rental

### Example STEP 1

- List of required information
  - The customer
    - The name of the customer: *CustomerName*
    - The address of the customer: *CustomerAddress*
    - Not enough to uniquely identify the customer, so we add a client number: *CustomerId*
  -  The device and its type
    - The rental

### Example STEP 1

- List of required information
  - The customer
  - The device and its type
    - The device has a name: *DeviceName*
    - The device has a type: *Type*
    - The device has a rental fee: *Fee*
    - Not enough to uniquely identify the device, se we add a device number: *DeviceId*
  - The rental

### Example STEP 1

- List of required information
  - The customer
  - The device and its type
  - The rental
    - The person who rents (\textcolor{magenta}{the client})
    - The device that is rented (\textcolor{magenta}{the device})
    - the rental start date: *StartDate*
    - the rental return date: *ReturnDate*
    - we consider that knowing the customer, the rented device and the rental dates, we have enough information

### Step 1: list of properties

- *CustomerName*
- *CustomerAddress*
- *CustomerId*
- *DeviceName*
- *Type*
- *Fee*
- *DeviceId*
- *StartDate*
- *ReturnDate*

### Caution

- It is a good idea to avoid properties that would have the same name...
- A naming convention can be adopted
  - a suffix or prefix can be added
  - for example: the name of the information on which is depends

### Step 2: looking for functional dependencies

From the list of properties, functional dependencies can be established

- $CustomerId \rightarrow CustomerName$
- $CustomerId \rightarrow CustomerAddress$
- $DeviceId \rightarrow DeviceName$
- $DeviceId \rightarrow Type$
- $Type \rightarrow Fee$ (an approximation here!)
- $CustomerId,DeviceId,StartDate \rightarrow ReturnDate$

### Step 2: looking for functional dependencies

Functional dependencies are not always sufficient to completely build the problem. For each information, we will add the set of elements that are necessary to define it:

- $CustomerId$: the client
- $DeviceId$: the device and its type
- $(CustomerId,DeviceId,StartDate)$: the rental

### Step 2: looking for functional dependencies

- $CustomerId$: the client
- $DeviceId$: the device and its type
- $(\textcolor{magenta}{the client},\textcolor{magenta}{the device},StartDate)$: the rental

\begin{exampleblock}{Remark}
Some elements on the left part of the list are information by themselves. They are replaced by the element that allows to uniquely define them. This element \textbf{must} be composed of a single property. If it is not the case, a new property is added to uniquely define the set of properties used as an identifier. New functional dependencies are then added.
\end{exampleblock}

### Multiple properties as identifiers

- Example
  - *InfoId1* for information 1
  - *InfoId2* for information 2
  - (\textcolor{magenta}{information 1},\textcolor{magenta}{information 2}) for information 3
  - (*InfoId4*,\textcolor{magenta}{information 3}) for information 4

### Multiple properties as identifiers

- After substitution
  - *InfoId1* for information 1
  - *InfoId2* for information 2
  - (\textcolor{red}{InfoId1},\textcolor{red}{InfoId2}) for information 3
  - (*InfoId4*,\textcolor{magenta}{information 3}) for information 4

No substitution can be made in the last line

### Multiple properties as identifiers

- We add an information
  - \textcolor{red}{InfoId3=(InfoId1,InfoId2)}
- We add functional dependencies
  - $InfoId3 \rightarrow InfoId1$
  - $InfoId3 \rightarrow InfoId2$
- and the last line becomes
  - $(InfoId4,\textcolor{red}{InfoId3}) for information 4

### Dependency Graph

\center\includegraphics[width=.8\textwidth]{fig/ea-modeling.pdf}

### Step 4: Building the entities

- Determine the sources of the functional dependencies
  - A = \{ properties *p* / *p* in FD source \}
- Build an entity from each of those properties. The property is the identifier of the entity

### Step 4: Building the entities

Sources are marked in magenta. 4 are identified: *A=\{ CustomerId, DeviceId, StartDate, Type \}*

\center\includegraphics[width=.8\textwidth]{fig/ea-modeling-2.pdf}

### Step 4: Building the entities

*A=\{ CustomerId, DeviceId, StartDate, Type \}*


\center\includegraphics[width=.7\textwidth]{fig/ea-modeling-3.pdf}

### Step 5: Building the mappings

- A source FD vertex defines a mapping type if it is composed of at least two elements of $A$ that are the identifiers of entity types involved in the mapping type. The maximum cardinalities are then $n$
- Two FD source edges linked by a FD define a mapping type of dimension 2. One of the cardinality is equal to $(0,1)$ or $(1,1)$

### Step 5: Building the mappings

*A source FD vertex defines a mapping type if it is composed of at least two elements of $A$ that are the identifiers of entity types involved in the mapping type. The maximum cardinalities are then $n$*


\center\includegraphics[width=.8\textwidth]{fig/ea-modeling-4.pdf}

### Step 5: Building the mappings

*Two FD source edges linked by a FD define a mapping type of dimension 2. One of the cardinality is equal to $(0,1)$ or $(1,1)$*

\center\includegraphics[width=.8\textwidth]{fig/ea-modeling-5.pdf}

### Step 6: Add remaining properties

- Add the properties that are not into $A$ to the entities that are sources of functional dependencies

### Step 6: Add remaining properties (entities)

\center\includegraphics[width=.8\textwidth]{fig/ea-modeling-6.pdf}

### Step 6: Add remaining properties (mappings)

\center\includegraphics[width=.8\textwidth]{fig/ea-modeling-7.pdf}

### Summary

\center\includegraphics[width=.8\textwidth]{fig/ea-modeling-8.pdf}

### Step 7: Check

- Check that every information that you have identified is represented. Those that are not represented are mappings
  - The Customer: the Customer entity
  - The device and its type: the mapping between the device and its type
  - The rental: the mapping between the customer, the device and the rental start date

### Remarks

- This method does not work for every single case (choosing the primary keys)
- The obtained schema may not represent reality as intuitively as other schemas
- Some steps may be interactive (useful if the graph of FD is not exact)
- The schema should be validated, which may drive to use other concepts of the E-A model
- This method is useful for small sized-problems

### The empirical method

- Cut the problem into several smaller problems
- Analyze the information to deduce the entities
- Define the mappings between entities
- Define the properties of the entities and mappings
- Define the identifiers
- Iterate if required


### Define the entities

\center\includegraphics[width=.8\textwidth]{fig/empirical-1.pdf}

### Link entities with mappings

\center\includegraphics[width=.8\textwidth]{fig/empirical-2.pdf}

### Beware of mappings that are also entities

\center\includegraphics[width=.6\textwidth]{fig/empirical-3.pdf}

- Can a customer rent several times the same device?
  - Yes implies transforming Rental into an entity

### Tranforming entities

\center\includegraphics[width=.6\textwidth]{fig/empirical-4.pdf}

### Adding properties

\center\includegraphics[width=.6\textwidth]{fig/empirical-5.pdf}

### Properties added

\center\includegraphics[width=.6\textwidth]{fig/empirical-6.pdf}

### Add cardinalities

\center\includegraphics[width=.6\textwidth]{fig/empirical-7.pdf}

### Cardinalities added

\center\includegraphics[width=.6\textwidth]{fig/empirical-8.pdf}

## Conclusion on the E-A model

### Function modeling

- Based on
  - Entities
    - Properties
    - Identifiers
  - Mappings (associations)
    - Linking entities
    - Properties
    - Cardinalities

### The E-A model

- Simple
- Good rendering of reality
- Well adapted to the translation to a physical model
- \textcolor{red}{\textbf{BUT}}
  - Does not take into account the processings
  - Limited Cardinalities
  - Constraints are not taken into account

# The relational model

### What is it?

- The relational model: a formal model
  - relations, tuples, attributes, identifiers
  - relational algebra
  - relational computations
- Logical model but an implementation: SQL
  - table, column, line, primary key
  - Definition language
  - Manipulation language
  - Query language

### The relational model

  - History
    - Coming from the mathematical set theory
    - Introduced in 1970
      - Edgar Frank Codd, IBM Research Center, San José, CA
      - Got the Turing price in 1986
    - Developed by IBM Lab
    - As an improvement to relational algebra
  - Used today by most databases systems (Oracle, Informix, DB2, Ingres, Sybase)
  - 2 main concepts
    - Relations
    - Attributes (fields)

### Definitions

- An **attribute** is a *simple* and *mono-valued* element which is characteristic of a property
- A **relation** is a formal structure with a name and a list of attributes
  - *RelationName(Attribute1, Attribute2,...)*
- A **relational database** is a set of relations that model a problem

### Attributes

- An **attribute** is an information (a name)
- Examples
  - the name of a person
  - its height
  - the capacity of a hard disk
  - the size of a screen

### Domain

- The **domain** is the (finite or infinite) set of of values that an attribute may take
- Examples:
  - a person name: the set of strings
  - the size of a person: the set of real numbers (most probably we can be a bit more restrictive...)

### Remarks

- An attribute has a single value; it cannot contain multiple values
- Incorrect example:
  - Degree=\{Ingénieur Centrale Nantes, Master Computer Science Bordeaux, Phd Université Toulouse\}
  - The correct version will be seen later

### Schema

- A **relation** is a non empty set of attributes
- The **schema of a relation** is the list of attributes of a relation
- The **degree** of a relation is the number of its attributes
- The **schema of the relational database** is the set of the schemas of all the relations of the relational database

### Tuples

- A **tuple** or an **occurrence** of a relation is a set of consistent value of the attributes of the relation
- The **population** of a relation is the set of tuples of this relation
- The **cardinality** of a relation is the number of tuples it contains


### Example

\center\includegraphics[width=\textwidth]{fig/tuple.png}

### Tuples may be incomplete

\center\includegraphics[width=\textwidth]{fig/incompletetuple.png}

### Incomplete tuples

- A tuple **cannot** have an empty attribute (i.e. an attribute without a value)
- Therefore a specific value is used:
  - no known value for this attribute
  - defined as **`NULL`**
- Remarks
  - **`NULL`** denotes an absence of information, which is a piece of information as is
  - **`NULL`** has no type and can thus replace an information of any kind
  - **`NULL`** is not a value and must be therefore carefully manipulated

### Corrected example with unknown data

  \center\includegraphics[width=\textwidth]{fig/nulltuple.png}

### Identifier


- The **identifier** of a relation is the minimum set of attributes of a relation such that there never exists two tuples with the same values for those attributes
- Remarks:
  - Any relation **must** have an identifier
  - A relation may have several potential identifiers. Only one (the most appropriate) will be used
  - The identifier of a relation is denoted by underlining the attributes composing it
  - The identifier cannot have an attribute that may contain a null value
    - i.e. all data must be known for the attributes of the identifier
  - A relation cannot have 2 tuples for which the identifiers have the same value

### Example

*Student(LastName, FirstName, \underline{StudentId}, Birthdate)*

  \center\includegraphics[width=\textwidth]{fig/identifier.png}

### Why do we need an identifier?

\center\includegraphics[width=\textwidth]{fig/homonyms.png}

### External link and external identifier

- An **external link** between two relations is the oriented symbolic link between two sets of attributes of same nature in both relations
- An **external identifier** of a relation is a set of attributes matching an identifier of a (other) relation in the relational database
- Remark
  - The external identifier is denoted by an arrow starting from the set of attributes of the starting relation and ending with the arrival relation

### Example

  \center\includegraphics[width=\textwidth]{fig/externalid.png}

- There exists an external link between *Follows*'s *StudentId* and the identifier of *Student*
- There exists an external link between *Follows*'s *CourseNumber* and the identifier of *Course*

### Example

  \center\includegraphics[width=\textwidth]{fig/relation.png}

### Consequence of referential integrity

- It is impossible to add a tuple in the first relation if there is no matching tuple in the second relation
- It is impossible to remove a tuple of the second relation if it is linked to a tuple in the first one
- It is impossible to update a tuple of the second relation if is is linked to a tuple of the first one and if the update makes it have a non-existent value in the first relation

### Example

\center\includegraphics[width=\textwidth]{fig/referentialintegrity.png}

### Graphical representation

\center\includegraphics[width=\textwidth]{fig/graphicalrep.png}


# Logical and physical models

### Context


- So far, we have conceptual models
  - Entity-Association
  - UML
  - *SysML*
- We remember of mentioning the relational model
- How to switch from one model to another one?
  - Logical model
  - Physical model

### Logical and physical models

- Data logical model
  - it consists in describing the data structure that is used without referring to a specific programming language
- Data physical model
  - it is a formalism that allows to specify the storage system used in a DBMS

## From the E-A model to the relational model

### Entity-Association model

- Entities
- Associations
- Properties
- Identifiers
- Cardinalities

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-1.pdf}

### Translation process

- 3 translation rules
  - 1 for entities
  - 2 for associations
- Rules must be applied in the right order
  - will provide a Logical data model
- Domain values must be added to have a physical model

### Rule 1

- Every entity is translated into a relation
- Its properties are the  attributes of the relation
- Its identifier is the identifier of the relation

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-1.pdf}

- Student(\underline{StudentId},Lastname,Firstname)
- Course(\underline{AbbName},Name)
- Faculty(\underline{FacultyId},Lastname,Firstname)
- Status(\underline{StatusName})

### Rule 2

- Every binary association which cardinality is either 0:1 or 1:1 is translated by copying the identifier of the opposite entity in the entity having 0:1 or 1:1 cardinality
- An external identifier is created between the two relations
- The properties of the association are also copied
- If the two involved cardinalities are 0:1 or 1:1, the most representative is chosen

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-2.pdf}

- Student(\underline{StudentId},Lastname,Firstname)
- Course(\underline{AbbName},Name)
- Faculty(\underline{FacultyId},Lastname,Firstname,\textcolor{red}{StatusName})
- Status(\underline{StatusName})

### Rule 3

- The remaining associations are translated into relations. The identifiers of the linked entities are copied into the new relation and are its identifiers
- An external identifier is created between the new relation and each linked entity at the identifier level
- The properties of the associations are also copied

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-3.pdf}

- Student(\underline{StudentId},Lastname,Firstname)
- \textcolor{red}{Participates(StudentId,AbbName)}
- Course(\underline{CourseId},Name)
- \textcolor{red}{Teaches(FacultyId,AbbName)}
- Faculty(\underline{FacultyId},Lastname,Firstname,StatusName)
- Status(\underline{StatusName})

### Logical data model

\center\includegraphics[width=.8\textwidth]{fig/lpm-4.pdf}

## From the logical model to the physical model


### From the logical model to the physical model

- Add the domain values for the properties
- i.e. consider again every property and add it its domain
- Caution to external links: attributes must have the same domains

### Physical data model

\center\includegraphics[width=.8\textwidth]{fig/lpm-5.pdf}


### Summary

- Advantages
  - translation fairly intuitive
  - few transformation rules
- Caution: adding domain values for properties


# Introduction to relational algebra

### Principle

Select the desired information, express them under the form of a relation obtained by successive applications of unary of binary operators whose operands are relations


### Motivation

- Why relational algebra?
  - mathematical foundations of the query language
  - basic principles of the queries
  - mathematically provable
  - useful for optimizing implementations

### Reminder

- An algebra is a set of operators, formally defined, that can be combined to build algebraic expressions
- Properties
  - Closure: the result of every operator is of the same type as the operands
  - (wished) Completeness: Every manipulation desired by the user should be expressed by an algebraic expression

### In our case

- Operands: relations of the relational model
- Closure: the result of every operation is a relation
- Completeness: allows every operation except transitive closure and aggregation functions

### Relations

- They are expressed as *Relation(Attribute1, Attribute2 ...)*
- They have an identifier

### 5 basic operators

- Selection ($\sigma$)
- Projection ($\pi$)
- cartesian product ($\times$)
- union ($\bigcup$)
- difference ($-$)

### and derived operators

- Renaming ($\alpha$)
- join ($\star$)
- intersection ($\bigcap$)
- division ($/$)

## Basic operators

### Selection (or restriction)

- Objective: restrict to some tuples in a relation

**Country**  Name          Capital       Population     Surface
-----------  ------------- ---------   ------------   ---------
             Austria       Vienna          8               83
             UK            London          56             244
             Switzerland   Bern            7                41

We only want the countries which surface < 100: $SmallCountry = \sigma[surface<100] Country$

### Selection (or restriction)

$SmallCountry = \sigma[surface<100] Country$


**Country**  Name          Capital       Population     Surface
-----------  ------------- ---------   ------------   ---------
             Austria       Vienna          8               83
             ~~UK~~        ~~London~~     ~~56~~             ~~\textcolor{red}{\textbf{244}}~~
             Switzerland   Bern            7                41


### Selection (or restriction)

- Syntax: $\sigma [c] R$ where
   - $c$: selection condition  
   - $R$: relation
- Elementary condition: *attribute comparison-operator constant-or-attribute*
   - *attribute* is an attribute of $R$
   - *comparison-operator* $\in$ $=,\neq,<,>,\leq,\geq$
- Conditions may be elementary or composed (AND/OR) or negated
   - Parentheses may be used


### Examples

- $\sigma [Name=Capital] Country$: country which has the same name as its capital
- $\sigma [(Surface>100 AND Surface<500) OR (Population>30 AND Population<300)] Country$: country with surface between 100 and 500 and population between 30 and 300

### Selection (or restriction)

- Semantics: creates a new relation of schema $R$  with the set of tuples of $R$ that satisfy the condition
- Schema(result) = schema(operand)
- Population(result) $\leq$ population(operand)

### Projection

- Objective: restrict a relation to only some of its attributes

**Country**  Name          Capital       Population     Surface
-----------  ------------- ---------   ------------   ---------
             Austria       Vienna          8               83
             UK            London          56             244
             Switzerland   Bern            7                41

- We only want the name and capital attributes: $Capital = \pi[Name,Capital] Country$


### Projection

$Capital = \pi[Name,Capital] Country$

**Capital**  Name          Capital   
-----------  ------------- ---------
             Austria       Vienna    
             UK            London    
             Switzerland   Bern      

### Projection

- Syntax: $\pi[attributes] R$
   - $attributes$ list of attributes to be kept
   - Semantics: creates a new relation with the set of tuples of $R$ but with only the attributes belonging to the *attributes* list
- Schema(result)  $\leq \pi$ schema (operand)
   - Population(result) $\leq$  Population(operand)
   - Why?

### Consequences on tuples

- If a projection does not keep the identifier of the relation, it may generate identical tuples
 - only the identifier is guaranteed for unicity
 - The result will only keep distinct tuples (closure)


### Cartesian product (or join)

- objective: build all possible tuple compilations from 2 relations
- binary operator, syntax: $R \times S$
- Semantics: every tuple of $R$ is combined with every tuple of $S$
- Schema: schema ($R \times S$) : schema($R$) $\times$ schema($S$)
- precondition: $R$ and $S$ do not have any common attribute
  - otherwise, renaming is mandatory *before* the product

### Union

- syntax: $R \cup S$
- semantics: gathers in a relation all tuples of $R$ and $S$
- precondition: $R$ and $S$ have the same schema!
- schema($R \cup S$) = schema($R$) = schema($S$)
- Side effect: double tuples may be created
   - they are automatically removed from the result

### Difference

- syntax: $R - S$
- semantics: selects tuples of $R$ that are not in $S$
- schema($R - S$) = schema($R$) = schema($S$)
- precondition: $R$ and $S$ have the same schema!

### Expression combination

 - We can look for the capitals of small countries
 - Remember
   - $SmallCountry = \sigma[surface<100] Country$
   - $Capital = \pi[Name,Capital] Country$
 - Then
   - $CapitalSmallCountry = \pi [Name,Capital] SmallCountry$
   - $CapitalSmallCountry = \pi [Name,Capital] \sigma[surface<100] Country$
 - Warning: combination is not commutative!
   - see data types...

## Other operators

### Renaming

- objective: solve compatibilities issues between attributes names for relations used in binary operators
- $\alpha$ operator is unary
- Example: $R_2 = \alpha [B \rightarrow C] R_1$
  - $B$ attribute of relation $R_1$ is renamed as $C$
- Semantics: All tuples of $R$ are kept with a new attribute name
- Schema is slightly modified
- precondition: the new attributes names were not pre-existing

### Complement

- objective: built all tuples combination that complement the tuples of $R$
- $\neg$ operator is unary
- syntax: $S = \neg R$  
- pre-condition: you have to work on finite domains to do that!
- schema: identical
- tuples: complement (all that are not in $R$)

### Example

\center\includegraphics[width=5cm]{fig/complement.pdf}

### Natural join

- objective: create all **significant** combinations between the tuples of 2 relations
  - *significant*: have the same values for the attributes which have the same name
- precondition: both relation have at least one attribute with the same name
- syntax: $R \star S$ or $R \bowtie S$

\center\includegraphics[height=2cm]{fig/ra_naturaljoin.png}

### Example 1

\center\includegraphics[width=\textwidth]{fig/naturaljoin_ex1.png}

### Example 2

Couples are only built when it is possible

\center\includegraphics[width=\textwidth]{fig/naturaljoin_ex2.png}

### theta-join or outer join

- objective: create all significant combination between tuples of two relations
  - *significant*: according to a combination criterion which is explicitly defined as a parameter
- precondition: Both relation do not have attributes with common names
- Syntax: $R \star [ condition ] S$ or $R \bowtie[condition] S$
  - example: $R \star [ B \neq C] S$

\center\includegraphics[height=2.2cm]{fig/ra_thetajoin.png}

### theta-join or outer-join

- binary operator
- $c$: join condition
- elementary-condition:
  - attribute1 comparison-operator attribute2
  - attribute1 is a member of relation $R$
  - attribute2 is a member of relation $S$
  - comparison-operator: =,$\neq$,$<$,$>$,$\geq$,$\leq$
- condition:
  - elementary-condition
  - condition AND/OR condition
  - NOT condition
  - ( condition )

### Example

- Given the following relations
  - *Country(name,capital,population,surface,continent)*
  - *SpokenLanguage(language,country,%population)*
- Query: For every language, in which continent is it spoken?

. . .


\begin{exampleblock}{Answer}
\tiny $$\pi[language,continent](SpokenLanguage \bowtie [country = name]Country)$$
\end{exampleblock}

### Semi-join

- objective: same as join but only attributes of $R$ are kept
- syntax: $R \ltimes S$
- The resulting schema will be the schema of $R$

\center\includegraphics[height=2.2cm]{fig/leftsemijoin.png}

### Intersection

- syntax: $R \cap S$
- semantics: gathers in a relation tuples that belong to both  $R$ and $S$
- precondition: $R$ and $S$ have the same schema!

\center\includegraphics[width=5cm]{fig/intersection.pdf}

### Remark

- $R \cap S = R - (R - S)$

\center\includegraphics[width=7cm]{fig/inter-diff.pdf}

### Division

- objective: handle queries such  as " the ... such as ALL the ..."
- Let us consider $R(A_1,...A_n)$ and $V(A_1,...,A_m)$ with $n>m$ et $A_1,...,A_m$ attributes of same name in $R$ and $V$
- $R/V$ are the tuples from $R$ with the only attributes $A_m+1,...,A_n$  which exist in $R$ appended with to all tuples of $V$
- $R/V = \{ <a_{m+1},...a_n> / \forall <a_1,...,a_n> \in V$, $\exists <a_1,...,a_m,a_{m+1},...,a_n> \in R\}$

### Division

\center\includegraphics[width=7cm]{fig/division.pdf}

### Properties of relational algebra

- Operator combination has properties which allow to:
  - implement queries
  - optimize queries
  - simplify queries
  - detect errors

### A few properties

- Joins, Unions and intersections are commutative
  - $R1 \times R2 = R2 \times R1$
- Joins, Unions, and intersections are associative
  - $(R1 \times R2) \times R3 = R1 \times (R2 \times R3)$
- Selection grouping
  - $\sigma[A2='b']\sigma[A1='a']$
  - $R1 = \sigma[(A2='b' and A1='a')] R1$

### Properties

- Combining selections and unions
  - $\sigma[A1='a'](R1 \cup R2) = (\sigma[A1='a']R1)\cup (\sigma[A1='a']R2)$
- Combining selections and projections
  - $\pi[A1...Ap]\sigma[Aj='a']R1$
    - $=\sigma[Aj='a']\pi[A1...Ap]R1$ if $Aj \in A1...Ap$
    - $=\pi[A1...Ap]\sigma[Aj='a']\pi[A1...Ap]R1$ if $Aj \notin A1...Ap$
  - Combining selections and joins
    - $\sigma[Ai='a' and Bj='b']R1 \times R2 = \sigma[Ai='a']R1 \times \sigma[Bj='b']R2$ with $Ai \in R1, Bj \in R2$

### Optimization

- The query optimizer uses the following principles
  - first, processes the selections and projections
  - then does the products, joins with minimum data
  - groups successive selections and projections
  - groups sequences of products or joins and projections

## Relational algebra and optimization
# Introduction to SQL

### Introduction

- SQL: Structured Query Language
- It is normalized
  - SQL2: adopted as SQL92
  - SQL3: adopted as SQL99
- **The** Standard for access to relational databases

### A bit of history

- SQL86 - SQL89 - SQL91
  - queries were compiled then executed from an application program
  - few set instructions (`UNION`)
- SQL92
  - dynamic queries (immediate or scheduled execution)
  - several join types (natural vs external)
  - set instructions: difference (`EXCEPT`), intersection (`INTERSECT`), renaming attributes in the `SELECT` statement
- SQL99
  - rational expressions, recursive queries, triggers
- SQL 2003 and 2008
  - XML, new functions
- Today
  - Evolving towards an object-oriented version
  - Mode set instructions

### SQL includes 4 different languages

  - Data Definition Language (DDL)
    - relation creation: `CREATE TABLE`
    - relation modification: `ALTER TABLE`
    - relation removal: `DROP TABLE`
    - views, index...: `CREATE VIEW`
  - Data Manipulation Language (DML) = CRUD
    - tuple insertion: `INSERT`
    - tuple modification: `UPDATE`
    - tuple removal: `DELETE`
    - `SELECT ... FROM ... WHERE ...`
  - Transaction Control Language (TCL)
    - `BEGIN`
    - `COMMIT`, `ROLLBACK`
  - Access Control Language (ACL)
    - `GRANT`, `REVOKE`

### But...

- Depending on Databases tools, SQL instructions are not completely identical!
  - DDL: data types, syntax
  - DML: queries, implementations, functions

### Terminology

- Relation $\Longleftrightarrow$ table
- Tuple $\Longleftrightarrow$ line
- Attribute $\Longleftrightarrow$ column
- Identifier $\Longleftrightarrow$ primary key
- External identifier $\Longleftrightarrow$ external key (foreign key)

## Data Manipulation Language

### SQL Query language

- Based on  relational algebra
- one statement, selection
- **Every selection has a (temporary) table as result**

### Selection

~~~sql
SELECT columnlist FROM tablelist
~~~

- Selection creates a table with **all** the lines matching the query (there may be duplicates) in a random order
- Selection is comparable to projection in relational algebra

~~~sql
SELECT * FROM tablelist
~~~

- The joker character $\star$ is used to return all columns of the result table

### Example

**Country**  Name          Capital       Population     Surface
-----------  ------------- ---------   ------------   ---------
             Austria       Vienna          8               83
             UK            London          56             244
             Switzerland   Bern            7                41

~~~SQL
SELECT Name,Capital from Country
~~~

**Country**  Name          Capital    
-----------  ------------- ---------  
             Austria       Vienna     
             UK            London     
             Switzerland   Bern       

### Beware

**Student**  Lastname      Firstname   StudentId      Birthdate
-----------  ------------- ---------   ------------   ---------
              128 char      128 char    12 char        4 bytes

- We have 12000 students in the database
- Wa have a 100Mbit/s network
- `SELECT * FROM Student`
  - $12000 \times (128+128+12+4) = 3,26$Mb hence $0.26$s
- `SELECT StudentId,Birthdate FROM Student`
  - $12000 \times (12+4) = 192$kb hence $0.015$s

### To remove duplicates

  ~~~sql
  SELECT DISTINCT columnlist FROM tablelist
  ~~~

  allows to obtain only distinct values for columns

### Example

**Student**  Lastname      Firstname   StudentId      Birthdate
-----------  ------------- ---------   ------------   ---------
             AUBRY         Delphine    090146C        02/02/90
             AUBRY         Stéphane    090023A        17/02/90
             BROSSE        Alexandre   090341X        10/01/91
             AUBRY         Delphine    090225W        20/05/90

~~~SQL
SELECT Lastname,Firstname FROM Student
~~~

**Student**  Lastname      Firstname  
-----------  ------------- ---------  
             **AUBRY**     **Delphine**
             AUBRY         Stéphane   
             BROSSE        Alexandre  
             **AUBRY**     **Delphine**

### Example

**Student**  Lastname      Firstname   StudentId      Birthdate
-----------  ------------- ---------   ------------   ---------
             AUBRY         Delphine    090146C        02/02/90
             AUBRY         Stéphane    090023A        17/02/90
             BROSSE        Alexandre   090341X        10/01/91
             AUBRY         Delphine    090225W        20/05/90

~~~SQL
SELECT DISTINCT Lastname,Firstname FROM Student
~~~

**Student**  Lastname      Firstname  
-----------  ------------- ---------  
             AUBRY         Delphine   
             AUBRY         Stéphane   
             BROSSE        Alexandre  

### Restrictions on lines

~~~sql
SELECT columnlist
FROM tablelist
WHERE constraintslist
~~~

`constraintslist` indicates the restrictions that must be applied

### Restrictions on lines

- Simple condition
  - *attribute1 operator value*
  - *attribute1 operator attribute2*
  - *attribute BETWEEN x AND y* where *x* and *y* may be values or attributes...
  - operators: <, >, =, <>...
- *AND* between conditions
  - `condition1 AND condition2`
- *OR* between conditions
  - `condition1 OR condition2`
- parentheses can of course be applied

### Example

**Student**  Lastname      Firstname   StudentId      Birthdate
-----------  ------------- ---------   ------------   ---------
             AUBRY         Delphine    090146C        02/02/90
             AUBRY         Stéphane    090023A        17/02/90
             BROSSE        Alexandre   090341X        10/01/91
             AUBRY         Delphine    090225W        20/05/90

~~~SQL
SELECT Lastname,Firstname FROM Student
  WHERE Birthdate = '17/02/90'
~~~

**Student**  Lastname      Firstname
-----------  ------------- ---------
             AUBRY         Stéphane  


### Strings

- Strings in SQL are enclosed between quotes
  - `'this is a string'`
  - if a quote is used in a string, it must be doubled (some DBMS accept C-like escaping such as `\'`)
  - `'I''am the best'`
- Equality checks are case sensitive
  - i.e. `'Test'` is not equal to `'test'`
- Lexicographic order is used


### LIKE

- A specific operator for character strings
- `attribute LIKE 'string'`
  - `attribute` is equal to `'string'` which may contain jokers
    - % replaces any character string
    - _ replaces one single character
- Some DBMS also have `ILIKE` operator which is case insensitive


### Example

**Student**  Lastname      Firstname   StudentId      Birthdate
-----------  ------------- ---------   ------------   ---------
             AUBRY         Delphine    090146C        02/02/90
             AUBRY         Stéphane    090023A        17/02/90
             BROSSE        Alexandre   090341X        10/01/91
             AUBRY         Delphine    090225W        20/05/90

~~~SQL
SELECT Lastname,Firstname FROM Student
  WHERE Lastname LIKE 'B%'
~~~

**Student**  Lastname      Firstname  
-----------  ------------- ---------  
             BROSSE        Alexandre  


### NULL

- `attribute IS NULL` tests whether `attribute` does not have a value
  - converse: `attribute IS NOT NULL`
  - beware of using null in composed conditions

### IN

- `attribute IN ( valueslist )`
- is equivalent to `attribute=v1 OR attribute=v2 OR ...`
  - where `valueslist = v1,v2...`
  - Note: the value list can be the result of a query itself
- conversely, you can use `attribute NOT IN ( valueslist )`


### Example

**Student**  Lastname      Firstname   StudentId      Birthdate
-----------  ------------- ---------   ------------   ---------
             AUBRY         Delphine    090146C        02/02/90
             AUBRY         Stéphane    090023A        17/02/90
             BROSSE        Alexandre   090341X        10/01/91
             AUBRY         Delphine    090225W        20/05/90

~~~SQL
SELECT Lastname,Firstname FROM Student
  WHERE Firstname IN ('Alexandre','Delphine')
~~~

**Student**  Lastname      Firstname   
-----------  ------------- ---------   
             AUBRY         Delphine    
             BROSSE        Alexandre   
             AUBRY         Delphine    

### Dates

- Dates and times use a special format
  - DATE: YYYY-MM-DD
  - TIME: HH:MM:SS
  - TIMESTAMP: YYYY-MM-DD HH:MM:SS
  - they are specific types but are used as strings
    - this organization allows comparison between dates
  - Example: 2019-01-14 13:45:22
- Lots of functions to work on dates (including timezones issues)

### Join

~~~sql
SELECT listofattributes
FROM tablelist
WHERE constraintslist
~~~

- Is doing the cartesian product between the indicated tables, applies the constraints and selects the indicated columns
- Beware of ambiguities
  - Some attributes may have the same name in several tables
  - Attributes name can be prefixed or suffixed by their table name
- If a table is to appear several time in a join?
  - tables can be renamed
  - same table appears several times  with different names  

### Examples

~~~sql
SELECT LastName, StudentId
FROM Person,Student
WHERE Person.Person_ID = Student.Person_ID
AND LastName LIKE 'D%'

SELECT LastName
FROM Person, Student, Faculty
WHERE Person.Person_ID = Student.Person_ID
  AND Person.Person_ID = Faculty.Person_ID
  ~~~


### Renaming table example

- Where were the students living in Paris born?
- Student(\underline{StudentId},Lastname,Firstname,Birthcity_ID,LivingCity_ID)
- City(\underline{City\_ID},CityName)


. . .

~~~sql
SELECT LastName, City1.Name
FROM Person, City City1, City City2
WHERE Person.Birthcity_ID = City1.City_ID
  AND Person.LivingCity_ID = City1.City_ID
  AND City2.Name = 'Paris'
~~~

### Renaming columns

- It can be practical to rename columns
- Use the `AS` operator
  - *oldname* `AS` *newname*
- Example

~~~sql
SELECT Person_ID,Person.Person_Name AS Name
FROM Person
WHERE Person.Person_Name = 'Jack'
~~~

### Join types (SQL2)

- Cartesian-product
~~~sql
R1 CROSS JOIN R2
~~~
- Theta-join
~~~sql
R1 INNER JOIN ON (R1.A < R2.B)
~~~
- Natural Join
~~~sql
R1 NATURAL JOIN R2
~~~
- Note: `SELECT ... FROM R1,R2` is a Cartesian-product

### Natural join

- Given the following relations
  - *Person(\underline{Person\_ID},LastName,FirstName)*
  - *Student(\underline{Student\_ID},Person_ID,Number)*

~~~sql
SELECT LastName, Number
FROM Person NATURAL JOIN Student
~~~

- All common attributes are taken into account
- The join constraint is performed on **attributes names**
  - caution : all common attributes are involved

### Result: natural join

\center\includegraphics[width=\textwidth]{fig/naturaljoin.png}

### Outer join

\center\includegraphics[width=\textwidth]{fig/outerjoin.png}

### Left outer join

\center\includegraphics[width=\textwidth]{fig/leftouterjoin.png}

### Right outer join

\center\includegraphics[width=\textwidth]{fig/rightouterjoin.png}


### Theta-join

- Given the following relations
  - *Person(\underline{Person\_ID},LastName,FirstName)*
  - *Student(\underline{Student\_ID},Person_ID,Number)*

~~~sql
SELECT LastName, Number
FROM Person JOIN Student ON (Person.LastName < 'B')
~~~

- The join is performed by following the indicated predicate
- Full, right and left outer join can be applied to theta-join

~~~sql
R1 (FULL | RIGHT | LEFT) OUTER JOIN R2 ON predicate
~~~

### Unions

- The `UNION` operator performs the union of two tables
- All duplicates are removed. If you want to keep them, use `UNION ALL`

~~~SQL
(SELECT Person.LastName
  FROM Person, Student
  WHERE Person.Person_ID = Student.Person_ID
)
UNION
(SELECT Person.LastName
  FROM Person, Faculty
  WHERE Person.Person_ID = Faculty.Person_ID
)
~~~

### Differences (non standard)

- The `EXCEPT` operator performs the difference (as defined in relational algebra) between two tables
- It is **not** implemented in every database engine

~~~sql
(SELECT Person.LastName FROM Person, Student
  WHERE Person.Person_ID = Student_PersonID)
EXCEPT
  (SELECT Person.LastName
    FROM Person, Faculty
    WHERE Person.Person_ID = Faculty.Person_ID)
~~~

### Intersection (non standard)

- The `INTERSECT` operator performs the intersection between two tables
- It is **not** implemented in every database engine

~~~sql
(SELECT Person.LastName FROM Person, Student
  WHERE Person.Person_ID = Student_PersonID)
INTERSECT
  (SELECT Person.LastName
    FROM Person, Faculty
    WHERE Person.Person_ID = Faculty.Person_ID)
~~~

### Embedded queries: IN

- The result of a `SELECT` is a temporary table
- It can be used in another `SELECT`
- The included selection should have only **one** column

~~~sql
SELECT LastName
FROM Person
WHERE Person_ID IN (SELECT Person_ID FROM Student)

SELECT LastName
FROM Person
WHERE Person_ID NOT IN (SELECT Person_ID FROM Faculty)
AND Person_ID IN (SELECT Person_ID FROM Student)
~~~

### Embedded queries: ANY

- `ANY` is used to compare an attribute to a set of values obtained by an embedded query
- the `ANY (SELECT F FROM ...)` condition is true if and only if the comparison is true for at least a value of the result of the `(SELECT F FROM ...)`
- Note: `IN` and `= ANY` are equivalent


~~~SQL
SELECT Provider
FROM Hardware
WHERE Name = 'Brick'
AND Price < ANY (SELECT Price FROM Hardware
  WHERE Name = 'Slate')
~~~

### Embedded queries: ALL

- `ALL` is used to compare an attribute to a set of values obtained by an embedded query
- The `ALL (SELECT F FROM ...)` condition is true if and only if the comparison is true for all the values of the result of the `(SELECT F FROM ...)`
- Note: `NOT IN` and `NOT = ALL` are equivalent


~~~sql
SELECT Provider
FROM Hardware
WHERE Name = 'Brick'
AND Price < ALL (SELECT Price FROM Hardware
  WHERE Name = 'Slate')
~~~

### Embedded queries: EXISTS

- `EXISTS` allows to check that the result of a query is non empty
- The `EXISTS(SELECT * FROM ...)` is true if and only if the result of the `(SELECT * FROM ...)` is not empty

~~~SQL
SELECT Provider
FROM Hardware
WHERE EXISTS (SELECT *
  FROM Provider
  WHERE ProviderName = Provider.Name)
~~~

## Aggregation functions

### Example

- We want average grades per group
- Here is the Grades table

Group  |    Grade | \underline{StudentId}
--|---|--
A  | 10  | 090146C
A  | 12  | 090023A
A  | 16  | 090341X
B  | 10  | 091234A
C  | 8  | 095432S
A  | 4  | 099875D
B  | 19  |  098743M
A  | 15  | 093489F


### Example

Group  |    Grade | \underline{StudentId}
--|---|--
\textcolor{blue}{A}  | \textcolor{blue}{10}  | \textcolor{blue}{090146C}
\textcolor{blue}{A}  | \textcolor{blue}{12}  | \textcolor{blue}{090023A}
\textcolor{blue}{A}  | \textcolor{blue}{16}  | \textcolor{blue}{090341X}
\textcolor{green}{B}  | \textcolor{green}{10}  | \textcolor{green}{091234A}
\textcolor{red}{C}  | \textcolor{red}{8}  | \textcolor{red}{095432S}
\textcolor{blue}{A}  | \textcolor{blue}{4}  | \textcolor{blue}{099875D}
\textcolor{green}{B}  | \textcolor{green}{19}  |  \textcolor{green}{098743M}
\textcolor{blue}{A}  | \textcolor{blue}{15}  | \textcolor{blue}{093489F}

### Example

Group  |    Grade | \underline{StudentId}
--|---|--
\textcolor{blue}{A}  | \textcolor{blue}{10}  | \textcolor{blue}{090146C}
\textcolor{blue}{A}  | \textcolor{blue}{12}  | \textcolor{blue}{090023A}
\textcolor{blue}{A}  | \textcolor{blue}{16}  | \textcolor{blue}{090341X}
\textcolor{blue}{A}  | \textcolor{blue}{4}  | \textcolor{blue}{099875D}
\textcolor{blue}{A}  | \textcolor{blue}{15}  | \textcolor{blue}{093489F}
\textcolor{green}{B}  | \textcolor{green}{10}  | \textcolor{green}{091234A}
\textcolor{green}{B}  | \textcolor{green}{19}  |  \textcolor{green}{098743M}
\textcolor{red}{C}  | \textcolor{red}{8}  | \textcolor{red}{095432S}

### GROUP BY

- `GROUP BY` allows to group tuples according to the values of an attribute1
- generally used with aggregation functions

~~~sql
SELECT Group, avg(Grade)
FROM GradesList
GROUP BY Group
~~~

- allows to group tuples by *Group* and thus to compute the average of each group

### Example

Group  | Grade  
--|--
\textcolor{blue}{A}   |  \textcolor{blue}{11.4}
\textcolor{green}{B}  |  \textcolor{green}{14.5}
\textcolor{red}{C}   |  \textcolor{red}{8}

### Aggregation functions

- They allow to group lines into subgroups to apply computations to **each** of the subgroups
- When `GROUP BY` is used, **all** columns that do not participate into the computation **must** appear in the `GROUP BY`
- Caution: function combinations are mostly impossible (`max(count(...))`)

~~~sql
SELECT Year, Group, avg(grade)
FROM GradesList
GROUP BY Year, Group
~~~

### Aggregation functions: HAVING

- `GROUP BY ... HAVING ...` allows to perform selection among the tuples that have been grouped

~~~sql
SELECT group, avg(grade)
FROM GradesList
GROUP BY Group HAVING count(*) > 5
~~~

- same as before but only for groups of 5 or more grades

### Aggregation functions avalaible

- `AVG`: average
- `COUNT`: number of lines
- `MAX`: maximum
- `MIN`: minimum
- `SUM`: sum
- in fact, most DBMS propose more, not always portable


### Functions: count

- `count(...)` counts the number of tuples in a relation

~~~sql
SELECT count(*)
FROM Personne, Eleve
WHERE Personne.Personne_ID=Eleve.Personne_ID

SELECT count(DISTINCT Personne.Nom)
FROM Personne, Eleve
WHERE Personne.Personne_ID=Eleve.Personne_ID
~~~

### Functions: sum

- `sum(...)` sums the values of an attribute
- `avg(...)` computes the average of the values of an attribute
- other functions: `min(...)`, `max(...)`...

~~~sql
SELECT sum(Price)
FROM Order
WHERE CustomerName = 'John Doe'

SELECT avg(Grade)
FROM Grades
WHERE Group='B1'
~~~

### Other useful functions

- `UPPER` puts an attribute or a value in upper case letters
- `LOWER` is the symetric function
- `TO_DATE` converts a string into a date
  - example: `TO_DATE('2017-11-17','YYYY-MM-DD')`
- `EXTRACT` extracts an information from a date (non standard)
  - `EXTRACT(MONTH FROM thedate)`
  - `EXTRACT(HOUR FROM event)`
- `CONCAT` is used to append strings
- `SUBSTRING` extracts a substring of a string
- `TRIM` removes the space at the begin and at the end of a value
  - see also `LTRIM` and `RTRIM`

### Dates, times and timestamps

- Information extraction: 'EXTRACT'
  - can be applied to `DATE`, `TIME`, `TIMESTAMP` types
  - Data that can be extracted
    - `CENTURY`, `DECADE`
    - `YEAR`,`MONTH`,`DAY` (of the month)
    - `DOW`(day of the week)
    - `HOUR`, `MINUTE`, `SECOND`
    - `MICROSECOND`
    - `TIMEZONE`
    - ...
- More in the SQL documentation


### Quotes and double quotes

- By default, all tables and columns names are converted by the DBMS
  - i.e. `PERSON` = `Person` = `person` = `PeRsOn`
- If names have forced (with double quotes), case must enforced
  - `"PERSON"` is not equal to `"Person"`


### Sorting tuples: ORDER BY

- `ORDER BY` is used to sort tuples according to the values of one or several attributes (by any order)
  - `ASC` (default) sorts by ascending order
  - `DESC` sorts by descending order

~~~SQL
SELECT Person.LastName, City.Name
FROM Person, City
WHERE Person.Birthcity_ID = City.City_ID
ORDER BY City.Name, Person.LastName DESC
~~~

### Cast operator

- The results of a query are mapped to the schema of the result relation.
  - i.e. a colum in a select has the same type as the original column
- In some cases, it may not work, the type of a column may be changed (cast) to another one
  - `CAST(expression AS type)`
  - will convert expression to the new type, provided the operation is technically possible
- Example

~~~sql
SELECT Name,CAST(BirthDate AS VARCHAR) FROM Person
~~~


### SQL Queries

- Eventually SQL queries look like

~~~sql
SELECT column-list
FROM table-list-with-joins
WHERE join-conditions
GROUP BY column-list-for-aggregation  
HAVING aggregation-conditions
ORDER BY sorting-columns-list
~~~

- plus potential `UNION`...
- Evolutions
  - `WITH`: ability to define temporary tables
  - `WITH RECURSIVE`: same including recursion

## Building SQL queries

### How to build a query

- Methodological elements
  1. Start from the database schema (all the relations)
  2. Identify in the schema the properties you wish to obtain
  3. Add the properties on which you have constraints
  4. Establish a path between the relations that link those information

### Who are the students following the SSTEM course?

  \center\includegraphics[width=\textwidth]{fig/sstemstudents.png}

### Step 1

  \center\includegraphics[width=\textwidth]{fig/sstemstudents2.png}

### Step 2

  \center\includegraphics[width=.8\textwidth]{fig/sstemstudents3.png}

  . . .

  ~~~sql
  SELECT Student.LastName, Student.FirstName
  FROM Student
  NATURAL JOIN Follows
  NATURAL JOIN Course
  WHERE Abb = 'SSTEM'
  ~~~

## Modifying data

### Modifying data

- 3 statement types
  - `INSERT`: adding lines
  - `UPDATE`: updating lines
  - `DELETE`: removing lines
- Each of these statements can be applied to only and only table at a times


### Insertion

- `INSERT INTO TABLE(attr1, attr2,...) VALUES (val1, val2,...)`
- Mapping elements is done with regard to the position in the list
- Every non-included value will be `NULL`
- If the key already exists, insertion will lead to an error
- If a `NOT NULL` attribute is not present in the attribute list, insertion will lead to an error
- Example

~~~sql
INSERT INTO Student(StudentId,Lastname,Firstname)
  VALUES ('CN9023','HUBBLE','Damien')
~~~

### Alternative syntax

- `INSERT INTO table VALUES (val1,val2,...)`
- the mapping is done with regard to the order of definition of the columns in the schema
- Caution: when the schema is updated, those insert queries can cause trouble!

### Multiple insertion

- `INSERT INTO table(attr_list) VALUES (value_list1),(value_list2),...`
- is used to insert several values at a time
- Example

~~~sql
INSERT INTO Student(StudentId,Lastname,Firstname)
  VALUES ('CN9023','HUBBLE','Damien'),
    ('RF4322','MARTIN','Eléonore')
~~~

### Insertion from a SELECT

- `INSERT INTO table(attr_list) SELECT attr_list FROM ... WHERE ...`
- All lines obtained by the selection are included in the table
- The table schema must match the the column of the temporary table obtained through SELECT
- Example

~~~sql
INSERT INTO BornIn92(StudentId,Lastname,Firstname)
SELECT StudentId,Lastname,Firstname FROM Student
WHERE Birthdate BETWEEN '1992-01-01' AND '1992-12-31'
~~~

### DBMS specificities

- Oracle, PostgreSQL
  - there exists a `RETURNING` statement to return a column (primary key) of the line created by the INSERT STATEMENT
  - `INSERT INTO table(attr_list) VALUES (valueslist) RETURNING a column`
- MySQL
  - The same can be done with `LAST_INSERT_ID`

### Updating

- `UPDATE table SET list_assignements [WHERE conditions]`
- `list_assignements`
  - `attr1 = val1, attr2 = val2, ...`
- Update is working on only one table
- If the conditions return no tuple, no update is performed
- If the conditions return several tuples, all matched lines are updated
- Example

~~~sql
UPDATE Person SET Firstname = 'Alexis' WHERE Person_ID = 2
~~~

### Removing

- `DELETE FROM table [WHERE conditions]`
- Removals are performed on zone, one or several lines depending on the conditions
- Remove all lines matching the conditions
- If no line is matching the conditions, nothing is done
- Example

~~~sql
DELETE FROM Person where Person_ID = 2
~~~

### Limitations

- `INSERT, UPDATE, DELETE` work on only one table
- For some operations (mostly updates and removals), it may be necessary to refer to several tables
  - for example when referring to foreign keys
- Several solutions
  1. Embedded queries
  2. joins (only on some DBMS)

### Embedded queries

~~~sql
DELETE FROM Person WHERE Person_ID IN (
  SELECT Person_ID
  FROM Student
  WHERE StudentId LIKE '03%'
)
~~~

will remove all persons who are students whose student number starts by 03.

### Joins

~~~sql
UPDATE Person
SET Firstname = Student.StudentId
FROM Student
WHERE Person.Person_ID = Student.Person_ID
AND Numero LIKE '04%'
~~~

### Transactions

- Updates (all types) allow to modify the population of a table
- Problem
  - A user is barely the only one to use a table at a given instant
  - What may happen when several users update the database at the same time?


### Example

User 1

~~~sql
UPDATE Person SET Lastname=‘ALBAN’ WHERE Firstname=‘Alexis’;
UPDATE Person SET Lastname=‘BLANC’ WHERE Firstname=‘Roger’;
~~~

. . .

User 2

~~~sql
UPDATE Person SET Firstname=‘Alexis’ WHERE Lastname=‘ALBAN’;
UPDATE Person SET Firstname=‘Roger’ WHERE Lastname=‘BLANC’;
~~~

. . .

Looks good if everything is executed sequentially (1 after 2 or 2 after 1). But what if lines are executed in a random order?


### Transactions

- What is the problem?
  - Each set of query transforms the DB from a consistent state to another consistent step
  - This is not true anymore if the statements are mixed
- Solution: ensure that each set of query is executed entirely before doing something else
- `BEGIN ; query-list ; COMMIT;`: executes the queries and validates them
- `BEGIN ; query-list ; ROLLBACK`: executes the queries and comes back to the initial state


### Properties of transactions

- ACID
  - **A** tomicity: everything or nothing
  - **C** consistency: switching to a consistent state to another consistent state
  - **I** solation: The simultaneous execution of 2 transactions produces the same result as their sequential execution
  - **D** urability: if a transaction is confirmed, its result is recorded into the database


### Save points

- It is possible in a transaction to define a save point (or several) which the system will be able to return to later in the same transaction

~~~sql
BEGIN;
SAVEPOINT MyBeginning;
UPDATE Person SET Firstname='Alexis' WHERE Lastname='ALBAN';
ROLLBACK TO MyBeginning;
UPDATE Person SET Firstname='Marc' WHERE Lastname='ALBAN';
COMMIT;
~~~

## Data definition language

### Data definition language

- Is used to create a database
- Is used to create the database infrastructure
- Is used to modify this infrastructure
- Technically, it records information in the meta-data of the DBMS


### Data definition language


- Commands to create, modify, remove elements of the schema (tables and views at first)
- `CREATE DATABASE`: creates a database
- `CREATE TABLE`: creates a table
- `CREATE VIEW`: creates a specific view on data thanks to a SELECT
- `DROP TABLE / VIEW`: removes a table or a view
- `ALTER TABLE / VIEW`: modifies a table or a view

### Creating a database

- `CREATE DATABASE name`
  - creates a new database (a new set of tables) with a name
- All DBMS offer various options but none are normalized
  - character encoding
  - owner
- Note: a database can be created from a query
  - `CREATE DATABASE name AS SELECT ...`

### Remove a database

- `DROP DATABASE name`
- removes a database and all its content


### Creating table

- To create a table, we need to provide the table name, its attributes and its constraints

~~~sql
CREATE TABLE name(
  col-name col-type [DEFAULT VALUE]
  [CONSTRAINT] col-contrainst)*
  [CONSTRAINT] table-constraint]*
  | AS sql-query
)
~~~

### DBMS differences
- Oracle
~~~sql
CREATE TABLE name (
  ...
)
/
~~~
- PostgreSQL
~~~sql
CREATE TABLE name (
  ... )
;
~~~
- mySQL
~~~sql
CREATE TABLE name (
  ... )
ENGINE = MyISAM;
~~~

### Examples

~~~sql
CREATE TABLE PhD (
  Lastname         VARCHAR(30),
  Firstname        VARCHAR(30),
  YearFirstReg     DECIMAL(4) DEFAULT 2003
);

CREATE TABLE PhD
  AS SELECT Lastname,Firstname,YearFirstReg
  FROM Student WHERE status = 'PhD';
~~~

### Creating tables - about columns

- `col-name col-type [NOT NULL] [Other]`
- Column declarations are separated by commas `,`
- Column names may include alphabetical characters, digits and `_`. They must start by a letter
- In most DBMS, columns name are restricted to a length of 32 characters
- if `NOT NULL` is present, the column **must** have a value

### Creating tables - about columns

- Main column types

type      | ORACLE    | PostgreSQL        | mySQL
----------|-----------|-------------------|--------
integer   | NUMBER    | INTEGER           | int
real      | FLOAT     | NUMERIC           | float
character | CHARACTER | CHARACTER         | char
string    | VARCHAR2  | CHARACTER VARYING | varchar
text      |           | TEXT              | text
boolean   |           | BOOL              | bool
date      | DATE      | DATE              | date

### Creating tables - about columns

- Constraints that may be applied to **columns**
  - `NOT NULL`: the column can not contain a `NULL` value
  - `PRIMARY KEY`: the column is the primary key (identifier of the relation)
  - `UNIQUE`: the column is a candidate key but is not the identifier
  - `REFERENCES table-name [(table-col)][action]`
    - the column has a an exernal link towards another column, probably from another table
  - `CHECK (condition)`: a condition must be checked on this column for all lines of the table

### Constraints for tables

- Constraints that may be applied to the **whole table**
  - `PRIMARY KEY (col-name*)`: to declare a primary key (identifier), more specifically when it is composed of several columns
  - `UNIQUE(*)`: to declare a candidate key which is not the identifier
  - `FOREIGN KEY (col-name*) REFERENCES table-name [(col-name)*][action]` to declare a foreign key
  - `CHECK(condition)` to check that every line fulfills the indicated condition

### Example

~~~sql
CREATE TABLE Country(
  name CHARACTER VARYING(20) NOT NULL,
  capital CHARACTER VARYING(20) NOT NULL,
  surface INTEGER,
  ...
)
~~~


### Primary keys

- `PRIMARY KEY (A1,A2,..)`
  - defines the primary key
  - identical lines are possible except when there is a key
- Choose the most efficient identifier
- It will be referenced by default for external identifiers
- `NULL` value is impossible
  - Specifying `NOT NULL` is mandatory for all elements of a primary key
- `UNIQUE (A1, A2, ...)`
  - defines a candidate key (could be a secondary key)
  - integrity constrains for other identifiers
  - `NULL` values are allowed unless explicitly specified `NOT NULL`

### Examples: column and table constraint

~~~sql
CREATE TABLE Country(
  name CHARACTER VARYING(20) NOT NULL PRIMARY KEY,
  capital CHARACTER VARYING(20) NOT NULL,
  ...
)

CREATE TABLE Employee(
  lastname CHARACTER VARYING(30) NOT NULL,
  firstname CHARACTER VARYING(30) NOT NULL,
  address CHARACTER VARYING(60),
  CONSTRAINT Pk_emp PRIMARY KEY(lastname,firstname)
)
~~~

### Examples: column and table constraint

~~~sql
CREATE TABLE Student(
  INE CHARACTER VARYING(11) NOT NULL PRIMARY KEY,
  LocalId CHARACTER VARYING(6) NOT NULL UNIQUE,
  lastname CHARACTER VARYING(30) NOT NULL,
  firstname CHARACTER VARYING(30) NOT NULL,
  CONSTRAINT UNIQUE(lasname,firstname)
)
~~~

- `PRIMARY KEY` and `UNIQUE` are incompatible on the same column

### Examples

~~~sql
CREATE TABLE Student(LocalId,...)

CREATE TABLE Course(CourseName,...)

CREATE TABLE Follows(
  LocalId CHARACTER VARYING(6),
  CourseName CHARACTER VARYING(5),
  PRIMARY KEY(LocalId,CourseName),
  FOREIGN KEY (LocalId) REFERENCES Student,
  FOREIGN KEY (CourseName) REFERENCES Course
)
~~~

### External keys

- By default, they reference the primary key of the referenced table

~~~sql
CREATE TABLE Employee(
  Emp_ID CHAR(11) NOT NULL PRIMARY KEY,
  emp_Number CHAR(6) UNIQUE, ...
)
CREATE TABLE Department (
  dpt_id CHARACTER VARYING(18) NOT NULL PRIMARY KEY,
  manager_id CAHR(11) REFERENCES Employee
)
~~~

- An external key can also reference a secondary key
~~~sql
CREATE TABLE Department (
  dpt_id CHARACTER VARYING(18) NOT NULL PRIMARY KEY,
  manager_id CAHR(6) REFERENCES Employee(emp_Number)
)
~~~

### Properties

- Foreign key embed a referential integrity mechanism qui ensures that
  - a line cannot be inserted if the target of the foreign key does not exist
  - the target of the foreign key cannot be modified if it is still referenced
  - the target of the foreign key cannot be destroyed if it is still referenced

### Examples

- Let us consider the two following tables

\underline{Person\_ID}  | Lastname  | Firstname
--|---|--
1  | ALBAN  |  Roger  
2  | BLANC  |  Alexis  

\underline{Student\_ID}  | Person_ID  
--|---
1  | 1  |  

~~~sql
INSERT INTO Student(Student_ID,Person_ID) VALUES (2,3)
~~~

Error because no Person with ID 3

### Examples


\underline{Person\_ID}  | Lastname  | Firstname
--|---|--
1  | ALBAN  |  Roger  
2  | BLANC  |  Alexis  

\underline{Student\_ID}  | Person\_ID  
--|---
1  | 1  |  

~~~sql
UPDATE Person SET Person_ID = 4 WHERE Person_ID = 1
~~~

Error because Person\_ID=1 is referenced in Student

### Examples


\underline{Person\_ID}  | Lastname  | Firstname
--|---|--
1  | ALBAN  |  Roger  
2  | BLANC  |  Alexis  

\underline{Student\_ID}  | Person\_ID  
--|---
1  | 1  |  

~~~sql
DELETE FROM Person WHERE Firstname = 'Roger'
~~~

Error because Person\_ID=1 is referenced in Student


### Integrity constraints on foreign keys

- Error when problem!
- Can we do something different: `REFERENCIAL TRIGGERED ACTION`
  - not in every DBMS
- 2 circumstances
  - `ON UPDATE`
  - `ON DELETE`
- 4 possible behaviors
  - `RESTRICT`
  - `CASCADE`
  - `SET NULL`
  - `SET DEFAULT`

### Example

~~~sql
CREATE TABLE Student (
  Student_ID INTEGER NOT NULL PRIMARY KEY,
  Person_ID INTEGER REFERENCES Person(Person_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  ...
)
~~~

### Examples

- Let us consider the two following tables

\underline{Person\_ID}  | Lastname  | Firstname
--|---|--
1  | ALBAN  |  Roger  
2  | BLANC  |  Alexis  

\underline{Student\_ID}  | Person_ID  
--|---
1  | 1  |  

~~~sql
INSERT INTO Student(Student_ID,Person_ID) VALUES (2,3)
~~~

No change: error because no Person with ID 3

### Examples


\underline{Person\_ID}  | Lastname  | Firstname
--|---|--
1  | ALBAN  |  Roger  
2  | BLANC  |  Alexis  

\underline{Student\_ID}  | Person\_ID  
--|---
1  | 1  |  

~~~sql
UPDATE Person SET Person_ID = 4 WHERE Person_ID = 1
~~~

The Person_ID of Student 1 switches for 1 to 4 (`CASCADE`)

### Examples


\underline{Person\_ID}  | Lastname  | Firstname
--|---|--
1  | ALBAN  |  Roger  
2  | BLANC  |  Alexis  

\underline{Student\_ID}  | Person\_ID  
--|---
1  | 1  |  

~~~sql
DELETE FROM Person WHERE Firstname = 'Roger'
~~~

The Person_ID of Student 1 is now `NULL`(`SET NULL`)


### More constraints on lines

~~~sql
CREATE TABLE Employee (
  Emp_ID CHAR(11) PRIMARY KEY,
  Lastname CHARACTER VARYING(20) NOT NULL,
  Firstname CHARACTER VARYING(20) NOT NULL,
  age NUMBER CHECK(age BETWEEN 16 AND 70),
  sex CHAR CHECK(sex IN ('F','M')),
  salary NUMBER,
  commission NUMBER,
  CONSTRAINT check_sal CHECK(salary * commission >= 7000)
)
~~~


### Integrity constraints

- Simple: `CHECK` in `CREATE TABLE`
- Complex: use `TRIGGER`
- `CREATE TRIGGER`
  - will be seen in the PL/SQL chapter
  - when something occurs (linked to `INSERT/DELETE/UDATE`)
  - if a condition is fulfilled
  - then do something

### Remove a table

- `DROP TABLE table-name [CASCADE CONSTRAINTS]`
  - removes a table and its population
  - use with caution!
- `CASCADE` allows to apply the `REFERENCIAL TRIGGER ACTION` `CASCADE` when the lines are removed

### Update the table schema

\scriptsize

~~~sql
ALTER TABLE table-name
{ RENAME TO new-table-name |
ADD ([(col-name col-type [DEFAULT value][col-constraint])*]) |
MODIFY (nom-col [type-col] [DEFAULT valeur] [contrainte-col])* |
DROP COLUMN nom-col [CASCADE CONSTRAINTS] |
RENAME COLUMN old-name TO new-name
}
~~~

### Update the table schema

- Change a table name
  - `RENAME`
- Add a column or a constraint
  - `ADD`
- Modufy a column or a constraint
  - `MODIFY`
- Remove a column or a constraint
  - `DROP`
- Rename a column or a constraint
  - `RENAME`

### Examples

- There are differences between DBMS...
- PostgreSQL
~~~sql
ALTER TABLE ONLY table-name ADD CONSTRAINT keyname
FOREIGN KEY (keyname) REFERENCES foreigntable(foreignkey)
ON UPDATE RESTRICT
ON DELETE RESTRICT;
~~~
- MySQL (this is not a real foreign key)
~~~sql
ALTER TABLE table ADD FOREIGN KEY (keyname)
REFERENCES foreigntable(foreignkey);
~~~


### Indexes

- Somes queries can run for a long time
  - It is possible to use acceleration techniques
  - indexing some columns
    - creating a hastable on a column or a set of column
  - Pros
    - accelerates searches
  - Cons
    - uses space
    - slows down inserts, removals and updates


### How to setup indexes

- An index is automatically created on every primary key!
- explicitly (depends on the DBMS)
- PostgreSQL
~~~sql
CREATE INDEX index-name ON table
  USING btree (indexed-element);
~~~
- MySQL
~~~sql
ALTER TABLE table ADD INDEX index-name(indexed-element);
~~~


### Sequences


- Specific key types
  - integer which are automatically incremented
  - useful for primary keys
- mySQL
  - transparent (`autoincrement`)
- Other DBMS
  - use sequences

### Sequences

- Specific entity with the following properties
  - name
  - value (last one)
  - increment
  - max value
  - min value or initial value
  - state (activated or not)
- Access to a sequence is in mutual exclusion (two queries executed in parallel will get 2 distinct values)


### Sequences

- `CREATE SEQUENCE sequence-name`
- 2 actions
  - increment the counter
  - get its value
- Examples (PostgreSQL)
~~~sql
SELECT nextval(sequence-name) AS Value
~~~

### Example (autoincrement)

~~~sql
CREATE SEQUENCE s_depot;
CREATE TABLE depot(
  depot_id integer NOT NULL DEFAULT nextval('s_depot'),
  address_id integer NOT NULL,
  depot_name character varying(100),
  CONSTRAINT pk_depot PRIMARY KEY (depot_id)
);
~~~


## Data Control Language

### Data Control Language

- Used to specify who is owner of what and who can do what
  - on base or table basis
- Depending on the DBMS, granularity may not be the same

### Data Control Language

- `GRANT`: authorizes an operation
- `DENY`: denies an operation
- `REVOKE`: cancels a former order
- `LOCK`: locks an object
- `UNLOCKS`: cancels a lock on an object
- `OWNER TO`: defines the owner

### Owner

- `ALTER DATABASE dbname OWNER TO user`
  - defines *user1* as the owner of database *dbname*
- `ALTER TABLE tblname OWNER TO user1`
  - same thing at the table level
- The owner of an object has all rights on this object

### Grant privileges

- `GRANT operation ON object TO user [WITH GRANT OPTION]`
  - *operation*: in `ALL`, `SELECT`, `UPDATE`, `DELETE`, ...
  - *object*: `TABLE mytable`,`ALL TABLES`...
  - *user*: the user to which this privilege is granted
- Symetrically
  - `DENY operation ON object TO user`
  - `REVOKE operation ON object FROM user [CASCADE]`

### Examples

~~~sql
ALTER DATABASE Employee OWNER TO hrdept;
GRANT SELECT ON ALL TABLES TO someone;
GRANT ALL PRIVILEGES ON TABLE Person TO someone;
~~~

### Creating / removing roles

~~~sql
CREATE ROLE name [SUPERUSER | NOSUPERUSER |
  CREATEDB | NOCREATEDB | CREATEUSER |
  NOCREATEUSER | LOGIN | NOLOGIN |
  PASSWORD 'mybeautifulpassword' |
  VALID UNTIL '2019-07-22 12:21' | ... ]

  DROP role name

  CREATE USER
  DROP USER
  ~~~

### Schemas

  - SQL queries can only address a single database
  - Problem: how can we consolidate data that are spread into several databases?
  - 2 solutions
    1. Use an ETL (Extract, Transform Load) software
    2. Use schemas rather than databases
      - Inside a database, we can `CREATE, DROP, ALTER SCHEMA xx`
      - Access to data: `schema.table`


### Schemas

- By default, there exists one schema in a database, named `public`
- Every schema behaves like an indenpendant database
- It is possible to handle privileges at the schema level
- Is it possible to query tables on
  - the tables belonging to the same schema
  - tables belonging to different schemas

### Views

- A view: information aggregation
- A view behaves like a table without identifiers on which `SELECT` are possible
- A view is obtained from a query on the tables of the database
- It is not necessary to have `SELECT` privileges on the tables involved in the query, only the view privilege is required
- A view records the query definition, not its result
  - i.e. it is *recomputed* every time it is used

### Views

- What for?
  - Record common queries
  - allows a user to access some information without having access to the whole table
    - can be intermediary information
  - allows a transparent access to some information
    - limit the (apparent) complexity of a query

### Why use them?

- Not required to grant privileges on tables
- Preformatted queries
- Easier to learn than the complete schema
- The user only knows the result schema, not the complete schema of the database
- The view definition can be changed without modifying the programs that are using it
  - eases attributes modifications
- allows to build even more complex queries...


### Practically

- `CREATE VIEW viewname AS selectquery`
- `DROP VIEW viewname`
- Example

\scriptsize

~~~sql
CREATE VIEW aStudent AS
  SELECT Person.Person_ID, Person.Person_Lastname, Person.Person_Firstname,
    Student.Number, Degree.Name, Registration.Year
  FROM Person
    NATURAL JOIN Student
    NATURAL JOIN Registration
    NATURAL JOIN DegreeRegistration
    NATURAL JOIN Degree
~~~

### Conclusion

- SQL: a rich set of functionalities
  - Data Definition Language
  - Data Manipulation Language
  - Data Control Language
- But
  - not all function-nalities are implemented
  - Caution of data types
- Then
  - Very important to know which database type is going to be used before writing actual statements
# Software
