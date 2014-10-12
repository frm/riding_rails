class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w\-.]+@[a-z\-\d]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, :name, :username, presence: true, length: {maximum: 50}
  validates :email, format: EMAIL_REGEX, uniqueness: {case_sensitive: false}
  validates :username, uniqueness: {case_sensitive: false}
end
