require "sinatra"
require_relative "math.rb"


get '/' do
message = params[:message] 
erb :login, locals:{message:message}
end

post '/login' do
    correct_login = {ldeems: "001122", greg: "hank", bill: "ted"}
    username = params[:username]
    password = params[:password]
    correct_login.each_pair do |user, value|
        if username == user.to_s && password == value
            message = "successful login"
            redirect '/name?message=' + message
        elsif username == user.to_s
            message = "incorrect password"
            redirect '/?message=' + message
        elsif password == value
            message = "incorrect username"
            redirect '/?message=' + message
        end
    end
        message = "incorrect username and password"
        redirect '/?message=' + message            
end

get '/name' do
	message = params[:message]
	erb :name, locals: {message: message}
end	

post '/name' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	#"your name is #{first_name} #{last_name}"
	redirect '/calculator?first_name=' + first_name + "&last_name=" + last_name
end	

get '/calculator' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	erb :calculator, locals: {first_name: first_name, last_name: last_name}
end	

post '/calculator' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	num1 = params[:num1]
	function = params[:function]
	num2 = params[:num2]
	answer = math(function,num1.to_i,num2.to_i)
 	#"#{num1} #{function} #{num2} = #{answer}"
 	redirect '/results?first_name=' + first_name + "&last_name=" + last_name + "&num1=" + num1 + "&function=" + function + "&num2=" + num2 + "&answer=" + answer.to_s 
end

get '/results' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	num1 = params[:num1]
	function = params[:function]
	num2 = params[:num2]
	answer = math(function,num1.to_i,num2.to_i)
	if function == "add"
		function = "+"
	end	
	#"#{function}"
	erb :results, locals: {first_name: first_name, last_name: last_name, num1: num1, function: function, num2: num2, answer: answer}
end

post '/wayback' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	redirect '/calculator?first_name=' + first_name + "&last_name=" + last_name
end	