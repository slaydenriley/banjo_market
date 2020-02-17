class BanjoController < ApplicationController
    get '/banjos' do
        erb :'banjos/banjos'
    end

    get '/banjos/new' do

    end
end
