# ONLY FOR TEST: REMOVE

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
