class HomeController < ApplicationController

  def show
    @global_feed = FeedItem.all
  end

end
