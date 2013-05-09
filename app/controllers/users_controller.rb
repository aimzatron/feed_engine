class UsersController < ApplicationController

  def show
    @user = User.find_by_subdomain!(request.subdomain)
  end

end
