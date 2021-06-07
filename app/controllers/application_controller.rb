require './config/environment'

class ApplicationController < Sinatra::Base
  set :public_folder, "public"
  set :views, "app/views"
  enable :sessions
  set :session_secret, "user_secret"

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end
end