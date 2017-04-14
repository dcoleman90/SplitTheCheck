class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: Devise::email_regexp
  has_secure_password
end
