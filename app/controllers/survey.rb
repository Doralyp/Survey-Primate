get '/surveys/create' do
  must_be_logged_in
  erb :"surveys/new", locals: {user: current_user}
end

post '/surveys/create' do
  user = User.find(current_user.id)
  survey = Survey.new(params[:new_survey])
  survey.user = user
  if survey && survey.save
    redirect "/surveys/#{survey.id}/create_questions"
  else
    redirect back
  end
end

get '/surveys/:id/create_questions' do |survey_id|
  survey = Survey.find(survey_id)
  erb :"/surveys/new_questions", locals: {survey: survey, user: current_user}
end

post '/surveys/:id/create_questions' do |survey_id|
  survey = Survey.find(survey_id) # NEEDS TO BE REFACTORED - aceburgess
  new_question = Question.new(params[:new_question])
  new_question.survey = survey
  new_question.save
  new_choices = params[:new_choice].values.map do |input|
    if !!input
      new_choice = Choice.new(choice: input)
      new_choice.question = new_question
      new_choice.save
    end
  end
  if new_question.choices.first
    redirect "/surveys/#{survey_id}/create_questions"
  end
  redirect '/'
end

post '/surveys/:id/finalize_survey' do |survey_id|
  survey = Survey.find(survey_id) # NEEDS TO BE REFACTORED - aceburgess
  if params[:new_question]
    new_question = Question.new(params[:new_question])
    new_question.survey = survey
    new_question.save
    new_choices = params[:new_choice].values.map do |input|
      if !!input
        new_choice = Choice.new(choice: input)
        new_choice.question = new_question
        new_choice.save
      end
    end
  end
  if survey
    redirect "/surveys/#{survey_id}"
  end
  redirect '/'
end

get '/surveys/invite_user' do
  erb :"surveys/invite_user"
end

post '/surveys/invite_user' do
end

get '/surveys/:id' do |survey_id|
  current_survey = Survey.find(survey_id)
  erb :"surveys/show", locals: {survey: current_survey}
end

post '/surveys/:id/fill_out' do |survey_id|
  completion = Completion.where(survey_id: survey_id, user_id: current_user.id)
  total_questions = Survey.find(survey_id).questions.count
  params[:choice].each do |choice_text, choice_id|
    answer = Answer.new
    answer.completion = completion
    answer.choice = Choice.find(choice_id)
    answer.save
  end
  p completion
  total_answers = completion.answers.count
  if total_questions == total_answers
    redirect "/surveys/#{:id}/summary"
  else
    redirect "?error=unanswered_questions"
  end
end

get '/surveys/:id/summary' do |survey_id|
  erb :"surveys/show_summary"
end

delete '/surveys/:id/delete' do |survey_id|
  redirect "/users/#{user.id}"
end

get '/surveys/:id/edit' do |survey_id|
  survey = Survey.find(survey_id)
  erb :"/surveys/edit" , locals: {survey: survey}
end

put '/surveys/:id/edit' do |survey_id|
  redirect "/surveys/#{survey.id}"
end

get '/surveys/:id/results' do |survey_id|
  erb :"surveys/results"
end