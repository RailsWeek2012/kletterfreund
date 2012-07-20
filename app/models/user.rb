class User < ActiveRecord::Base
  has_secure_password
	has_many :comments
  attr_accessible :email, :password_digest, :password, :password_confirmation
end
