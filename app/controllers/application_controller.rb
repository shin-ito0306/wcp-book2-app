class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "ログイン成功"
      user_path(current_user.id)
    else
      flash[:notice] = "新規登録"
      user_path(current_user.id)
    end
  end

  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
