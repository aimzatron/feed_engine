class UsersController < ApplicationController

  def show
    @user = User.find_by_subdomain!(request.subdomain)
    @feeds = current_user.feed_items.order('created_at DESC')
    @tl_text = TlText.new
  end

end
