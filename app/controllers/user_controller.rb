class UserController < ApplicationController
  get '/users/:id' do
    @user = Users.find_by_id(params[:id])
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
      @user = Users.new(:name => params[:name], :email => params[:email], :password => params[:password], :description => params[:description])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/banjos'
      else
        redirect to '/signup'
      end
    end
  end

  get '/signup' do
    erb :'/users/new'
  end

  get '/users/:id/edit' do
    if params[:id].to_i == current_user.id
      @user = current_user
      erb :'users/edit'
    else
      redirect to "/users/#{current_user.id}/edit"
    end
  end

  patch '/users/:id' do
    if logged_in?
      if params[:name] == "" || params[:email] == "" || params[:password] == ""
        redirect to "/users/#{current_user.id}/edit"
      else
        @user = current_user
        @user.update(name: params[:name], email: params[:email], password: params[:password], description: params[:description])
        @user.save
        redirect to "/"
      end
    else
      redirect to '/'
    end
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
