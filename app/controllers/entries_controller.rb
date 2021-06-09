class EntriesController < ApplicationController
    get '/:username/entries' do

        @user = User.find_by_username(params[:username])
        # binding.pry
        # if logged_in?
        if current_user == @user
        # if current_user.authenticate(params[:username])
            # binding.pry
            # @entries = Entry.all
            @entries = Entry.all.select {|entry| entry.user_id == current_user.id }
            # binding.pry
            erb :'/entry/index'
        # elsif logged_in?
        #     redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/new' do
        # if current_user.authenticate(params[:username])
        if logged_in?
            erb :'/entry/new'
        # elsif logged_in?
        #     redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    post '/:username/entries' do
        if logged_in?
            @entry = Entry.create(date: params[:date], title: params[:title], the_entry: params[:the_entry], mood: params[:mood], food: params[:food], gratitude: params[:gratitude])
            @entry.user_id = current_user.id
            @entry.save
            redirect to "/#{current_user.username}/entries/#{@entry.id}"
        # elsif logged_in?
        #     redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id' do
        # if current_user.authenticate(params[:username])
        if logged_in?
            @entry = Entry.find(params[:id])
            erb :'/entry/show'
        # elsif logged_in?
        #     redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id/edit' do
        if logged_in?
                @entry = Entry.find(params[:id])
            erb :'/entry/edit'
        else
            redirect to "/login"
        end
    end

    patch '/:username/entries/:id' do
        # if current_user.authenticate(params[:username])
        if logged_in?
            @entry = Entry.find(params[:id])
            @entry.update(params[:entry])
            @entry.the_entry = params[:the_entry]
            @entry.save
            redirect to "/#{current_user.username}/entries/#{@entry.id}"
        # elsif logged_in?
        #     redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    delete '/:username/entries/:id' do
        # if current_user.authenticate(params[:username])
        if logged_in?
            @entry.destroy
            redirect to "/#{current_user.username}/entries"
        # elsif logged_in?
        #     redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

end