class Question < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :survey
  has_many :choices

  validates :question, presence: true
  validates :survey_id, presence: true
end
