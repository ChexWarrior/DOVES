class User < ActiveRecord::Base
include BCrypt
attr_accessor :password
EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
validates :password, :confirmation => true #password_confirmation attr
validates_length_of :password, :in => 6..20, :on => :create
validates :first_name, :presence => true
validates :last_name, :presence => true


before_save :encrypt_password
after_save :clear_password
def encrypt_password
if password.present?
	self.salt = BCrypt::Engine.generate_salt
	self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	end
end

def clear_password
	self.password=nil
end


end
