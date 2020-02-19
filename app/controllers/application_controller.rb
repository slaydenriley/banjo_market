require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    if logged_in?
      erb :index
    else
      redirect to '/login'
    end
  end

  not_found do
    status 404
    erb :oops
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= Users.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
