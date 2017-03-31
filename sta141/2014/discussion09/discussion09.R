# discussion09.R

# Office Hours
# ============
#
# EXTRA OFFICE HOURS: Today 5-6pm Olson 205
#
# Charles:  MWF   8 - 9am     MSB 1117
# Nick:     M     4 - 5:30pm  EPS 1316
#           W     1 - 2:30pm  MSB 4208
# Duncan:   T/R   See Piazza  MSB 4210

# Questions, Please!
# ==================
# Q: How to save shell code?

# Shell Commands
# ==============
# ... to the shell!

# For reference:
#   http://learnxinyminutes.com/docs/bash/

# Shell Commands from R
# =====================
# There are several ways to run a shell command
# from R:
#   system()    run a shell command
#   shell()     run a shell command (Windows)
#   system2()   run a shell command (new style)

#   pipe()      open a connection to the shell

# The system() function accepts arbitrary
# commands and their arguments.
output = system('echo Hello', intern=T)
output

system('echo Hello | tr H C', intern=T)

# The system2() function accepts a specific
# command, and arguments are specified in the
# 'args' parameter.
output = system2('echo', args='Hello', stdout=T)
output

# The pipe() function is similar to system(),
# but returns the output through a connection.
con = pipe('cut -d, -f15 FiveAirports.csv')
readLines(con, 20)
close(con)
# This allows R to start using the output
# immediately rather than waiting for the shell
# to finish.

# Databases
# =========
# A database holds one or more tables (imagine an
# R data.frame).

# Most databases can be manipulated using
# structured query language (SQL). For example,
# SQL is supported by MySQL, PostgreSQL,
# MS Access, and SQLite databases.

# We'll use SQLite.

install.packages('RSQLite')

# The R package for working with SQLite is
# RSQLite.

library(RSQLite)

# SQLite databases are stored in a single file,
# typically with a .db extension.

# Connect to a SQLite database using the function
# dbConnect(), with syntax
#
#   dbConnect(TYPE, dbname = FILE)
#
# where TYPE is the type of database, and FILE is
# the path to the database file.

db = dbConnect(SQLite(), dbname = 'suppliers.db')

# When we're done with a database, disconnect
# from it with dbDisconnect().

dbDisconnect(db)

# The function dbListTables() returns the names
# of the tables in the database.

dbListTables(db)

# We can query the database using the function
# dbGetQuery(), which has format
#
#   dbGetQuery(DATABASE, QUERY)
#
# where DATABASE is the connection created with
# dbConnect(), and QUERY is an SQL query.

# SQL SELECT Statements
# =====================
# SQL commands are traditionally written in all
# caps, with a semicolon at the end. Column and
# table names are lowercase. However,
# SQL is **not** case-sensitive!

# The most basic command is selection:
#
#   SELECT column FROM table
#
# This selects the specified column(s) from the
# specified table. Use * if you want to select
# all columns.
dbGetQuery(db, 'SELECT * FROM Parts;')

dbGetQuery(db, 'SELECT City, Color FROM Parts;')

# Add LIMIT to the end to limit the number of
# rows returned. This is a good idea if you're
# not sure how big the table is!

dbGetQuery(db, 'SELECT * FROM Parts LIMIT 3;')

# Use SELECT DISTINCT if you only want the 
# distinct values in the column(s).
dbGetQuery(db, 'SELECT DISTINCT Color FROM 
           Parts;')

# On multiple columns, this returns all distinct
# pairs (or tuples).
dbGetQuery(db, 'SELECT DISTINCT City, Color
           FROM Parts;')

# To select only the rows where a column
# satisfies a condition, use 
#
#   SELECT column FROM table WHERE condition
#
# Possible conditions:
#   =, >, >=, <, <=
#   != or <>, meaning 'not equal'

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE Weight > 14;')

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE Color = "Red";')

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE COLOR <> "Red";')

# Another possible condition is that a column
# is within a collection of values:
#
#   column IN (value1, value2, ...)

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE City IN ("London", "Oslo");')

# We might also be interested in a column within
# a range:
#
#   column BETWEEN value1 AND value2
#
# This works for both numbers and text. Inclusive.

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE Weight BETWEEN 13 AND 16;')

# For text columns, we might want to match on
# a pattern:
#
#   column LIKE pattern
#
# SQL pattern syntax is slightly different from
# regular expresions.
#   _ matches any 1 character (regex '.')
#   % matches 0 or more characters (regex '.*')

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE City LIKE "L%";')

# Conditionals can also be chained together with
# AND, OR, and NOT.

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE City IN ("London", "Oslo")
           OR Weight = 12;')

# To sort the results, add:
#
#   ORDER BY column1 ASC, column2 DESC, ...
#
# Here ASC means ascending order and DESC means
# descending order. These can be left out; the
# default is ascending order.

dbGetQuery(db, 'SELECT * FROM Parts
           WHERE Weight > 12
           ORDER BY PartName DESC, Weight ASC;')

