require 'sequel'
DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")

  dprojects = DB[:projects]
  dboards = DB[:boards]
  dcards = DB[:cards]
  dcomments = DB[:comments]
