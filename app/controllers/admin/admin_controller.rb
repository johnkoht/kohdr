class Admin::AdminController < ActionController::Base
  
  protect_from_forgery
    
  layout 'admin'

  before_filter :authenticate_user!
  before_filter :require_admin!
  # Handles redirecting to original path
  before_filter :capture_path
  

  def index
  end
  

  # Session redirects and helpers
  # ------------------------------------------------------------------------------------------------------
  
  # Login redirects and create account redirects
  # Capture the URL
  def capture_path
    session[:return_to] = request.path if request.method == "GET" && !devise_controller? && !request.xhr? && action_name != 'redirect'
    @referer_url = request.env['HTTP_REFERER']
  end

  # After sign in, redirect them to the url they were originally going to
  def after_sign_in_path_for(resource)
    session[:user_return_to] || admin_pages_path
  end
  
  def after_sign_up_path_for(resource)
    session[:user_return_to] || root_path
  end
  
  
  
  private
    # used from a before filter, this method will block and redirect the user if they dont have admin access
    def require_admin!
      unless current_user.admin
        redirect_to root_path, :notice => 'You must be an admin to access this area'
      end
    end
    
end
  
  
 

  

