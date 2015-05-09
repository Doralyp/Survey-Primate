get '/users/:id' do
  user = User.find(params[:id])
  redirect '/?error=unauthorized_user' unless current_user == user
  pending_surveys = User.pending_surveys(current_user.id)
  completed_surveys =User.completed_surveys(current_user.id)
  erb :'users/show', locals: {user: user, pending_surveys: pending_surveys, completed_surveys: completed_surveys}
end

put '/users/:id' do
  user = User.find(params[:id])
  user.assign_attributes(params[:user])
  return [500, "Something went horribly wrong"] unless user.save
  redirect "/users/#{params[:id]}"
end

delete '/users/:id' do
  redirect "/"
end

get '/users/:id/edit' do
  erb :'users/edit'
end
