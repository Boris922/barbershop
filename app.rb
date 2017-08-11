#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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

	# 	#Для каждой пары ключ, значение
		
	# hh.each do |key, value|

	# 	# Если параметр пуст

	# 	if params[key] == ''

	# 		# переменой eerror присвоить value из хеша hh
	# 		# (a value из хеша hh это сообщение об ошибке)
	# 		@error = hh[key]
	# 		#вернуть представление visit
	# 		return erb :visit
	# 	end

	# end
	

	# Немного другой вариант
	
	@eror = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit 
	end



	erb "OK!, username is #{@aaa}, #{@bbb}, #{@ccc}, #{@ddd}, #{@eee}"

end		