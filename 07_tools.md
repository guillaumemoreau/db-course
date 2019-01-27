
# Modeling software

### Data models

- There exists plenty of software for modeling!
- Conceptual data model
  - SYBASE: SQL Power Designer
  - JMerise
- Physical data model
  - SYBASE: SQL Power Designer
  - JMerise
  - SQL Power Architect

## SQL Power Architect

### SQL Power Architect

- Physical Data model
- Reverse Engineering
- SQL generation
- Can dialog with main database types
- http://software.sqlpower.ca/page/architect
  - Use Community Edition

### The interface

\center\includegraphics[height=.8\textheight]{fig/pa_001.jpg}

### Creating a table

- Right-click in the schema zone
- Fill the fields
  - Logical name = name in SQL Power Designer
  - Physical name = name in the database
  - Primary key name = name of the constraint handling the primary key

\center\includegraphics[height=.4\textheight]{fig/pa_002.jpg}

### Creating columns

- Left-click on the table
- Press C (or go to the menu)
  - Logical name = name in SQL Power Designer
  - Physical name = name in the database
  - In primary key = belongs to the primary key
  - Type = data type
  - Precision = date size (type-related)

### Example

\center\includegraphics[height=.8\textheight]{fig/pa_003.jpg}

### Example


\center\includegraphics[height=.2\textheight]{fig/pa_004.jpg}

### Creating an external link

- Choose the right tool in the right bar
  - dashed line: link between the ID and another column of a table
  - plain line: link between the ID and the ID of another table
- Click the source table (i.e. containing the ID to be copied)
- Click on the external table to create the external link
- Note: The link is created in the target table and references the source table

### Example

\center\includegraphics[height=.45\textheight]{fig/pa_005.jpg}

### Notation

- dashed line: link towards a column which is not a key
- plain line: link towards a column which is a key
- Extremities
  - exactly 1 (cross)
  - 0 or 1 (cross + circle)
  - 1 or more (cross + arrow)
  - 0 or more (cross + arrow + circle)

\center\includegraphics[height=.3\textheight]{fig/pa_006.jpg}


### Link properties

- Name of the link
- Towards a key or not
- Cardinalities with regard to both involved tables
- Deferrability: when is the integrity constraint applied?
- Constraints related to update and delete

### Example

\center\includegraphics[height=.8\textheight]{fig/pa_007.jpg}

### SQL generation

- Click on the SQL button

\center\includegraphics[height=.15\textheight]{fig/pa_008.jpg}

- Choose whether there is a DBMS connection (and which one if appropriate)

\center\includegraphics[height=.35\textheight]{fig/pa_009.jpg}

### SQL generation

- If there are errors or warnings, they will be indicated
- Note: is there are only errors on sequences, you can either click 'Ignore warnings' or 'Quick fix all'


### Example

\scriptsize

~~~sql
CREATE SEQUENCE myschema.person_person_id_seq;
CREATE TABLE myschema.Person (
                Person_id INTEGER NOT NULL DEFAULT
                  nextval('myschema.person_person_id_seq'),
                Person_firstname VARCHAR(30) NOT NULL,
                Person_firstame VARCHAR(30),
                Person_birthdate DATE NOT NULL,
                CONSTRAINT person_pk PRIMARY KEY (Person_id)
);
ALTER SEQUENCE myschema.person_person_id_seq OWNED BY myschema.Person.Person_id;
CREATE SEQUENCE myschema.student_student_id_seq;
CREATE TABLE myschema.Student (
                Student_ID INTEGER NOT NULL DEFAULT
                  nextval('myschema.student_student_id_seq'),
                Student_ECN_Number VARCHAR(7) NOT NULL,
                Student_INE VARCHAR(16) NOT NULL,
                Person_id INTEGER NOT NULL,
                CONSTRAINT student_pk PRIMARY KEY (Student_ID)
);
ALTER SEQUENCE myschema.student_student_id_seq OWNED BY myschema.Student.Student_ID;
ALTER TABLE myschema.Student ADD CONSTRAINT person_student_fk
FOREIGN KEY (Person_id)
REFERENCES myschema.Person (Person_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
~~~

### Connection to a DBMS

- It is possible to connect to a real DBMS
  - to send SQL code
  - for reverse engineering
    - once the connection is established drag a schema into the drawing zone

  \center\includegraphics[height=.45\textheight]{fig/pa_010.jpg}


### Connextion to a DBMS

- Name: connection name in Power Designer
- Database type: select the right database type
- hostname: server name or address
- port: communication port (TCP/IP)
- username & password: to connect to the database
- URL: is automatically constructed from the parameters
- The 'Test connection' button is used to validate the parameters
