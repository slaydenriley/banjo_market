class BanjoController < ApplicationController
    get '/banjos' do
        @banjos = Banjos.all
        erb :'banjos/banjos'
    end

    get '/banjos/new' do
        if logged_in?
          erb :'banjos/new'
        else
          redirect to '/login'
        end
      end

    post '/banjos/new' do
    if logged_in?
      if params[:make] == "" || params[:model] == "" || params[:year_made] == "" || params[:price] == ""
        redirect to "/banjos/new"
      else
        @banjo = current_user.banjos.create(params[:make], params[:model], params[:year_made], params[:price])
        redirect to '/banjos'
      end
    else
      redirect to '/login'
    end
  end
end
