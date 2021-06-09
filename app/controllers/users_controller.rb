# require 'sinatra/base'
# require 'rack-flash'

class UsersController < ApplicationController
    # use Rack::Flash

    get '/signup' do
        # if logged_in?
        #     redirect to "/#{current_user.username}"
        # else
            erb :'/user/signup'
        # end
    end

    post '/signup' do
        @user = User.new(params)
        # binding.pry
            # name: params[:name], username: params[:username], password: params[:password])
        if @user.save
            session[:user_id] = @user.id
            # This should redirect to user's home/'index' page with URL as user's username
            # redirect to "/#{@user.username}"
            redirect to "/#{current_user.username}"
        else
            # flash message here that the username is taken
            redirect to "/signup"
        end
    end

    get '/login' do
        # if logged_in?
        #     redirect to "/#{current_user.username}"
        # else
            erb :'/user/login'
        # end
    end

    post '/login' do
        @user = User.find_by_username(params[:username])
        # binding.pry
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/#{@user.username}"
        else
            # flash[:error] = "The email and/or password you entered is incorrect. Please enter the correct information."
            redirect to "/login"
        end
    end

    post '/logout' do
        session.clear
        redirect to "/"
    end

    get '/:username' do
        # binding.pry
        # if current_user
        @user = User.find_by_username(params[:username])
        # if logged_in?
        if current_user == @user
            erb  :'/user/home'
        else
            redirect to "/login"
        end
    end
end