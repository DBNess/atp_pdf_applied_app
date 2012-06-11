class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :token_authenticatable,
         :omniauthable
         
  has_many :authentications       

  accepts_nested_attributes_for :authentications

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :authentications_attributes

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.includes(:authentications).merge(Authentication.where(:provider => auth.provider, :uid => auth.uid)).first
    unless user
      user = User.create( name:auth.extra.raw_info.name,
                          password:Devise.friendly_token[0,20]
                        )
      user.authentications.create(provider:auth.provider, uid:auth.uid)
    end
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] # && session["devise.twitter_data"]["extra"]["raw_info"]
        #TODO: add data we want from twitter
      end
    end
  end
  
end
