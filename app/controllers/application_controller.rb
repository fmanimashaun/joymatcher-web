class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # This ensure all paages can't be access without authentication except for the Devise controllers.
  before_action :authenticate_user!, unless: :devise_controller?
end
