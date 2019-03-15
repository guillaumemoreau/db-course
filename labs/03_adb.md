% Databases: Lab 4
% Accessing a database from a program
% March 2019

# Objectives

- Access an existing database from a program
- Query a database from a program

# Introduction

As seen in previous labs, databases can be accessed through a data administration tool such as pgAdmin. While this is useful and powerful, it remains even more useful to access it from other sofware. There exists three main possibilities :

- Access from a Business Intelligence software (BO, Birt, Jasper...); these tools are used to perform complex reports and synthesis, we will see them later
- Access from a data warehouse or an ETL like Talend in order to use several data sources together and/or to have snapshots of a database at any given instant. Those tools can also be data sources for BI tools
- Access from a programming language. This is mainly what happens in web applications where the program is located on the webserver and is accessing a database with which it builds views on the data

# Database access with python

If you want to access a database from your own program, you will have to select a programming language and most probably a couple of third-party library (a driver). Access methods vary among programming languages, we will here stick to the python language as it looks it was the most shared language among the group.

Before any query, a connection to the database is required. Usually, a database connection is opened at the beginning of a program and closed when the program terminates, although there exist other possibilities. Once the connection is opened, we can write SQL queries and exploit their results thanks to the structures provided by python.

At first, we need to install python drivers for our specific databases. If you have admin rights, you can write :

```
python -m pip install postgres
```

If you do not have admin rights, you can install the postgres driver in your own directory (this should the method to use on ECN computers when using the Linux virtual machine):

```
pip install postgres --target=myFolder
```

where /myFolder/ will be replaced with the destination path that you chose.

Follows a first example code:

```
import psycopg2
conn = psycopg2.connect("host=myHost dbname=myDB user=xxx password=yyy")
cursor = conn.cursor()
cursor.execute("SELECT * from person")
rows = cursor.fetchall()
for row in rows:
  print(row)
cursor.close()
conn.close()
```

The `psycopg2.connect()` is used to open a connection to the database, it returns an object that will be used later to close the connection.

The cursor is created from the connection object. Their role is execute SQL queries through the `execute()` method. Once you have a result, you can use two different methods:

- `fetchone()` will return the first line
- `fetchall()` will return *all* lines

Cursors can also be used directly in loops as a replacement for `fetchall()`:

```
cursor.execute("SELECT * from person")
for row in cursor:
  print(row)
cursor.close()
```

More (and important) information on psycopg2 is available here: http://initd.org/psycopg/docs/usage.html

In particular, you should see how to use variables inside queries. It is important as if every query can be written without variable, you probably don't to access the database from a programming language.

# Work to do

So far, we have used database admin tools to enter data in our database. In this part, you will use a python program to access data. We will work more specifically for two roles: customer and dispatcher.

1. The goal of the first part consists in creating an interface for creating an order. To provide an order, an existing customer will be able to add/review/modify the product, quantity, delivery due date and of course delivery places.
2. In the second part, you will provide the most convenient interface (text-based or with a GUI if you have time and know how to do so) built mission orders for truck drivers. The dispatcher must have access to all information about orders but there may be different ways of presenting the information to ease his/her job. In this part, you will have to think of the best tools you can provide and explain how you designed your solution. It is will be very important to be dispatcher-oriented.

# End of lab

At the end of this lab (or at a date that will be decided during the lab), your work must be submitted to guillaume.moreau@ec-nantes.fr:

- a PDF file with the report explaining the solution that you have designed and a few screenshots about how the program works
- the python code written (can also be submitted as a github link if you are familiar with github)
