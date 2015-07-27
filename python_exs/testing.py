#!/usr/bin/python

import MySQLdb

# Open database connection
db = MySQLdb.connect("mysql.christiecapper.com","cappersql","agouti86}valerians","mta_bus_project")

# prepare a cursor object using cursor() method
cursor = db.cursor()

# execute SQL query using execute() method.
cursor.execute("SELECT * FROM raw_data LIMIT 4")

# Fetch a single row using fetchone() method.
# data = cursor.fetchone()
data = cursor.fetchall()

for row in data:
	print row[4].year

# print "Database result : %s " % data

# disconnect from server
db.close()