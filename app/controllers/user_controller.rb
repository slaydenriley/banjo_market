class UserController < Sinatra::Base
  get '/login' do
    erb :'/users/login'
  end
end
