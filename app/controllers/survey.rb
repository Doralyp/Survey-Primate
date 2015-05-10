get '/surveys/create' do
  must_be_logged_in
  erb :"surveys/new", locals: {user: current_user}
end

post '/surveys/create' do
  must_be_logged_in
  user = User.find(current_user.id)
  survey = Survey.new(params[:new_survey])
  survey.user = user
  if !!params[:thefile]
    url = process_image(params[:thefile][:filename], params[:thefile][:tempfile].read)
    survey.picture_url = url
  end
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
  if Survey.add_question_to_survey(params[:new_question], params[:new_choice], survey_id)
    redirect "/surveys/#{survey_id}/create_questions"
  end
  redirect '/?error=not_valid_input'
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
  Completion.create(survey_id: survey_id, user_id: current_user.id, completed: true)
  if survey
    redirect "/surveys/#{survey_id}"
  end
  redirect '/'
end

get '/surveys/:id/invite_user' do |id|
  users = User.all
  survey = Survey.find(id)
  completions = Completion.where(survey: survey)
  erb :"surveys/invite_user", locals: {users: users, survey: survey, completions: completions}
end

post '/surveys/:id/invite_user/:id' do |survey_id, user_id|
  user = User.find(user_id)
  survey = Survey.find(survey_id)
  completion = Completion.new(user_id: user_id, survey_id: survey_id)
  return [500, "Couldn't add this user to the survey"] unless completion.save
  redirect back
end

get '/surveys/:id' do |survey_id|
  must_be_invited(survey_id)
  current_survey = Survey.find(survey_id)
  redirect "/surveys/#{survey_id}/summary" if current_survey.completed_by?(current_user)
  erb :"surveys/show", locals: {survey: current_survey}
end

post '/surveys/:id/fill_out' do |survey_id|
  completion = Completion.find_by(survey_id: survey_id, user_id: current_user.id)
  total_questions = Survey.find(survey_id).questions.count
  params[:choice].each do |question_id, choice_id|
    answer = Answer.new
    answer.completion = completion
    answer.choice = Choice.find(choice_id)
    answer.save
  end
  total_answers = completion.answers.count
  if total_questions <= total_answers
    completion.completed = true
    completion.save
    redirect "/surveys/#{survey_id}/summary"
  else
    redirect "?error=unanswered_questions"
  end
end

get '/surveys/:id/summary' do |survey_id|
  survey = Survey.find(params[:id])
  completion = Completion.find_by(survey_id: survey.id, user_id: current_user.id)
  redirect '/?error=unauthorized_user' unless completion
  erb :"surveys/show_summary", locals: {survey: survey, completion: completion}
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
  survey = Survey.find(survey_id)
  if request.xhr?
    return survey.questions_choices_array.to_json
  end
  erb :"surveys/results", locals: {survey: survey}
end