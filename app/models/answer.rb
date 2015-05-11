class Answer < ActiveRecord::Base
  belongs_to :completion
  belongs_to :choice

  validates :completion_id, presence: true
  validates :choice_id, presence: true

  def self.save_answer choice, completion
    choice.each do |question_id, choice_id|
      answer = Answer.new
      answer.completion = completion
      answer.choice = Choice.find(choice_id)
      answer.save
    end
  end

  def self.total completion
    completion.answers.count
  end

end
