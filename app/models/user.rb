class User < ActiveRecord::Base
  has_secure_password
  belongs_to :userable, :polymorphic => true
  has_many :lends

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :fname, :lname, :password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
