# Logical and physical models

### Context


- So far, we have conceptual models
  - Entity-Association
  - UML
  - *SysML*
- We remember of mentioning the relational model
- How to switch from one model to another one?
  - Logical model
  - Physical model

### Logical and physical models

- Data logical model
  - it consists in describing the data structure that is used with referring to a specific programming language
- Data physical model
  - it is a formalism that allows to specify the storage system used in a DBMS

# From the E-A model to the relational model

### Entity-Association model

- Entities
- Associations
- Properties
- Identifiers
- Cardinalities

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-1.pdf}

### Translation process

- 3 translation rules
  - 1 for entities
  - 2 for associations
- Rules must be applied in the right order
  - will provide a Logical data model
- Domain values must be added to have a physical model

### Rule 1

- Every entity is translated into a relation
- Its properties are the  attributes of the relation
- Its identifier is the identifier of the relation

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-1.pdf}

- Student(\underline{StudentId},Lastname,Firstname)
- Course(\underline{AbbName},Name)
- Faculty(\underline{FacultyId},Lastname,Firstname)
- Status(\underline{StatusName})

### Rule 2

- Every binary association which cardinality is either 0:1 or 1:1 is translated by copying the identifier of the opposite entity in the entity having 0:0 or 1:1 cardinality
- An external identifier is created between the two relations
- The properties of the association are also copied
- If the two involved cardinalities are 0:1 or 1:1, the most representative is chosen

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-2.pdf}

- Student(\underline{StudentId},Lastname,Firstname)
- Course(\underline{AbbName},Name)
- Faculty(\underline{FacultyId},Lastname,Firstname,\textcolor{red}{StatusName})
- Status(\underline{StatusName})

### Rule 3

- The remaining associations are translated into relations. The identifiers of the linked entities are copied into the new relation and are its identifier
- An external identifier is created between the new relation and each linked entity at the identifier level
- The properties of the associations are also copied

### Example

\center\includegraphics[width=.8\textwidth]{fig/lpm-3.pdf}

- Student(\underline{StudentId},Lastname,Firstname)
- \textcolor{red}{Participates(StudentId,AbbName)}
- Course(\underline{CourseId},Name)
- \textcolor{red}{Teaches(FacultyId,AbbName)}
- Faculty(\underline{FacultyId},Lastname,Firstname,StatusName)
- Status(\underline{StatusName})

### Logical data model

\center\includegraphics[width=.8\textwidth]{fig/lpm-4.pdf}

### From the logical model to the physical model

- Add the domain values for the properties
- i.e. consider again every property and add it its domain
- Caution to external links: attributes must have the same domains

### Physical data model

\center\includegraphics[width=.8\textwidth]{fig/lpm-5.pdf}


### Summary

- Advantages
  - translation fairly intuitive
  - few transformation rules
- Caution: adding domain values for properties
