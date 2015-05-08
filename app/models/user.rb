class User < ActiveRecord::Base
  belongs_to :user
  has_many :completions
  has_many :questions

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
