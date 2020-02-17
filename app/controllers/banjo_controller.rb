class BanjoController < Sinatra::Base
    get '/banjos' do
        erb :banjos
    end
end
