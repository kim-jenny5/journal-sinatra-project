class Entry < ActiveRecord::Base
    belongs_to :user

    validates :date, :the_entry, :mood, :food, :gratitude, presence: true
end