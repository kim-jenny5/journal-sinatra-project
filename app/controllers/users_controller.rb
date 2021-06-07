class UsersController < ApplicationController
    
    get '/signup' do
        erb :'/user/signup'
    end

    post '/signup' do
        @user = User.create(name: params[:name], username: params[:username], password: params[:username])

        if @user.save
            session[:user_id] = @user.id
            # This should redirect to user's home/'index' page with URL as user's username
            # redirect to "/#{@user.username}"
            redirect to "/"
        else
            redirect to "/signup"
        end
    end

    post '/logout' do
        session.clear
        redirect to "/"
    end
end