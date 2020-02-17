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
      if params[:banjo_make] == "" || params[:banjo_model] == "" || params[:year_made] == "" || params[:price] == ""
        redirect to "/banjos/new"
      else
        @banjo = Banjos.new(make: params[:banjo_make], model: params[:banjo_model], year_made: params[:year_made], price: params[:price])
        if @banjos.save
          redirect to "/banjos/#{@banjos.id}"
        else
          redirect to "/banjos/new"
        end
      end
    else
      redirect to '/login'
    end
  end
end
