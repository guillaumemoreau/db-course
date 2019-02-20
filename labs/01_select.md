% Databases: Lab 2
% Queries in a complex database
% January 2019

# Learning outcomes

After this lab, you should be able to:

- Analyze an existing physical model
- Write correct SQL queries (both for syntax and semantics)
- Be able to explain the structure of SQL queries
- Assess whether your queries return the appropriate results

# Rail network database

In this lab, we will consider part of a rail network. While most cities are real, trains schedules were randomly generated. The first step of the lab will to connect to an SQL database on a Centrale Nantes server.

To this end, we will work with `pgAdmin`, a software installed on all computers of Centrale Nantes. We will use the following information for connecting:

- server (host): `appli-pfe.ec-nantes.fr`
- database name: `trains_en`
- username: `app2_xx` where `xx` stands for your number (see the whiteboard)
- password: `osiris`

Have a look at the physical model provided.

Then, you can answer the following questions if they make sense (if they do not, explain why).

1. What are the stations registered in the database?
2. Give the list of stations along with their station chief name
3. Give the list of drivers who are driving *TER* train type
4. Give the list of sleeping coaches (train couchettes in French)
5. What is the function of Yvon Manac'h?
6. Which agents have participated into the maintenance of train 85250 since it was put into service?
7. What are the trains stopping at Cholet between 6:00 and 8:00, sorted by schedule on the first Monday of January 2019?
8. What are the schedules for the Nantes-Lyon trains?
9. The train running from Nantes to Lyon today will be arriving late in Angers. Who are the people in charge you should call?


A few information:

- `EXTRACT(HOUR FROM afield)` extracts information hour from the attribute named *afield*?
- `CAST(stop_scheduledtime AS VARCHAR)` can be used to transform a time into a character string which allows to use `LIKE` comparisons
- `DATE(timestamp)` extracts the date from a timestamp
- `CURRENT_DATE` is today's date
- `CURRENT_TIME` is current date and time
