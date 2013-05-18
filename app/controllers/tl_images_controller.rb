class TlImagesController < ApplicationController

  def create
    @tl_image = current_user.tl_images.create(params[:tl_image])
    if @tl_image.save
      redirect_to :back, notice: "Successfully added item to feed"
    else
      redirect_to :back, notice: "Sorry pal"
    end
  end
end
