

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
