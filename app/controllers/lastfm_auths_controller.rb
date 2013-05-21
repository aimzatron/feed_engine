class LastfmAuthsController < ApplicationController

  def create
    user = current_user
    lfm = Lastfm.new(ENV["LASTFM_CONSUMER_KEY"], ENV["LASTFM_CONSUMER_SECRET"])
    lfm.session = lfm.auth.get_session(:token => params["token"])['key']
    lastfm_auth = user.lastfm_auths.new(token: lfm.session)
    if lastfm_auth.save
      redirect_to root_path
    else
      redirect_to user_path(user), :message => "Sorry, unable to connect"
    end
  end
end
