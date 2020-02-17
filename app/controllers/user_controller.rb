class UserController < ApplicationController
  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = Users.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/banjos'
    end
  end

  get '/signup' do
    erb :'/users/new'
  end

  post '/signup' do

  end
end
