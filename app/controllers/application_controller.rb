require './config/environment'
require 'date'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  set :public_folder, "public"
  set :views, "app/views"
  enable :sessions
  set :session_secret, "user_secret", ENV.fetch('SESSION_SECRET')

  get '/' do
    if logged_in? 
      @user = current_user
      redirect to "/#{@user.username}"
    else
      erb :index
    end
  end

  helpers do
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end
end