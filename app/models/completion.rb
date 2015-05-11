class Completion < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :answers

  validates :user_id, presence: true
  validates :survey_id, presence: true

end
