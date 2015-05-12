class Survey < ActiveRecord::Base
  belongs_to :user

  has_many :completions
  has_many :questions

  validates :title, presence: true

  def completed_by? user
    !!Completion.find_by(user_id: user.id, survey_id: self.id, completed: true)
  end

  def self.add_question_to_survey question, choices, survey_id
    survey = Survey.find(survey_id)
    new_question = Question.new(question)
    new_question.survey = survey
    new_question.save
    new_choices = choices.values.map do |input|
      if !!input
        new_choice = Choice.new(choice: input)
        new_choice.question = new_question
        new_choice.save
      end
    end
  end

  def questions_choices_hash
    questions.map { |q| {question: q.question, choices: q.choices_hash } }
  end

  def questions_choices_answers_hash(completion)
    questions.map { |q| {question: q.question, choices: q.choices_hash, answer: completion.choice_by_question(q) } }
  end
end
