class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :bio, :timezone
  # if a temporary_password is provided, a random password will be generated
  # this random password will be sent to the welcome email, so we can notify the user of it
  attr_accessor :temporary_password  
  
  # Associations
  has_many :authentications
  
  
  
  
  # User profile helpers
  # ----------------------------------------------------------------------------------------------------
  
  # Get a user's full name
  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end
  
  # Return the abbreviated name, e.g. John K.
  def abbreviated_name
    "#{self.first_name.capitalize} #{self.last_name.first.capitalize}."
  end
  
  
  
  
  # OAUTH Helpers
  # ----------------------------------------------------------------------------------------------------
  
  # Get Facebook authentication for user
  def facebook
    self.authentications.find_by_user_id_and_provider(self.id, "facebook")
  end
  # Get Twitter authentication for user
  def twitter
    self.authentications.find_by_user_id_and_provider(self.id, "twitter")
  end
  # Get Google authentication for user
  def google
    self.authentications.find_by_user_id_and_provider(self.id, "google_oauth2")
  end
  
  # OAUTH Helper: Check if a authentication and/or user exists or create them
  def self.find_or_create_for_oauth data, signed_in_resource=nil
    puts "============================================================================"
    puts "data:: #{data}"
    puts "provider:: #{data.provider}"
    #puts "provider:: #{data.extra.raw_info.email}"
    puts "============================================================================"
    # Facebook returns all of the profile information within extra.raw_info, let's
    # store all of that in a profile variable
    profile = data.extra.raw_info    
    # Let check if an authentication record exist based on the uid and provider
    authentication = Authentication.where(uid: data.uid, provider: data.provider).first
    user_from_authentication = authentication ? authentication.user : nil
    # Let's find the user based on the signed_in_resource (current session); if that doesn't
    # work let's check the user_from_authentication; if still nothing, let's find a user based
    # on the email provided from the callback data
    user = signed_in_resource || user_from_authentication || User.where("email = ? AND email IS NOT NULL", profile.email).first    
    # Check if user is exists
    if user
      # If the authenticating person has a user account then let's return their user object
      if user_from_authentication
        user_from_authentication
      else
        # If a use rexists but has no authentication, let's create an authentication record
        # and return it
        user.authentications.create!(uid: data.uid,
          provider: data.provider, 
          token: data.credentials.token,
          token_secret: data.credentials.secret,
        )
        user
      end
    else
      # If a user does not exist than let's create an authentication and user
      case data.provider.downcase
      when "twitter"
        # If the user is using Twitter
        # Twitter users only have one field for name, let's try to hack something together
        nameparts = profile.name.split(" ")
        if nameparts.count > 1
          profile.first_name = nameparts.first
          profile.last_name = nameparts.last
        else
          profile.first_name = profile.name
          profile.last_name = ''
        end
        # Twitter does not provide an email, let's make one up
        profile.email = "#{profile.screen_name}@grazr.com"
        # Timezone
        timezone = profile.utc_offset.to_i
        timezone = timezone  / 60 / 60
      when "facebook"
        timezone = profile.timezone.to_i
      when "google_oauth2"
        timezone = nil
      end
      # Now let's create the user object, the image, authentication and save them all up!
      user = User.create!(email: profile.email,
        first_name: profile.first_name,
        last_name: profile.last_name,
        timezone: timezone,
        password: Devise.friendly_token[0,20]
      )
      #user.image = Image.create(:url => profile.image, :carrierwave => false)
      user.authentications.create!(uid: data.uid,
        provider: data.provider, 
        token: data.credentials.token,
        token_secret: data.credentials.secret,
      )
      user.save()
      user
    end
  end
  
  
  
  
  # API Attributes and helpers
  # ----------------------------------------------------------------------------------------------------
  
  # API Attributes for a user
  def api_attributes
    {
      :id => self.id.to_s,
      :first_name => self.first_name.to_s,
      :last_name => self.last_name.to_s,
      :email => self.email.to_s,
      :bio => self.bio.to_s
    }
  end
  
  
end