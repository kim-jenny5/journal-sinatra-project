class Entry < ActiveRecord::Base
    belongs_to :user

    # validates :title, :the_entry, :date, presence: true
end