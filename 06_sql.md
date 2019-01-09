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
