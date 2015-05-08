get '/users/:id' do
  user = User.find(params[:id])
  erb :'users/show', locals: {user: user}
end

put '/users/:id' do
  user = User.find(params[:id])
  user.assign_attributes(params[:user])
  [500, "Something went horribly wrong"] unless user.save

  redirect "/users/#{params[:id]}"
end

delete '/users/:id' do
  redirect "/"
end

get '/users/:id/edit' do
  user = User.find(params[:id])
  erb :'users/edit', locals: {user: user}
end
