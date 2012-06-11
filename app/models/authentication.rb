class Authentication < ActiveRecord::Base
  belongs_to :users
  
  attr_accessible :provider, :uid, :user_id
end
