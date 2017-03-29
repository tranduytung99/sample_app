class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  
  def logger_in_used
    unless logged_in?
      store_location
      flash[:danger] = t ".login"
      redirect_to login_url
    end
  end

end
