class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?


private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birthday])
  end
end
