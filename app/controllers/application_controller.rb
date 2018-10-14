class ApplicationController < ActionController::Base
  helper ApplicationHelper

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def ajax_redirect_to(url, msg)
    head 202, { x_ajax_redirect_url: url, x_ajax_message: msg }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
