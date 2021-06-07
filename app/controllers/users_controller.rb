class UsersController < ApplicationController
    
    get '/signup' do
        erb :'/user/signup'
    end

    post '/signup' do
        # binding.pry
        @user = User.create(params)

        if @user.save
            
        else
            redirect to "/signup"
        end

        # if @user.name.blank? || @user.username.blank? || @user.password.blank?
        #     redirect to "/signup"
        # else
        #     redirect to "/users/index"
        # end
    end
end