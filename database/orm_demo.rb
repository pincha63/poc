#load 'dev01connect.rb'
require 'sequel'                                                            
DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")  

# works if there are records
  class Project < Sequel::Model(:projects)
    one_to_many :boards , key: :pid 
    def to_api
      {
        aapid: pid,
        aapname: pname,
        aapstatus: pstatus
      }
    end
  end

  def pid_from_pname(myName)
     (myTemp = Project.first(pname: myName)) ? myTemp.pid : "Nothing"
  end

#  puts "**" + Project.first(pname: "Work").pid.to_s 
#  puts "***** Work " + pid_from_pname("Work").to_s
#  puts "***** Pers " + pid_from_pname("Personal").to_s
#  puts "***** Nil  " + pid_from_pname("Nonesuch").to_s 
  
  t = Project.first 
#  puts "1: first using database fields"
#  puts t.pid.to_s + " : " + t.pname.to_s + " : " + t.pstatus.to_s 
#  puts "2: first.to_api.values.inspect"
#  puts t.to_api.values.inspect
#  puts "3: Project.all to_api"
#  s = Project.all { |r| p r.to_api }
  puts "4: all"
  s = Project.all { |r| p r }

  class Board < Sequel::Model(:boards)
    many_to_one :project , key: :pid
  one_to_many :cards , key: :bid
    def to_api
      {
        aabid: bid,
        aabname: bname,
        aabstatus: bstatus
      }
    end
  end  

    def bid_from_bname(myName)
       (myTemp = Board.first(bname: myName)) ?  myTemp.bid : "Nothing"
    end  
  
  def bname_from_bid(myBid)
       (myTemp = Board.first(bid: myBid)) ?  myTemp.bname : "Nothing"
    end  

  puts "**** CIHI " + bid_from_bname("CIHI").to_s
  puts "**** NOPE " + bid_from_bname("NADA").to_s
  puts "Should be DBMS : " + bname_from_bid(bid_from_bname("DBMS"))
  puts "5: Board.first.to_api.values.inspect"
  puts Board.first.to_api.values.inspect
  puts "6: Board.all to_api"
  b = Board.all { |r| p r.to_api } 
  
  class Card < Sequel::Model(:cards)
    many_to_one :board, key: :bid 
  one_to_many :comments
    def to_api
      {
        aakid:        kid,
        aabid:        bid,
        aakname:      kname, 
        aakcontents:  kcontents,
        aakseq:       kseq,
        aakstatus:    kstatus,
        aakcreatedts: kcreatedTS,
        aamodifiedts: kmodifiedTS
      }
    end
  end  

#  puts "7: Card.first.to_api.values.inspect"
#   puts Card.first.to_api.values.inspect
#  puts "8: Card.all to_api"
#  b = Card.all { |r| p r.to_api }   
  puts "9: First card with given board name"  
  puts  Card.first(bid: bid_from_bname("DBMS")).to_api   
#  ## puts  Card.first(bid: bid_from_bname("DBMS")).to_api.inspect
#  puts  Card.first(bid: bid_from_bname("DBMS")).to_api.values.inspect   
#  ## puts  Card.first(bid: bid_from_bname("DBMS")).to_api.values   

puts "*******"
# Project.first ? (Project.first.boards.each {|t| puts t.to_api})  : (p "Nothing")
puts "**"
#  r = Board.first
#  s = r.project
#  puts s.to_api[:aapname]

Board.each do |b|
  puts "board name "  + b.to_api[:aabname]
  puts "project name " + b.project.to_api[:aapname] + " : " + b.project.pname 
end  

# (r = Project[1].boards) ? p : "Nothing"
# (r = Project[2].boards) ? p : "Nothing"
