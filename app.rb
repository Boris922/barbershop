#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	db.execute('select * from Barbers where name=?', [name]).length > 0

end

def seed_db db, barbers

	barbers.each do |barber|
		if !is_barber_exists? db, barber
			db.execute 'insert into Barbers (name) values (?)', [barber]
		end
	end	
end

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end

before do 
	db = get_db
	@barbers = db.execute 'select * from Barbers' 
end

configure  do
	db = SQLite3::Database.new 'barbershop.db'
	db.execute 'CREATE TABLE IF NOT EXISTS 
	"users" 
	(
			"Id"	INTEGER PRIMARY KEY AUTOINCREMENT,
			"username"	TEXT,
			"phone"	TEXT,
			"time"	TEXT,
			"barber"	TEXT,
			"color"	TEXT
	)'

	db.execute 'CREATE TABLE IF NOT EXISTS 
	"Barbers" 
	(
			"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
			"name"	TEXT
		
	)'

	seed_db db, ['Jessie', 'Walter', 'Gus', 'Ferrari', 'Loool']
end

get '/' do

	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"

end

get '/about' do
	erb :about
end


get '/visit' do
	erb :visit
end

post '/visit' do



	@aaa = params[:username]
	@bbb = params[:phone]
	@ccc = params[:time]
	@ddd = params[:barber]
	@eee = params[:color]


	hh = {:username => 'Введите имя', :phone => 'Введите телефон', :time => 'Введите время',
		:barber => "Введите парикмахера", :color => "Введите цвет"}

		hh.each do |key, value|
			if params[key] == ''
				@error = hh[key]
				return erb :visit
			end
		end

db = get_db
db.execute 'insert into users 
		(
			username,
			phone,
	  		time,
	  		barber, 
	   		color
	   	)
		values (?,?,?,?,?)', [@aaa, @bbb, @ccc, @ddd, @eee]

	

		erb "OK!, username is #{@aaa}, #{@bbb}, #{@ccc}, #{@ddd}, #{@eee}"

	erb "<h1>Спасибо, вы записаны</h1>"


end

get '/showusers' do
	db = get_db

	@results = db.execute 'select* from users order by id desc'

  erb :showusers
end

