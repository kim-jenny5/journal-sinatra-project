class User < ActiveRecord::Base
   has_many :entries
   validates :name, :username, :password, presence: true
   has_secure_password
end