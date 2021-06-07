class UsersController < ApplicationController
    
    get '/signup' do
        erb :'/user/signup'
    end

    post '/signup' do
        @user = User.create(params[:user])

        if @user.save
            session[:user_id] = @user.id
            # This will redirect to user's home/'index' page with URL as user's username
            redirect to "/#{@user.username}"
        else
            redirect to "/signup"
        end
    end
end