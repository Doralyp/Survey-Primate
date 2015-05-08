def current_user
  if session[:user_id]
    return User.find(session[:user_id])
  else
    return nil
  end
end

def must_be_logged_in
  redirect '/' unless current_user
end
