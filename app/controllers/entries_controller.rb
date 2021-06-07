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

end