class User < ActiveRecord::Base
  def self.create_from_omniauth(auth_hash)
    self.create(provider: auth_hash[:provider],
                uid: auth_hash[:uid],
                screen_name: auth_hash[:info][:nickname])
  end
end