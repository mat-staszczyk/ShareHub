class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    @current_user ||= begin
      devise_session_key = session['warden.user.user.key']
      devise_user = User.find(devise_session_key[0][0]) if devise_session_key
      devise_user || NullObjects::GuestUser.new
    end
  end

  def user_signed_in?
    current_user.is_a?(User)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name nickname])
  end
end
