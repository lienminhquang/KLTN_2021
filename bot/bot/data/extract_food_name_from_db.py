import pyodbc 
# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
server = 'localhost' 
database = 'FoodOrder' 
username = 'myusername' 
password = 'mypassword' 
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database + ';Trusted_Connection=yes')
cursor = cnxn.cursor()

query = "select name from food"
cursor.execute(query)
row = cursor.fetchone()

file = open("foods.txt", "w", encoding="utf-8")
while row: 
    print(row[0])
    file.write("- " + row[0] + "\n")
    row = cursor.fetchone()

file.close()