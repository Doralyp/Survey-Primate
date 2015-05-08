class User < ActiveRecord::Base
  include BCrypt
  has_many :surveys
  has_many :completions

  validates :name, presence: true
  validates :email, presence: true
  # validates :password_hash, presence: true


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate?(text_password)
    self.password == text_password
  end

end
