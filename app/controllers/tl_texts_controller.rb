class TlTextsController < ApplicationController

  def create
    binding.pry
    @tl_text = current_user.tl_texts.create_from_form(params[:tl_text])
    if @tl_text.save
      redirect_to :back, notice: "Successfully added item to feed"
    else
      redirect_to :back, notice: "Sorry pal"
    end
  end
end
