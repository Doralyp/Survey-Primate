class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  has_many :completions, through: :answers

  validates :choice, presence: true
  validates :question_id, presence: true
end
