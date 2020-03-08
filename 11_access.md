# Accessing databases

### Access mechanisms

- Administration tools
- Management tools: ETL, EAI, ESB...
- Business Intelligence tools
- APIs

## Administration tools


### Administration tools

- provided by every DBMS
  - at least it can be downloaded separately
- some may be developed as third-party tools


### Oracle

- DbAdmin (DBA)
- Oracle SQL Developer
- source: [http://www.oracle.com]

\center\includegraphics[height=2.9cm]{fig/dba.pdf}

### PostgreSQL

- PgAdmin
- source: [http://www.pgadmin.org]
- Caution: since PgAdmin 4, it runs a local server


\center\includegraphics[height=2.9cm]{fig/pgadmin.pdf}

### MySQL

- MySQLWorkbench
- source: [http://www.mysql.fr]

\center\includegraphics[height=2.9cm]{fig/mysqlworkbench.pdf}

### Some others

- SQL Server
  - SQL Server Management Studio Express
  - source: [https://www.microsoft.com/fr-fr/download/details.aspx?id=8961]
- DB2
  - Centre de contrôle
  - [http://public.dhe.ibm.com]


### Third party tools

- EMS
  - SQL Server, MySQL, PostgreSQL, Oracle, InterBase, Firebird
- Navicat
  - SQL Server, MySQL, PostgreSQL, Oracle, SQLite, MariaDB
- Toad
  - SQL Server, DB2, MySQL, PostgreSQL, Oracle
- ...

## Management tools

### ETL

- ETL = Extract, Transform, Load
- Goal: synchronize databases
  - Get some data from one or several data source (including databases, Excel, CSV...)
  - Consolidate and work on data
    - scripts, modules, programs
  - Write the data elsewhere
    - Excel, CSV, databases
- Used to build data warehouses and migrate data between databases that are not planned to work together
  - example: data transfer from *concours Centrale Supélec* to OnBoard

### Talend

- http://fr.talend.com

\center\includegraphics[height=4.9cm]{fig/talend.pdf}


### Example

- Talend
- CloverETL
- Pentaho
- InfoSphere
- SQL Server Integration Services
- Oracle Data Integration


### EAI, ESB

- EAI = Enterprise Application Integration
- ESB = Enterprise Service Bus
- Goal
  - Automate exchanges
  - Share information
  - Share processings
- Architecture
  - EAI: central kernel which acts as a mediator between applications
  - ESB: mainly use (web) services
    - XML and SOAP protocols


### Examples

- Talend
- MQSeries, WebSphere (IBM)
- BizTalk Server, MSMQ (Microsoft)
- WebMethods (Software AG)
- ActiveEnterprise (TIBCO)
- ...

### Reporting and BI tools

- Goal: automatically produce reports without having to write a layout program
- Concept of data cubes (OLAP)
- define some template reports, models
- Automatically (and periodically) run the production of reports

### Example

\center\includegraphics[height=4.9cm]{fig/jasper.pdf}


### Examples

- JasperSoft
- Business Objects
- Pentaho
- OpenReports
- CristalReports
- Cognos
- BIRT (Business Intelligence and Reporting Tools)
- ...

### Business Intelligence

- BI = Business Intelligence
- Set of technologies allowing companies (organizations) to analyze their data to make relevant decisions
- Can denote: applications, infrastructure, tools...
- Goal: analyze information improve, optimize decision making and performance
- Mainly relies on data analysis tools


### BI tools

- Data analysis tools
- Reporting and visualization tools
- Analytical processing tools
- Real-time data processing tools
- Data exploitation tools
- ...

### Decision chain

- Data collection
  - From several sources: ETL...
- Data storage
  - Data warehouse
- Getting intel
  - reporting tools
- Using intel
  - OLAP cubes, data mining


## API

### Problem statement

- Tools are not always enough
- Somebody needs to write the tools...
- Therefore we need a way to access databases from a program
  - API = Application programming interface

### API needed to

- connect to the DBMS
- Access the DB (access control)
- Select information (access control)
- Update information (access control)
- Of course, we want to use SQL for that

### 2 different ways

- Direct use of the API
  - Set of functions and methods for exchange with the DBMS
  - May need a *driver*, i.e. an interface between the program and the DBMS
- ORM = Object Relational Mapping
  - Use of a framework that hides direct access to the DBMS
  - Abstract layer that does not depend on the DBMS


### A few hints

- You do not need to connect/disconnect to/from the DBMS for every query
- You cannot do two different queries on two different databases at the same time
- But you can connect to several databases at the same time

## Database access in PhP

### Connection with PhP

- PhP is a language designed for web applications
- Before PhP7, there was a connection API (now obsolete)
  - Specific database manipulation functions
  - Using an ODBC driver
  - Avoid!!
- now: PDO class
  - or a framework that embeds database connection through PDO

### PhP - PDO

- Communication is performed through a `PDO` class object
  - The database type is given in the *connection protocol*
  - Creating a `PDO` object initiates a connection to the database

```php
$conn = new PDO('protocol','login','password');
```
- Methods of the `PDO` class are used for querying the DB and fetching the results
- Object destruction closes the connection to the database
- To change database type, you just have to change the communication protocol


### PDO - protocol

- The protocol string is written: `protocol:host=myHost;dbname=myDatabase`
  - `protocol` is the database type: `mysql, pgsql, oci`...
  - `myHost` is the server name
  - `myDatabase` is the database name
  - Example

```php
$conn = new PDO("pgsql:host=localhost;dbname=test",$user,$pass);
```

### PDO - important methods

- `prepare` defines a SQL query
  - parameters can be defined in two ways:
    - `?` value of the parameter indicated in the `execute` method
    - `:paramName` value of the parameter indicated with `bindParam`
- `bindParam` defines the values of the parameters of a query
- `execute` executes a query defined by `prepare`. It sets the parameters values
- `fetchAll` gets all lines of the result table
- `closeCursor` closes the SQL query and gets the memory back


### PDO - example

\scriptsize

```php
$conn = new PDO(’pgsql :host=localhost ;dbname=test’, ’login’, ’password’) ;
$query = $conn->prepare(”SELECT * FROM Person WHERE Person_ID= ?”) ;
$query->setFetchMode ( PDO ::FETCH_ASSOC ) ;
$query->execute(array(25)) ;
$rows = $query->fetchAll() ;
foreach ( $rows as $aRow ) {
echo $aRow[”name”].” ”.$aRow[”firstname”].”<br/ >\n” ; $query->closeCursor() ;
```

### PhP - ORM

- Object Relational Mapping
  - They introduce an abstraction layer between the database and the programming language
  - No need to care about the DBMS type while programming
  - They provide a mapping between database tables and classes in the language
- Examples
  - Propel
  - Doctrine
  - Zend


### PhP - Frameworks

- They are usually built on an ORM (or several) and provide tools on top of the ORM to ease programming
- Examples
  - Symfony (based on Propel or doctrine)
  - Codeigniter (has its own ORM)
  - cakePhp (has its own ORM)

## Database access in java

### JDBC

- JDBC = Java DataBase Connectivity
- **The** way of accessing databases in java
  - Based on the principles of ODBC
  - Driver is independent of the Operating System (java based)
  - Needs the installation of the relevant JDBC driver before use


### JDBC

- API for connecting to databases
- 1 driver for every database type
- 4 drivers types
  - type 1: gateways between ODBC and JDBC
  - type 2: native API (direct connection to the database)
  - type 3: converts JDBC calls into a protocol which is independent of the DBMS
  - type 4: converts JDBC calls into a network protocol used by the DBMS
- Type 4 drivers are recommended

### How-to?

- The `java.sql` interface handles the JDBC driver and cares about the abstraction of the access to the database
- Method
  - Import the `java.sql.*` package
  - Load the JDBC driver (only once in an application)
  - Establish the connection to the database
  - Execute the required SQL queries
  - Free the connection
  - Free the driver (only once in the application lifetime)


### Load  the JDBC driver

\scriptsize

```java
try {
    Class.forName("myDriver.ClassName");
}
catch (java.lang.ClassNotFoundException e) {
    Logger.getLogger(MyClass.class.getName()).log(Level.SEVERE,null,e);
}
```

- Remark: the JAR file for the relevant JDBC driver must be present in the class path

### Free the driver

```java
Driver theDriver = DriverManager.getDriver(dbURL);
DriverManager.deregister(theDriver);
```

### Driver types

- In previous slides, the driver is designated by `myDriver.ClassName`
- No consistent way of determining it, you must look at the documentation
- Examples
  - MySQL: `com.mysql.jdbc.Driver`
  - PostgreSQL: `org.postgresql.Driver`
  - Oracle: `oracle.jdbc.driver.OracleDriver`
  - ...

### Establish a connection

- Caution: The JDBC driver must be properly located to allow the connection to be established
- A `Connection` object is used for exchanges with the DBMS
- To connect:

\scriptsize

```java
String dbUrl = "jdbc:protocol:urlbase";
Connection connect = DriverManager.getConnection(dbURL,"myLogin","myPassword");
```

### Establish a connection

- `jdbc:protocol:urlbase` has the following form:
  - `jdbc:mysql://<host>/<db_name>`
  - `jdbc:postgresql://<host>/<db_name>`
  - `jdbc:oracle:oci8:@<db_name>`
- where `<host>` stands for the databse server name
- and `<db_name>` for the name of the database to be accessed


### Disconnection

```java
connect.close();
```

### SQL queries

- There exist several classes for SQL queries
- The most common ones are
  - `Statement`
  - `PreparedStatement`
- It is **highly recommended** to avoid the first class which is sensitive to SQL injections (and therefore likely to be insecure)
- When they are created those objects allow to set specific properties on the query result (go backwards, modify the result...)


### Execute an SQL query

\scriptsize

```java
String query = "...";
PreparedStatement stmt = connect.prepareStatement(query);
```

- The query may contain parameters which will be defined by `?`
- Parameters values will then be defined by `set` methods

### Execute an SQL query

- If the query has to return a result, the `executeQuery` method will be used on the `PreparedStatement` object
  - The result is available through a `ResultSet` object
  - Its methods are used to fetch all information
- If the query does not return a result (update, delete...), the `executeUpdate` is used

### Execute an SQL query - parameters

- The query may contain parameters
- Each parameter is defined in the query string by `?`
- To provide the parameter a value, a `set` method is used
  - It depends on the parameter type: `setString`, `setInteger`, `setDate`...
  - The first parameter is the index inside the query (1, 2...)
  - the second parameter is the parameter value

\scriptsize
```java
String query = "SELECT Person_id FROM Person WHERE Person_name = ?";
PreparedStatement stmt = connect.prepareStatement(query);
stmt.setString(1,"David");
```

### Execute an SQL query - results

- If the query does not return any result, `executeUpdate()` is used

```java
PreparedStatement stmt = connect.prepareStatement(
  ”DELETE FROM Person WHERE Person_id=1” ) ;
stmt.executeUpdate() ;
```

- If the query returns a result, `executeQuery()` is used

```java
PreparedStatement stmt = connect.prepareStatement(
  ”Select Person_Name FROM Person WHERE Person_id=1” ) ;
ResultSet rs = stmt.executeQuery() ;
```

### Execute an SQL query - browse results

- `ResultSet` allows to browse through the result lines
  - `next()` goes to the next line and returns `null` if it does not exist
  - `previous()` goes to the previous line. It must have been enabled at the `PreparedStatement` definition
  - `get...` gets a column from a given line. The parameter can be
    - the column number (from the `SELECT` column order)
    - the column name

### Example

\scriptsize

```java
import java.sql.* ;
public class testSQL {
public static void main(String[] argv) {
  try {
    Class.forName(”org.postgresql.Driver”) ;
    Connection connect = DriverManager.getConnection(”jdbc :postgresql :/localhost/test”, ”prweb”, ”prweb”) ; String query = ”SELECT * FROM Person WHERE Person_name= ?” ;
    PreparedStatement stmt = connect.prepareStatement(query ) ;
    stmt.setString(1, "David") ;
    ResultSet res = stmt.executeQuery() ;
    while (res.next()) {
      System.out.println(”Info : ”+rs.getString("Person_name")) ;
    }
    stmt.close() ;
    connect.close() ;
  } catch(java.lang.ClassNotFoundException e) {
    System.err.println(”ClassNotFoundException : ” + e.getMessage()) ;
  }
  catch(SQLException ex) {
    System.err.println(”SQLException : ” + ex.getMessage()) ;
  }
}
}
```

### DataSource

- Some objects, like `DataSource` are used to handle connection pools
  - As for standard connections, the driver and elements such as logins and passwords must be indicated
  - The connection is asked to and freed from the connection pool
  - When a connection is freed, it does not mean that the connection pool will actually close it
    - It is usually put aside and closed after a significant interval if not used
  - When a connection request is issued, the pool checks whether a waiting connection is available
  - Better for performance when handling multiple connections


### ORMs

- As for most programming languages, there exists  functions libraries for handling databases connection and a mapping between objects and tables
  - Hibernate
  - JPA
- Those tools mostly rely on XML configuration files and Java classes matching the databases objects which will be manipulated

### Frameworks

- For even more power (and abstraction), you can use frameworks
  - They will (partially) hide the use of a database
  - and much more...
- Examples
  - Spring
  - Springboot
  - JSF
  - Struts, Tapestry
  - Play!

## Python

### To connect with Python

- Specific APIs
- Function libraries for many databases types
- Requires  installing and importing modules dedicated to the relevant database type

### To connect with Python - steps

- Like in most programming languages, there are several steps
  1. Importing the relevant module
  2. Open a connection to the database
  3. Create a cursor for an SQL query
  4. Execute an SQL query thanks to the cursor
  5. Fetch the results
  6. Close the cursor
  7. Close the connection


### Connection APIs

- The connection API depends on the used database. You need:
  - To install the module (`pip install`)
    - `python -m pip install`
    - MySQL: `mysql-connector`
    - PostgreSQL: `postgresql`
    - Oracle: more complicated, see manual procedure on the Oracle website
  - to import the module at script beginning
    - `import ...`
    - MySQL: `mysql.connector`
    - PostgreSQL: `psycopg2`
    - Oracle: `cx_oracle`

### Connecting


- Connection is handled through the `connect` function
- 4 elements to be used in the parameter
  - `host`: the server
  - `dbname`: the database name
  - `user`: the connection login
  - `password`: the password
- Every open connection must be closed by `close`


### Cursors

- Queries are  handled thanks to cursors
- A cursor is defined from a connection to a database
- It relies on an SQL query
- It is used to execute a query as well as to manipulate its result
- It can fetch the whole result or browse it line by line
  - `fetchone`: gets the next line
  - `fetchall`: gets all lines
- Every open cursor must be closed before being used again

### Example 1


\scriptsize

```python
import psycopg2
conn = psycopg2.connect(”host=localhost dbname=test user=test password=test)
cursor = conn.cursor()
cursor.execute(”select * from Person”)
rows = cursor.fetchall()
for row in rows :
  print(row) cursor.close()
conn.close()
```

### Example 2

The cursor may also be used in loops


\scriptsize

```python
import psycopg2
conn = psycopg2.connect(”host=localhost dbname=test user=test password=test”)
cursor = conn.cursor()
cursor.execute(”select * from Person”)
for row in cursor :
  print(row)
cursor.close()
conn.close()
```

### Avoiding SQL injections

To avoid SQL injections, dictionaries can be used

\scriptsize

```python
cursor = comm.cursor()
data = {”name” : ”DUBOIS”, ”firstname” : ”Jacques”}
cursor.execute(”INSERT INTO person(name,firstname) VALUES (:name, :firstname)”, data)
comm.commit()
```

## Conclusion

### Conclusion

- In most programming languages, there exists one or several ways to connect to database
  - not mentioned here but still true: C++, Ruby, Cobol...
- A few suggestions
  - If there exist frameworks, use them!
  - If there exist ORMs, use them too
  - Prefer drivers to specific APIs whenever possible
  - Do not forget to close your connections and free the drivers
