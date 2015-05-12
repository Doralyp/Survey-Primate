class Completion < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :answers

  validates :user_id, presence: true
  validates :survey_id, presence: true

  def choice_array
    answers.map { |ans| ans.choice.choice }
  end

  def choice_by_question(question)
    answers.find { |answer| answer.choice.question == question }.choice.choice
  end
end
