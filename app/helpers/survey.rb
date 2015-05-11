def match_question_answer(completion, question)
  question.choices.each do |choice|
    return choice if completion.answers.exists?(choice_id: choice.id)
  end
  nil
end

def ajax_finalize survey
  completion = create_completion survey
  erb :"/surveys/show_summary", locals: {survey: survey, completion: completion}, layout: false
end

def ajax_question survey
  erb :"/surveys/new_questions", locals: {survey: survey, user: current_user}, layout: false
end

def basic_finalize survey
  create_completion survey
  redirect "/surveys/#{survey_id}"
end

def create_completion survey
  Completion.create(survey_id: survey.id, user_id: current_user.id, completed: true)
end
