get '/' do
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

post '/log_in' do
  user = User.find_by(email: params[:user][:email])
  redirect '/?error=user_not_found' unless user
  redirect '/?error=password_not_correct' unless user.authenticate?(params[:user][:password])
  session[:user_id] = user.id
  redirect "/users/#{user.id}"
end

post '/sign_up' do
  user = User.new(params[:new_user])
  return [500, "Wasn't able to sign up, try again."] unless user && user.save
  session[:user_id] = user.id
  redirect "/users/#{user.id}"
end

post '/log_out' do
  session[:user_id] = nil
  redirect '/'
end
