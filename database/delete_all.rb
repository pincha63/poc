require 'sequel'
DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")

  dprojects = DB[:projects]
  dboards = DB[:boards]
  dcards = DB[:cards]
  dcomments = DB[:comments]

  dcomments.delete 
  dcards.delete
  dboards.delete
  dprojects.delete

  #puts "We have #{dcards.count} cards - should be 0"
  def noRecords (a)
    a.empty?.to_s + " : "
  end
  
  puts "All should be true: " + noRecords(dprojects) + \
    noRecords(dboards) + noRecords(dcards) + noRecords(dcomments)
  