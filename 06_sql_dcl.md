

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
