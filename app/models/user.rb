class User < ActiveRecord::Base
  has_many :feed_items
  has_many :tl_texts
  has_many :tl_images
  has_many :tl_links
  has_many :tweets
  has_many :lastfm_top_tracks

  has_many :authorizations
  has_many :twitter_auths
  has_many :lastfm_auths

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    name = auth["info"]["nickname"]
    @user = create! do |user|
      user.uid = auth["uid"]
      user.name = name
      user.image_url = auth["info"]["image"]
      user.subdomain = name.downcase.gsub('_','-')
    end
    @user.twitter_auths.create_from_omniauth(auth["credentials"]["token"], auth["credentials"]["secret"], @user.id, "twitter")
    @user
  end

  def last_tweet_twitter_id
    if tweets.empty?
      return 0
    end
    sorted_tweets = tweets.sort_by { |tweet| tweet.twitter_id }
    sorted_tweets.last.twitter_id.to_i
  end

  def tuneline_mentions
    mentions = []

    twitter_tweets.each do |tweet|
      if tweet.text.downcase.include?("tuneline")
        mentions << tweet if tweet.id > last_tweet_twitter_id
      end
    end
    return mentions
  end

  def twitter_tweets
    twitter = TwitterAuth.connect(self)
    twitter.user_timeline(name)
  end

  def twitter_authorization
    twitter_auths.first
  end

  def create_from_mentions
    tuneline_mentions.each do |mention|
      tweets.create(data: {"text" => mention.text, "twitter_id" => mention.id})
    end
  end

end
