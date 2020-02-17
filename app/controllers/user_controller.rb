class UserController < ApplicationController
  get '/login' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :'/users/new'
  end
end
