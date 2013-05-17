class TlText < FeedItem
  validates_presence_of :content, :message => "Your submission can't be empty"
  validates_length_of :content, :maximum => 512

  #def self.update_twitter_feed_items
  #  User.all.each do |user|
  #    auth = user.authorizations.where(:service_provider => "twitter").first
  #    twitter = Twitter::Client.new(oauth_token: auth.token, oauth_token_secret: auth.secret)
  #    twitter.get_latest_tweet
  #    FeedItem.create(type: 'TwitterFeedItem', data: twitter_data)
  #  end
  #end

  def self.create_from_form(input)
    create do |tl_text|
      tl_text.data["content"] = input["content"]
    end
  end

  def valid_attrs
    %w[content]
  end
end
