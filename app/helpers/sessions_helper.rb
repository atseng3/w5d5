module SessionsHelper

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def log_in
    session[:session_token] = @user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
