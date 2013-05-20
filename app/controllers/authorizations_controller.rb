class AuthorizationsController < ApplicationController

  def create
    user = current_user
    lfm = Lastfm.new(ENV["LASTFM_CONSUMER_KEY"], ENV["LASTFM_CONSUMER_SECRET"])
    lfm.session = lfm.auth.get_session(:token => params["token"])['key']
    lastfm_auth = user.lastfm_auths.new(token: lfm.session)

    # NOTES:
    # establish last_fm object
    # last_fm = Lastfm.new(ENV["LASTFM_CONSUMER_KEY"], ENV["LASTFM_CONSUMER_SECRET"])

    # assign a user
    # user = User.first

    #Assign the token(actually session)
    # token = user.lastfm_auths.first.token

    #Add token to last_fm oject
    # last_fm.session = token

    # now enter commands
    # last_fm.track.scrobble(:artist => 'Hujiko Pro', :track => 'acid acid 7riddim')

    if lastfm_auth.save
      redirect_to root_path
    else
      redirect_to user_path(user), :message => "Sorry, unable to connect"
    end
  end
end