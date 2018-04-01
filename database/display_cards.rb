require 'sequel'
DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")

  dprojects = DB[:projects]
  dboards = DB[:boards]
  dcards = DB[:cards]
  dcomments = DB[:comments]

#  puts "Projects"
#  dprojects.all  { |r| p r }
#  puts "Boards"
#  dboards.all  { |r| p r }
  puts "Cards"
  dcards.all { |r| p r }
  
#  dcards.columns.each { |col| p col }