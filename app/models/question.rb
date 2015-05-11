class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices

  validates :question, presence: true
  validates :survey_id, presence: true

  def choices_array
    choices.map { |c| [c.choice, Answer.where(choice_id: c.id).count] }
  end

  def self.total survey_id
    Survey.find(survey_id).questions.count
  end
end
