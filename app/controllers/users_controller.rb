class UsersController < ApplicationController

  def show
    @user = User.find_by_subdomain!(request.subdomain)
    @feeds = @user.feed_items.order('api_created_at DESC')
    @tl_text = TlText.new
    @tl_link = TlLink.new
    @tl_image = TlImage.new
  end

end
