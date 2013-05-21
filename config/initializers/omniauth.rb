OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
  provider :lastfm, ENV["LASTFM_CONSUMER_KEY"], ENV["LASTFM_CONSUMER_SECRET"]
  provider :soundcloud, ENV["SOUNDCLOUD_CONSUMER_KEY"], ENV["SOUNDCLOUD_CONSUMER_SECRET"]
end
