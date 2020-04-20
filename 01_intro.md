

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

\tiny

- What does that mean?
\tiny
  - LFRS: Nantes Atlantique Airport
  - Day 21st, 07:30UTC
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

\center\includegraphics[height=4.5cm]{fig/seatmap1.png}

### Example 2: booking a seat in an aircraft (2/4)

17h32: Passenger B is looking at the seat map

\center\includegraphics[height=4.5cm]{fig/seatmap1.png}

### Example 2: booking a seat in an aircraft (3/4)

17h32: Passenger B chooses seat 36J

\center\includegraphics[height=4.5cm]{fig/seatmap2.png}

### Example 2: booking a seat in an aircraft (2/4)

17h40: Passenger A eventually chooses seat 36J

\center\includegraphics[height=4.5cm]{fig/seatmap2.png}

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
- **Set of** mathematical notion
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

### So, what is the main difference between databases and information systems?

- Limitations of databases
  - Each application provides its own database
  - No consistency between those
- The best tool of the world is useless if it is not used as planned
  - Organization
  - Change management
- **Computer programs are not made for computer scientists**

### A few quotes (1/2)

> Quickly said, an organization (company, public administration, local authority...) is structured around goals (sales, production, public service) to which it dedicates resources, ..., and to satisfy this goal, manipulates information through various supports: an information system

B. Le Roux

### A few quotes (2/2)

> Organization and informations are inseparable concepts and it would be deeply erroneous to trade them separately.

J. Mélèse

### A few quotes (3/3)

> A described organization may not work ideally, a non-described organization may work ideally but an organization that can not be described can not work ideally.

> An IT strategy aims at describing the organization, the processes and the procedures more than application architectures

Y. Condemine

### A few definitions

\center\includegraphics[height=2.5cm]{fig/strategy.pdf}

- **Management**: art or way of driving an organization, to plan its development, to control it (R.A. Thiétart)
- **Strategy**: choice of the activity domains in which the organization aims to be present and resource allocation such as to maintain and develop its position

### Underlying assumptions

- Systemic view of the organization
  - i.e. an open system with aims, rules and composed of interacting sub-systems
- Information Systems allow
  - new organization types
  - new work types
  - new added values


### Definitions (continued)

- Organization unit: information processing unit
  - input information
  - information processing
  - output new information
- Organization: system composed of several units
- Information system: set of techniques and processes that allow information to circulate in the organization

### Definitions (continued)

- Information system: a structured set of tools, methods and services aiming at answering questions related to an organization or to a specific domain
  - example: does student XX fulfill the conditions to get the Centrale Nantes degree?
- Consequence: first step for setting up an information system
  - collect data
  - ensure data quality

### Definitions (continued)

- A set of
  - organization
  - actors
  - procedures
  - IT tools
- To
  - process
  - exploit
- Information
- within Goals defined
  - by the organization strategy
  - linked to the business of the organization
  - enforcing the law

### Features

- The information systems has:
  1. Human resources
  2. Technical resources
  3. Data and interpretation models
  4. Procedures and rules
- It should bring to its actors the information and knowledge they need to make decisions

### Limitations

- It is a **model** of reality
  - A model has a validity domain
  - data quality
- It is an artefact somehow linked to reality
  - both are evolving in parallel

### Why have Information systems changed the business world?

- New ways of running your Business
  - from "La Redoute" to Amazon
  - yield management
- What is the difference between a 19th century back and a 21st century bank?
  - from the safe to electronic money exchange and fast-pace trading
- New economic models
  - Uber, Blablacar
  - price comparators

### IT project: the myths (1/3)

- The **final user point** of view
  - General statements about the goals are enough, details will be seen later
  - The projects need change over time but those changes are easy to handle because it is easy for me to figure them out (implicit)
- Truth
  - Bad requirements: major cause of delays and quality issues
  - As in product design, the later the correction, the more expensive it is

### IT project: the myths (2/3)

- The **developer** point of view
  - Once the program is written and running, the work of the developer is over
  - As long as a program is not finished writing, it cannot be tested or assessed for quality
  - For the success of a project, the most important deliverable is the running program
- Truth
  - More than 50% of a program cost takes place after delivery
  - This is more than test cases (whenever they exist)
  - A software configuration includes documentation, test data, results of tests on those test data, how to generate a clean instance...

### IT project: the myths (3/3)

- The **project manager** point of view
  - Our company has strict norms and processes, it will ensure quality
  - We have enough and appropriate computers and software
  - If the project is late, we will hire more developers
- Truth
  - Are standards comprehensive and really enforced?
  - Tools are not enough for quality, they need good practices around
  - Software development is not an industrial activity

### IT project

- A good IT project should (harmoniously) handle:
  - strategic aspects
    - how does it contribute to the goals and challenges of the organization
  - user aspects
    - appropriation
  - product aspects
    - a product that is running and matching needs
  - team aspects
    - motivated, sustainable and efficient team
- 3 **U**
  - **U**sable
  - **U**seful
  - Actually **U**sed...

### Change management

  - Installing a new software does not solve every problem
    - Changing the way people have been working for years
    - Changing the corporate culture
    - Loss of influence
    - ...
  - It is possible that the best product may be rejected by final users
  - No silver bullet method
    - hence the importance of any IT project
    - not the goal of this course but remember of this problem

## Information systems security

### Security = Cold chain

\center\includegraphics[height=5cm]{fig/marteau.png}

### Risk types

- Theft, modification, destruction of data/Software
- Service denial
- Source: internal or external
- Motivation: fun to malice


### Attack types

- Sniffing (listening to the network)
- Phishing (imitating someone else)
- Service or protocol attack
- Viruses, worms, Trojan horses
  - Viruses: executables contained in a document, mail
  - Trojan horse: sending information from inside
  - Worm: moves itself from machine to machine

### Definitions (1/4)

Data **Confidentiality**: Information should not be available nor accessible to any non authorized user, entity or process

### Definitions (2/4)

Data **Integrity**: Information should not be modified or destroyed without proper authorization

### Definitions (3/4)

Service **availability**: the access by a user, an entity or a process to an authorized service should always be possible

### Definitions (4/4)

**Access Control**: User authentication, data origin control, network filtering, the importance of logs

### Conclusion

Information systems require:

- A global vision of the system
- Responsible professionals
- Appropriate tools

\center\includegraphics[height=2.5cm]{fig/global.png} \includegraphics[height=2.5cm]{fig/notmyjob.png} \includegraphics[height=2.5cm]{fig/soviet.png}

### Conclusion: Information systems are much more than computer science!

- Have a look at this screenshot
  - SERSE is an app for submitting foreign experience reports...
- What does PEBKAC mean?

\center\includegraphics[height=5cm]{fig/serse.jpg}

