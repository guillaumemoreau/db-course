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
  - *newname* `AS` *oldname*
- Example

~~~sql
SELECT Person_ID,Name as Person.Person_Name
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
