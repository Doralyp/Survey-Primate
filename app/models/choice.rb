class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :completion_choices
  has_many :completions, through: completion_choices

  validates :choice, presence: true
  validates :question_id, presence: true
end
