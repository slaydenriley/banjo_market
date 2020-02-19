class UserController < ApplicationController
  get '/login' do
    @current_user = nil
    erb :'/users/login'
  end

  post '/login' do
    user = Users.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/"
    else
      redirect to '/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      if params[:password] == params[:confirm_password]
        @user = Users.new(:name => params[:name], :email => params[:email], :password => params[:password], :description => params[:description])
        if @user.save
          session[:user_id] = @user.id
          redirect to '/banjos'
        else
          redirect to '/signup'
        end
      else
        redirect to '/signup'
      end
    end
  end

  get '/signup' do
    erb :'/users/new'
  end

  get '/users' do
    if logged_in?
      @users = Users.all
      erb :'/users/users'
    else
      redirect to '/login'
    end
  end

  get '/users/:id' do
    if logged_in?
      @user = Users.find_by_id(params[:id])
      erb :'users/show'
    else
      redirect to '/login'
    end
  end

  get '/users/:id/edit' do
    if logged_in?
      if params[:id].to_i == current_user.id
        @user = current_user
        erb :'users/edit'
      else
        redirect to "/users/#{current_user.id}/edit"
      end
    else
      redirect to '/login'
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
        redirect to "/user/#{@user.id}"
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
