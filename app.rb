#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure  do
	db = get_db
	@db.execute 'CREATE TABLE IF NOT EXISTS 
	"users" 
	(
			`Id`	INTEGER PRIMARY KEY AUTOINCREMENT,
			`username`	TEXT,
			`phone`	TEXT,
			`time`	TEXT,
			`barber`	TEXT,
			`color`	TEXT
	)'
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
		values (?,?,?,?,?)', [@username, @phone, @datetime, @barber, @color]

	

		erb "OK!, username is #{@aaa}, #{@bbb}, #{@ccc}, #{@ddd}, #{@eee}"


end

def get_db
	return SQLite3::Database.new 'barbershop.db'
end