class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about]

  # 下のdef after_sign_in_path_for(resource)は
  # deviseでログイン先をマイページ(userのshow)に指定してある。
  # current_userはdeviseが用意してある。
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:name])
  end

end
