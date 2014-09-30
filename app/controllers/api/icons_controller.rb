class Api::IconsController < APIController
  before_action :set_user, only: [:index, :create]

  def index
    return head(:bad_request) unless @user
    @icons = @user.icons
  end

  def create
    return head(:bad_request) unless @user
    client = twitter_client(@user)

    profile_image_url_https = client.user.profile_image_url_https
    image_url = profile_image_url_https.to_s.gsub('_normal', '')
    image     = MiniMagick::Image.open(image_url)

    @icon = Icon.find_or_create_by(user_id: @user.id, name: params[:name])
    @icon.update!(content: image.to_blob, original_filename: image_url)
  rescue Twitter::Error::TooManyRequests => e
    head(:bad_request) # FIXME
  end

  private
  def set_user
    @user = User.find_by(uid: params[:user_id])
  end
end
