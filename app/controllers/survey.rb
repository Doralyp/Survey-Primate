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
  current_survey = Survey.find(survey_id)
  question_ids = []
  current_survey.questions.each do |question|
    question_ids << question.id
  end

  user = current_user
  current_survey
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