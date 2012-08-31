class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model
    @user = User.find_or_create_for_oauth(request.env["omniauth.auth"], current_user)    
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user
      redirect_to root_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_path
    end
  end
  
  
  def twitter
    puts "twitter!!!"
    begin
      @user = User.find_or_create_for_oauth(request.env["omniauth.auth"], current_user)
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
        if current_user.nil?
          sign_in_and_redirect @user, :event => :authentication
        else
          redirect_to settings_path
        end
      else
        session["devise.twitter_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    rescue Exception => e
      render :text => "<html><body><pre>" + e.to_s + "</pre><hr /><pre>" + e.backtrace.join("\n") + "</pre></body></html>"
    end
    
  end
  
  
  def failure
    render :text => "something broke"
  end  
  
end