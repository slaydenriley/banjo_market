class Users < ActiveRecord::Base
  has_secure_password
  has_many :banjos

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Users.all.find{|user| user.slug == slug}
  end
end
