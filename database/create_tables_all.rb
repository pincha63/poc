require 'sequel'
DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")

########################### CREATE TABLES
DB.create_table :projects do
  primary_key   :pid
  String        :pname
  Fixnum        :pstatus
end

DB.create_table :boards do
  primary_key   :bid
  foreign_key   :pid, :projects
  String        :bname
  Fixnum        :bstatus
end

DB.create_table :cards do
  primary_key   :kid
  foreign_key   :bid, :boards
  String        :kname
  String        :kcontents
  Fixnum        :kseq
  Fixnum        :kstatus
  DateTime      :kcreatedTS
  DateTime      :kmodifiedTS
end

DB.create_table :comments do
  primary_key   :cid
  foreign_key   :kid, :cards
  String        :ccontents
  Fixnum        :cseq
  Fixnum        :cstatus
  DateTime      :ccreatedTS
  DateTime      :cmodifiedTS
  end
