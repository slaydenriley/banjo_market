class UserController < Sinatra::Base
    post '/login' do
        @user = User.find_by(:email => params[:email])
        erb :"/users/show"
    end
end
