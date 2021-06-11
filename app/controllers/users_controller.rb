# require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/signup' do
        if logged_in?
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
            erb  :'/user/home'
        else
            redirect to "/login"
        end
    end
end