require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'

helpers do
  def css(*stylesheets)
    stylesheets.map do |myStylesheet|
      "<link href=\"/#{myStylesheet}.css\"
      media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end
end
get ('/styles.css'){scss :styles}

require 'sequel'                                                            
  DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")
  dcards = DB[:cards]
  dboards = DB[:boards]

class Card < Sequel::Model(:cards)
    many_to_one :board, key: :bid 
  one_to_many :comments
end

get ('/') do     # router 01
  slim :text_ui
end

get '/cards' do #show list of cards     # router 02
  @cards = dcards.all  # if there are comments, get them as well
  slim :cards
end

# This starts creation of new record (works!)      # router 03
get '/cards/new' do
  @card = Card.new 
  slim :card_new
end

# This completes the creation of new record (called by the form) (works!)
post '/finalize_add' do      # router 04
  x1 = (params[:card])
  puts "Created card with name: #{x1["kname"]}" 
  dcards.insert(:bid => x1["bid"], :kseq => 1, :kname=>x1["kname"], \
      :kcontents=>x1["kcontents"], :kstatus =>1, \
      :kcreatedTS => Time.now.utc, :kmodifiedTS => Time.now.utc )
  redirect to ("/cards")
end

get '/cards/:id/edit' do      # router 05
  puts "Start Editing Routine"
  @card = Card.first(kid: params[:id])
  puts @card.inspect
  slim :card_edit
end

get '/cards/:id' do      # router 06
  puts "Show card #{params[:id]}"
  @card = Card.first(kid: params[:id])
  slim :card_show
end

# This is the only PUT route. It updates one record per contents of params[:card]
put '/cards/:id' do      # router 07
  x1 = (params[:card])
  myKid = params[:id]
  puts "Updated card with ID: #{myKid}  ---------- before"
  puts dcards.where(kid: myKid).first.inspect 
  dcards.where(kid: myKid).update(:bid => x1["bid"], :kseq => 1, :kname=>x1["kname"], \
      :kcontents=>x1["kcontents"], :kstatus =>1, :kmodifiedTS => Time.now.utc)
  puts "Updated card with ID: #{myKid}  ---------- after"
  puts dcards.where(kid: myKid).first.inspect 
  redirect to("/cards/#{myKid}")
end

delete '/card/:id' do      # router 08
  myKid = params[:id]
  myName = dcards.where(kid: params[:id]).first[:kname]
  puts "Deleting card with ID: #{params[:id]} and name #{myName}"
  dcards.where(kid: myKid).delete
  redirect to('/cards')
end