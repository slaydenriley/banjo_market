class BanjoController < ApplicationController

    get '/banjos' do
        if logged_in?
            @banjos = Banjos.all
            erb :'banjos/banjos'
        else
            redirect to '/login'
        end
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
            if params[:make] == "" || params[:model] == "" || params[:year_made] == "" || params[:price] == "" || params[:description] == ""
                redirect to "/banjos/new"
            else
                @banjo = Banjos.new(:make => params[:make], :model => params[:model], :year_made => params[:year_made], :price => params[:price], :description => params[:description])
                @banjo.users_id = current_user[:id]
                @banjo.save
                redirect to '/banjos'
            end
        else
            redirect to '/login'
        end
    end

    get '/banjos/:id' do
        @banjo = Banjos.find_by_id(params[:id])
        erb :'banjos/show'
    end

    delete '/banjos/:id/delete' do
        if logged_in?
            @banjo = Banjos.find_by_id(params[:id])
            if @banjo.users_id == current_user.id
                @banjo.delete
            end
            redirect to '/banjos'
          else
            redirect to '/login'
          end
    end

    get '/banjos/:id/edit' do
        if logged_in?
            @banjo = Banjos.find_by_id(params[:id])
            if @banjo.users_id == current_user.id
                erb :'banjos/edit'
            else
                redirect to '/banjos'
            end
        else
            redirect to '/login'
        end

    end


    patch '/banjos/:id' do
        if logged_in?
            if params[:make] == "" || params[:model] == "" || params[:year_made] == "" || params[:price] == ""
                redirect to "/banjos/#{params[:id]}/edit"
            else
                @banjo = Banjos.find_by_id(params[:id])
                @banjo.update(make: params[:make], model: params[:model], year_made: params[:year_made], price: params[:price], description: params[:description])
                @banjo.save
                redirect to "/banjos/#{params[:id]}"
            end
        else
            redirect to '/login'
        end
    end
end

