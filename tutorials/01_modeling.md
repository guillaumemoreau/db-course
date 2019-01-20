% Databases: Tutorial1
% Modeling
% January 2019

# Exercise 1

We wish to handle the absences lists of students during courses. At the end of each course, a teacher must be able to tick students who were missing.

Every course can have lectures, tutorials or labs.

Every class takes place with a teacher.

Students registered to a course must attend very class.

1. Define the elements to model
2. Deduce functional dependencies on your data
3. Build the dependency graph
4. Build a conceptual data model on the basis of an Entity-Association schema
5. Check that your functional dependencies are enforced

# Exercise 2

Your company requests you to setup a simplified CRM (Customer Relationship Management) in order to share the contacts lists between the sales representatives of the company.

For each contact, we have his name (last and first name), the company he works for, his phone number and his email.

For each company, we have its name, its address and its registration number (SIRET in French).

There may be several contacts in a given company.

1. Build a conceptual data model on the basis of an Entity-Association schema
2. The sales representatives of your company wish to have the list of their own contacts. Update your schema to include this information
3. The CEO said that he wants the sales representatives share their contacts. However, the idea is not very well accepted, hence the following tradeoff: a sales representative will explicitly tell which other sales representatives will have access to his contacts. Note that only the owner of the contact has the right to share the contact. Update the schema accordingly.
