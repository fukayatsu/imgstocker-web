class User < ActiveRecord::Base
  devise :trackable, :omniauthable

  has_many :icons

  class << self
    def find_for_twitter_oauth(auth)
      user = find_by(provider: auth[:provider], uid: auth[:uid])
      return user if user.present?

      create!(
        provider: auth[:provider],
        uid:      auth[:uid],
        name:     auth[:info][:name],
        token:    auth[:credentials][:token],
        secret:   auth[:credentials][:secret],
      )
    end
  end
end
