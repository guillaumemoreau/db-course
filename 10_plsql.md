

# PL/SQL

- SQL is a non-procedural language
- Complex processes are (sometimes) very complex to write
  - No variables
  - No loops, no tests
  - No information passing between queries
- It would be good to have a procedural language to link several queries toghether
  - even better have variables, loops and tests

### Why a new language?

- PL/SQL is an extension of SQL
  - It allows the co-existence of SQL queries and usual programming statements (blocks, alternatives, loops)
- A program is composed of procedures and functions
- Variables will allow exchanges between SQL queries and the remainder of the program

### What for?

- Writing *stored procedures* and *triggers*
  - Some DBMS such as Oracle also accept the java language
- Writing user functions that will be further used in SQL queries (beyond predefined ones)
- For some specific tools (Oracle, Forms and report)
- Implement specific DBMS types (example: GIS database)

### PL/SQL vs plpgsql

- PL/SQL is an Oracle proprietary tool
- PostgreSQL provides a similar tool: plpgsql
- All those languages for all DBMSs are quite similar


### PL/SQL programs

- A program is composed a statement blocks of 3 different types:
  - anonymous procedures
  - named procedures
  - named functions
- A block may contain other blocks

### Bloc structure

```
DECLARE
-- variables definition
BEGIN
  -- statements
  EXCEPTION
    -- error handling
END;
```

### Statements

- Statements are closed by a trailing `;`
- Assignments
  - statement: `variable := value;`
  - result of a query
- Control statements
  - loops, control flow
- Function and procedure calls

### Variables

- Identifiers
  - 30 characters max
  - starts by a letter
  - may contain letters, digits and `_$#`
  - Not case sensitive
- Range: standard for block-based language
  - i.e. from the relevant `BEGIN` to the relevant `END`
- Must be declared before use
- Types are required


### Variables types

- *usual types* are the standard SQL2 (or Oracle) types: integer, varchar, etc... look at the DBMS documentation
- *composite types* are adapted to receiving the results of queries (columns and lines): `%TYPE` and `%ROWTYPE`
- *reference type*: `REF`

### Declaring a variable

- in the `DECLARE` block
- syntax: `identifier [CONSTANT] type [:= value];`
- Examples

```
age integer;
name varchar(20);
birthDate date;
ok boolean := true;
```

- Note that `i,j integer;` is illegal

### Composite types

- `%TYPE` allows to say that the type of a variable is the same as another variable, as a colmun of a table or a view...
- Example
  - *employee* being a table, *name* a column of *employee*
  - `name employee.name%TYPE;`
  - The *name* variable has the same type as the *name* column of the *employee* table


### Composite types

- `%ROWTYPE` allows to say that the type a variable is that of a **whole line** of a table  
- Example
  - *employee* being a table
  - `emp employee%ROWTYPE;`
  - *emp* therefore contains the whole column set of a line of the *employee* table

### Example

```
DECLARE
  emp employee%ROWTYPE;
  name employee.name%TYPE;
BEGIN
  SELECT * from employee where number = '1234' INTO emp;
  name := emp.name;
  emp.number := '5663';
  emp.service := 'COMMUNICATION';
  ...
  INSERT INTO employees VALUES emp;
END;
```

### Types definition: RECORD

- `RECORD` type allows to define columns sets that do not necessarily match to an existing table
- similar to the C language `struct`
- Syntax

```
TYPE nameRecord IS RECORD (
  field1 type1,
  field2 type2,
  ...
  );
```

### Example

```
TYPE employee2 IS RECORD (
  id integer,
  name varchar(30)
);

empl employee2;
empl.id := 500;
```

### Types definition: TABLE

- `TABLE` allows to define an array which number of lines is not known in advance
- Each line of the array contains data which type is defined in the table definition
  - scalar (`INTEGER`,`VARCHAR`...)
  - defined through `%TYPE`, `%ROWTYPE` or `RECORD`
- Examples

```
TYPE myArray IS TABLE OF person%ROWTYPE;
TYPE myArray2 IS TABLE OF INTEGER INDEX BY BINARY INTEGER;
```

### Specific functions of type TABLE

- `EXIST(x)`
- `PRIOR(x)`
- `NEXT(x)`
- `DELETE(x)`
- `COUNT`
- `FIRST`
- `LAST`
- `DELETE`

### Example 

```
DECLARE
  TYPE prospectPilots IS TABLE OF pilot%ROWTYPE
    INDEX BY BINARY INTEGER
  arrPilots prospectPilots ;
  tmpIndex BINARY INTEGER ;
BEGIN
  ...
  tmpIndex := arrPilots.First ;
  arrPilots(4).Age := 37;
  arrPilots(4).Salary := 42000;
  arrPilot.DELETE(5);
END;
```

### Assign a value to a variable 

- Assignement `:=` 
- `INTO` inside a `SELECT`
- Caution: 
  - the `SELECT` statement must return only one line 
  - a column and a variable should not have the same name (if it happens the column will hide the variable)
- Examples

```
birthDate := '2001-01-02'
SELECT name FROM employee WHERE id=509 INTO employee_name;
```

### Control structures 

```
IF condition THEN
  statements;
END IF;
```

```
IF condition THEN
  statements1;
ELSE
  statements2;
END IF;
```

- Note: `ELSEIF` also exists 

### Control structures 

```
CASE expression
  WHEN condition1 statements1;
  WHEN condition2 statements2;
  ...
  ELSE statementsN;
END CASE;
```

- Caution : expression is of simple type and cannot be composed of several information (RECORD)


### Control structures: loops 

```
WHILE condition LOOP
  statements;
END LOOP;
```

```
LOOP
  statements;
EXIT [WHEN condition];
  statements;
END LOOP;
```

### Control structures: loops 

```
FOR counter IN [REVERSE] inf...sup LOOP
  statements;
END LOOP;
```

- Example 

```
  FOR i IN 1..10 LOOP
    sum := sum + i;
  END LOOP;
```

### Comments 

- on a single line 

```
-- single line comment
```

- on multiples lines 

```
/* for the
other
comments
*/
```


### Modfifying the database contents 


- `INSERT`, `UPDATE` and `DELETE` can used as statements 
- depending on the database parameters, `COMMIT` and `ROLLBACK` will be either implicit or explicit  


### Example 

```
DECLARE
  v_emp employee%ROWTYPE;
  v_name employee.name%TYPE;
BEGIN
  v_name := 'Doe';
  INSERT INTO employee(id,name) VALUES (600,v_name);
  v_emp.id := 610;
  v_emp.name := 'Doe';
  INSERT INTO employee(id,name) VALUES (v_emp.id,v_emp.name);
  COMMIT;
END;
```

### Cursors 

- How to iterate though the lines of a query result? 

```
SELECT * FROM Person WHERE id < 3
```

- To every SQL query, a cursor is attached 
- It can be used to obtain information about the query 
- A cursor can be **explicit** or **implicit** 
  - An implicit cursor is created when a query is executed 
  - An explicit cursor is used to browse through the lines of the result of a `SELECT` query 

### Cursor attributes 

- for all cursors, implicit or explicit 
  - `%ROWCOUNT`: number of lines handled by the cursor 
  - `%FOUND`: true if at least one line has been processed by the query or the last fetch 
  - `%NOTFOUND`: true if no line has been processed by the query or the last fetch 
- explicit cursors only 
  - `%ISOPEN`: true is the cursor is opened, i.e. the query has been executed 

### Implicit cursors 

- always named `SQL` whatever the query 
- Example 

```
DECLARE 
  nb_lines integer; 
BEGIN
  DELETE FROM emp WHERE dept=44;
  nb_lines := SQL%ROWCOUNT;
  ...
END;
```

- `nb_lines` is the number of deleted lines 

