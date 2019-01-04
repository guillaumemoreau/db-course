# Introduction

## History

- 1950-1960: files started to be stored on computers
  - required access methods and file organization
  - started with sequential access (tapes)
- Then, random access was made possible
  - Direct access
  - required file structuring

## History

- Companies needs
  - financial data, business data, technical data, production data...
  - driven by technological progress
- 1962: the Database concept


## History of databases

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

## To date

- Relational databases take the biggest share of the database related activity
- noSQL has appeared
- Big Data impact

# Problem statement

## Example

> A rental store has several device types for rent. Devices as well as
> their type are designated by a number and have a label. Every device type
> has a rental rate. Devices may be rented by customers, identified by a number
> and whose name and address are known. A customer may rent several devices.
> The same device may be rented several times by the same customer, therefore
> the rent start date and duration are stored. Customers who have forgotten
> to give back their devices will be contacted and billed.

## Step 1: modeling

- Conceptual data model

\center{\includegraphics[height=.65\textheight]{fig/cmodel-1.pdf}}

## Step 2: transformation into a logical model

- Logical model

\center{\includegraphics[height=.65\textheight]{fig/cmodel-2.pdf}}

## Step 3: Adding type information

- Physical model of data

\center{\includegraphics[height=.65\textheight]{fig/cmodel-3.pdf}}

## Step 4: Translation

\center{\includegraphics[height=.65\textheight]{fig/cmodel-4.pdf}}

## Step 5: Implementation

- The database can now be populated and used

\center{\includegraphics[height=.55\textheight]{fig/cmodel-5.pdf}}

## Operating

\center{\includegraphics[height=.65\textheight]{fig/cmodel-6.pdf}}

## Definitions

- **Modeling** is the activity which consists in elaborating a structured representation of reality
- A **database** is a **representation** of a part of the real world which is of interest for users and applications
- **Modeling a database** is the elaboration of data structures for the data that will be recorded into a database
- The definition of those structures is stored in the **schema** of a database


## Information system

\center{\includegraphics[height=.65\textheight]{fig/is.pdf}}


# Databases

## Definitions

> 'Structured set of data recorded on devices a computer can access to simultaneously satisfy several users in a selective way and at the right time[^da]'


> 'Set of data memorized by a computer, used by several persons and having an organization described by a data model[^mo]'

> 'Set of data handled a dabatase management system used to model a single company[^ga]'

[^da]: Delobel, Adiba
[^mo]: Morejon
[^ga]: Gardarin

## Criteria

1. Good representation of the real world
2. No redundancy of information
3. Independence between data and processings
4. Security and confidentiality of data
5. Performance of applications and queries


## Deploying a database

1. Determine and identify the problem
2. Propose possible solutions
3. Model the system
4. Design the solution
5. Test the solution
6. Maintain and improve the system

## Determine and identify the problem

- What problem are you modeling?
- What are the boundaries of the problem?
  - i.e. what are you **not** modeling?
- Who are the stakeholders?
- What are the reference documents?
- What data? Which processings?
- What are the constraints?

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-1.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-2.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-3.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-4.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-5.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-6.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-7.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-8.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-9.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-10.pdf}}

## Gathering information

\center{\includegraphics[width=.8\textwidth]{fig/info-11.pdf}}

## How to collect information?

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

## Propose possible solutions

- Ask questions to the future users
- Gather documents
- Sort information
- Dictionary of the terminology
- *Validate* upon users and managers

## Model the system

- Structure information
- Model information (conceptual model)
- *Validate* upon users and managers

## Conceptual model

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


## Designing a solution

- Translate the conceptual model into a logical model
- Add types to complete the physical model
- Choose a DBMS type
- Translate into SQL
- Implement the SQL file(s) into the DBMS
- If required, add internal functions
- Add security elements

## Test the solution

- Setup a test database
- Add information
- Check primary key presence (same for secondary keys) and that they are normally working
- Test for data required for processings
- Test for response times
- Test for security


## Maintain and improve the system

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

# Database Management Systems (DBMS)

## DBMS

- Software used to organize and handle data
- Main functions
  - Describe the database(s) structure
  - Manipulate data
  - Use data
  - Ensure data integrity and confidentiality
  - Optimize data access

## DBMS

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

## DBMS users

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

## A few DBMS examples

- Oracle
- SQL Server
- Sybase
- DB2
- PostgreSQL
- mySQL
- H2
- ...


## Using a DBMS

- Setting up the DBMS
  - installation
  - configure
  - secure
- Setting up an administration software
- Dialog between the software through Internet
  - data manipulation language

## Summary

- Analysis: a DB is a representation of a part of reality which is of interest

\center{\includegraphics[width=.6\textwidth]{fig/analysis.pdf}}

## Abstraction

- From perceived reality to representation

\center{\includegraphics[width=.6\textwidth]{fig/summary-1.pdf}}

## Definition of the conceptual schema

- A schema is a collection of stereotypes
- The database will contain the values representing the instances of those stereotypes

\center{\includegraphics[width=.6\textwidth]{fig/ea-model.pdf}}

## Definition of the physical schema

- Translation to a logical model
- Then to a physical model

\center{\includegraphics[width=.8\textwidth]{fig/ea-model2.pdf}}

## Implementation of the physical schema

- Choose a DBMS (compatible with the physical schema)
- Implement the physical model into the DBMS

\center{\includegraphics[width=.8\textwidth]{fig/ea-model3.pdf}}
