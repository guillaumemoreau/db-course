
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
