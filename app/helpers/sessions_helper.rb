module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  private

  def logged_in
    if logged_in?
      redirect_to root_path
    end
  end

  def not_logged_in
    unless logged_in?
      redirect_to new_session_path
    end
  end
end
