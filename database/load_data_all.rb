require 'sequel'
DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")

  dprojects = DB[:projects]
  dboards = DB[:boards]
  dcards = DB[:cards]
  dcomments = DB[:comments]
  
# assumes there are no records in these tables
  
  # create projects 
  dprojects.insert(:pname => "Work", :pstatus => 1)
  dprojects.insert(:pname => "Personal", :pstatus => 1)
  # this statement loads the value of the selected project's project_id to serve as foreign key when creating boards
  @work_pk = DB.fetch("SELECT pid FROM public.projects PP WHERE PP.pname = 'Work'") { |r| @myKey = r.values[0] }

  # create boards
  dboards.insert(:bname => "CCO", :pid => @myKey, :bstatus => 0)
  dboards.insert(:bname => "CIHI", :pid => @myKey, :bstatus => 1)
  dboards.insert(:bname => "DBMS", :pid => @myKey, :bstatus => 0)
  
  # load the value of the selected boards' board_id to serve as foreign keys when creating cards  
  @work_pk = DB.fetch("SELECT bid FROM public.boards PB WHERE PB.bname = 'CIHI'")  { |r| @myKey = r.values[0] }
  @work_pk = DB.fetch("SELECT bid FROM public.boards PB WHERE PB.bname = 'CCO'")  { |r| @exKey = r.values[0] }
  @work_pk = DB.fetch("SELECT bid FROM public.boards PB WHERE PB.bname = 'DBMS'")  { |r| @doKey = r.values[0] }
  
  # create cards
  dcards.insert(:bid => @myKey, :kseq => 1,  :kname=>"card 1", :kcontents=>"Tommy", :kstatus =>1, :kcreatedTS => Time.now.utc )
  dcards.insert(:bid => @myKey, :kseq => 2,  :kname=>"card 2", :kcontents=>"Manny", :kstatus =>1, :kcreatedTS => Time.now.utc )
  dcards.insert(:bid => @exKey, :kseq => 3,  :kname=>"card 3", :kcontents=>"Sammy", :kstatus =>1, :kcreatedTS => Time.now.utc )
  dcards.insert(:bid => @doKey, :kseq => 1,  :kname=>"card 4", :kcontents=>"Sunil", :kstatus =>1, :kcreatedTS => Time.now.utc )
  
  #update single card
  dcards.where(kseq: 1).update(:kseq => 9)
  dcards.where(kname: "card 3").update(:kseq => 8)
  # @res = DB.fetch("SELECT * FROM public.cards")  { |r| p r }
