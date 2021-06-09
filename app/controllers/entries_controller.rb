class EntriesController < ApplicationController
    get '/:username/entries' do

        # binding.pry
        # if logged_in?
        if current_user.authenticate(params[:username])
            @entries = Entry.all
            # binding.pry
            erb :'/entry/index'
        elsif logged_in?
            redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/new' do
        if current_user.authenticate(params[:username])
            erb :'/entry/new'
        elsif logged_in?
            redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    post '/:username/entries' do
        if current_user.authenticate(params[:username])
            @entry = Entry.create(date: params[:date], title: params[:title], the_entry: params[:the_entry], mood: params[:mood], food: params[:food], gratitude: params[:gratitude])
            @entry.save
            redirect to "/#{current_user.username}/entries/#{@entry.id}"
        elsif logged_in?
            redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id' do
        if current_user.authenticate(params[:username])
            @entry = Entry.find(params[:id])
            erb :'/entry/show'
        elsif logged_in?
            redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id/edit' do
        if current_user.authenticate(params[:username])
            @entry = Entry.find(params[:id])
            erb :'/entry/edit'
        elsif logged_in?
            redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    patch '/:username/entries/:id' do
        if current_user.authenticate(params[:username])
            @entry = Entry.find(params[:id])
            @entry.update(params[:entry])
            @entry.the_entry = params[:the_entry]
            @entry.save
            redirect to "/#{current_user.username}/entries/#{@entry.id}"
        elsif logged_in?
            redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

    delete '/:username/entries/:id' do
        if current_user.authenticate(params[:username])
            @entry = Entry.find(params[:id])
            @entry.destroy
            redirect to "/#{current_user.username}/entries"
        elsif logged_in?
            redirect to "/#{current_user.username}"
        else
            redirect to "/login"
        end
    end

end