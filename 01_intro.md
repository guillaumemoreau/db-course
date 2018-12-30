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

> A rental store has several device types for rent. Devices as well
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
