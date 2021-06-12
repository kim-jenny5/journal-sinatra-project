# My Daily Journal: keep track of your daily thoughts and wellness!

## Usage
Clone this repository and `bundle` or `bundle install` to install the gems. Add data if you'd like into the `seeds.rb` file and run `rake db:migrate` as well as `rake db:seed` to migrate the tables and seed your data.
To preview locally in your browser, run `shotgun` and go to `localhost:9393` on your browser.

## Description
This app has also been deployed on Heroku. Please [click here](https://mydailyjournal-byjenny.herokuapp.com/) to view it.

This app was a project for Flatiron School. It uses Sinatra, ActiveRecord, CRUD functions, and MVC framework.

The user can signup/login and create entries, with all fields required besides the title. The user can view all their entries, and only their entries, on their page as well as edit or delete previously made entries.