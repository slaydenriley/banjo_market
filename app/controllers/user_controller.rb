class UserController < ApplicationController
  get '/users/:slug' do
    @user = Users.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = Users.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/banjos"
    else
      redirect to '/signup'
    end
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

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/'
    end
  end
end
