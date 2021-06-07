require './config/environment'

class ApplicationController < Sinatra::Base
  set :public_folder, "public"
  set :views, "app/views"
  enable :sessions
  set :session_secret, "user_secret"

  get '/' do
    erb :index
  end
end