get '/surveys/create' do
  must_be_logged_in
  erb :"surveys/show", locals: {user: current_user}
end

post '/surveys/create' do
  user = User.find(params[:user][:user_id])
  survey = Survey.create(params[:new_survey])
  invited_users = []
  params[:invited_users].each {|user_id| invited_users << User.find(user_id)}
  redirect "/surveys/#{id}"
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