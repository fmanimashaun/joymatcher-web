class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :redirect_if_authenticated, only: [:index]

  def index
    @page_title = "Welcome to Joymatcher!" 
  end

  private

  def redirect_if_authenticated
    if user_signed_in?
      # Redirect authenticated users to the dashboard or another page
      redirect_to dashboard_path # Replace with your desired path
    end
  end
end
