class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about]


  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_up_for(resource)
    user_path(current_user.id)
  end





  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
