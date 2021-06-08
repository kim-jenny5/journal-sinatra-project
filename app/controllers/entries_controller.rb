class EntriesController < ApplicationController
    get '/:username/entries' do
        if current_user.authenticate(params[:username])
            @entries = Entry.all
            erb :'/entry/index'
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/new' do
        if current_user.authenticate(params[:username])
            erb :'/entry/new'
        else
            redirect to "/login"
        end
    end

    post '/:username/entries' do
        if current_user.authenticate(params[:username])
            @entry = Entry.create(date: params[:date], title: params[:title], the_entry: params[:the_entry], mood: params[:mood], food: params[:food], gratitude: params[:gratitude])
            @entry.user = current_user
            @entry.save
            redirect to "/#{current_user.username}/entries/#{@entry.id}"
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id' do
        if current_user.authenticate(params[:username])
            @entry = Entry.find(params[:id])
            erb :'/entry/show'
        else
            redirect to "/login"
        end
    end

    get '/:username/entries/:id/edit' do
        if current_user.authenticate(params[:username])
            @entry = Entry.find(params[:id])
            erb :'/entry/edit'
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
        else
            redirect to "/login"
        end
    end

    delete '/:username/entries' do
        if current_user.authenticate(params[:username])
            @entry = Entry.find()
        else
            redirect to "/login"
        end
    end

end