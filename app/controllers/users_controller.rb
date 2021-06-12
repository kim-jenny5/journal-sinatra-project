class UsersController < ApplicationController
    get '/signup' do
        if logged_in?
            flash[:already_signed_in] = "You are already logged in!"
            redirect to "/#{current_user.username}"
        else
            erb :'/user/signup'
        end
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            redirect to "/#{current_user.username}"
        else
            flash[:message] = "This username has already been taken."
            redirect to "/signup"
        end
    end

    get '/login' do
        if logged_in?
            flash[:already_signed_in] = "You are already logged in!"
            redirect to "/#{current_user.username}"
        else
            erb :'/user/login'
        end
    end

    post '/login' do
        @user = User.find_by_username(params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/#{@user.username}"
        else
            redirect to "/login"
        end
    end

    post '/logout' do
        session.clear
        redirect to "/"
    end

    get '/:username' do
        @user = User.find_by_username(params[:username])
        if current_user == @user
            flash[:no_access] = "You don't have access to that user's account."
            erb  :'/user/home'
        else
            flash[:signed_out] = "You've been logged out. Please log back in."
            redirect to "/login"
        end    
    end
end