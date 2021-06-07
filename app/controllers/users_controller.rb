# require 'sinatra/base'
# require 'rack-flash'

class UsersController < ApplicationController
    # use Rack::Flash

    get '/signup' do
        erb :'/user/signup'
    end

    post '/signup' do
        @user = User.create(name: params[:name], username: params[:username], password: params[:username])

        if @user.save
            session[:user_id] = @user.id
            # This should redirect to user's home/'index' page with URL as user's username
            # redirect to "/#{@user.username}"
            redirect to "/#{@user.name}/home"
        else
            # flash message here
            redirect to "/signup"
        end
    end

    get '/login' do
        erb :'/user/login'
    end

    post '/login' do
        @user = User.find_by_username(params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/user/home"
        else
            # flash[:error] = "The email and/or password you entered is incorrect. Please enter the correct information."
            redirect to "/login"
        end
    end

    post '/logout' do
        session.clear
        redirect to "/"
    end

    get '/user/home' do
        erb  :'/user/home'
    end
end