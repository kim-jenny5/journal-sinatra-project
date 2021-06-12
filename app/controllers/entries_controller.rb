class EntriesController < ApplicationController
    get '/:username/entries' do
        @user = User.find_by_username(params[:username])
        if current_user == @user
            @entries = Entry.all.select {|entry| entry.user_id == current_user.id }
            erb :'/entry/index'
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/new' do
        if logged_in?
            @user = User.find_by_username(params[:username])
            if current_user == @user
                erb :'/entry/new'
            else
                flash[:no_access] = "You don't have access to this user's entries."
                redirect to "/#{current_user.username}"
            end
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
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id' do
        if logged_in?
            @entry = Entry.find(params[:id])
            @user = User.find_by_username(params[:username])
            if @entry.user == current_user
                erb :'/entry/show'
            else
                flash[:no_access] = "You don't have access to this user's entries."
                redirect to "/#{current_user.username}"
            end
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id/edit' do
        if logged_in?
            @entry = Entry.find(params[:id])
            @user = User.find_by_username(params[:username])
            if @entry.user == current_user
                erb :'/entry/edit'
            else
                flash[:no_access] = "You don't have access to this user's entries."
                redirect to "/#{current_user.username}"
            end
        else
            redirect to "/login"
        end
    end

    patch '/:username/entries/:id' do
        if logged_in?
            @entry = Entry.find(params[:id])
            if @entry.user == current_user
                @entry.update(params[:entry])
                @entry.the_entry = params[:the_entry]
                @entry.save
                redirect to "/#{current_user.username}/entries/#{@entry.id}"
            else
                redirect to "/login"
            end
        else
            redirect to "/login"
        end
    end

    delete '/:username/entries/:id' do
        if logged_in?
            @entry = Entry.find_by_id(params[:id])
            if @entry.user == current_user
                @entry.destroy
                redirect to "/#{current_user.username}/entries"
            else
                redirect to "/login"
            end
        else
            redirect to "/login"
        end
    end

end