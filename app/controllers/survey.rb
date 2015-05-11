get '/surveys/create' do
  must_be_logged_in
  erb :"surveys/new", locals: {user: current_user}
end

post '/surveys/create' do
  must_be_logged_in
  survey = Survey.new(params[:new_survey])
  survey.user = current_user
  upload_image params[:thefile], survey if !!params[:thefile]
  redirect "/surveys/#{survey.id}/create_questions" if survey && survey.save
  redirect back
end

get '/surveys/:id/create_questions' do |survey_id|
  survey = Survey.find(survey_id)
  erb :"/surveys/new_questions", locals: {survey: survey, user: current_user}
end

post '/surveys/:id/create_questions' do |survey_id|
  survey = Survey.find(survey_id)
  added = Survey.add_question_to_survey(params[:new_question], params[:new_choice], survey_id)
  case
  when !added then '?error=not_valid_input'
  when request.xhr? && params[:finalize] then ajax_finalize(survey)
  when request.xhr? && params[:create] then ajax_question(survey)
  when params[:finalize] then basic_finalize(survey)
  else redirect "/surveys/#{survey_id}/create_questions"
  end
end

get '/surveys/:id/invite_user' do |survey_id|
  users = User.all
  survey = Survey.find(survey_id)
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
  Answer.save_answer params[:choice], completion
  if Question.total(survey_id) <= Answer.total(completion)
    completion.completed = true
    completion.save
    redirect "/surveys/#{survey_id}/summary"
  else
    redirect "?error=unanswered_questions"
  end
end

get '/surveys/:id/summary' do |survey_id|
  survey = Survey.find(params[:id])
  return survey.questions_choices_array.to_json if request.xhr?
  completion = Completion.find_by(survey_id: survey.id, user_id: current_user.id)
  redirect '/?error=unauthorized_user' unless completion
  erb :"surveys/show_summary", locals: {survey: survey, completion: completion}
end

get '/surveys/:id/comparison/:c_id' do
  survey = Survey.find(params[:id])
  completion = Completion.find(params[:c_id])
  return [survey.questions_choices_array, completion.choice_array].to_json if request.xhr?
  redirect '/'
end

get '/surveys/:id/edit' do |survey_id|
  survey = Survey.find(survey_id)
  erb :"/surveys/edit" , locals: {survey: survey}
end

put '/surveys/:id/edit' do |survey_id|
  redirect "/surveys/#{survey.id}"
end

get '/surveys/:id/delete' do |survey_id|
  survey = Survey.find(survey_id)
  erb :"/surveys/delete" , locals: {survey: survey}
end

delete '/surveys/:id/delete' do |survey_id|
  survey = Survey.find(survey_id)
  return [500, "Survey no longer exists."] unless survey
  survey.destroy if survey.user_id == current_user.id
  redirect "/"
end

get '/surveys/:id/results' do |survey_id|
  survey = Survey.find(survey_id)
  return survey.questions_choices_array.to_json if request.xhr?
  erb :"surveys/results", locals: {survey: survey}
end