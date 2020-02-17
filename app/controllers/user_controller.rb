class UserController < Sinatra::Base
    get '/login' do
        if !logged_in?
          erb :'users/login'
        else
          redirect to '/banjos'
        end
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

    get '/signup' do
        if !logged_in?
          erb :'users/new', locals: {message: "Please sign up before you sign in"}
        else
          redirect to '/banjos'
        end
      end
    
      post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          @user = Users.new(:name => params[:name], :email => params[:email], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          redirect to '/banjos'
        end
      end
end
