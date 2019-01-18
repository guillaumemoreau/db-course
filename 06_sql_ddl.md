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
