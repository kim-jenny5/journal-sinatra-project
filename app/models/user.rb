class User < ActiveRecord::Base
   has_many :entries
   validates :name, :password, presence: true
   validates :username, presence: true, uniqueness: true
   has_secure_password
end