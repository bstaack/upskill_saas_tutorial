class Contact < ActiveRecord::Base
  # contact form vailidations
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
end