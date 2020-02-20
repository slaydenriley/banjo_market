class Users < ActiveRecord::Base
  has_many :banjos, dependent: :destroy
  has_secure_password
end
