class User < ActiveRecord::Base
  has_many :surveys
  has_many :completions

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
