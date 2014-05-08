class Api::UsersController < APIController
  before_action :set_user, only: [:update]

  def update
    return head(:bad_request) unless @user

    icon      = @user.icons.find_by(name: params[:icon])
    return head(:bad_request) unless icon

    client    = twitter_client(@user)
    client.update_profile_image(Base64.encode64(icon.content))

  rescue Twitter::Error::TooManyRequests => e
    head(:bad_request) # FIXME
  end

  private
  def set_user
    @user = User.find_by(uid: params[:id])
  end
end
