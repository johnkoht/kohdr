class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter :authenticate_user!  
  
  #include SessionHelper
  #include CommonLinksHelper
  
  # After sign in, redirect them to the url they were originally going to
  def after_sign_in_path_for(resource)
    session[:user_return_to] || root_path
  end
  
  # After sign up, redirect them to the url they were originally going to
  def after_sign_up_path_for(resource)
    session[:user_return_to] || root_path
  end
  
  
  def index
  end
  
end