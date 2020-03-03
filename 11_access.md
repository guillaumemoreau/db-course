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
- Set of technologies allowing companies (organisations) to analyze their data to make relevant decisions 
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
    - `:paramName` value of the paramter indicated with `bindParam`
- `bindParam` defines the values of the paramters of a query 
- `execute` executes a query defined by `prepare`. It sets the paramters values 
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
  - Driver is indenpendent of the Operating System (java based)
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

