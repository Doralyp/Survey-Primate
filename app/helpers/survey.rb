def match_question_answer(completion, question)
  question.choices.each do |choice|
    return choice if completion.answers.exists?(choice_id: choice.id)
  end
  nil
end