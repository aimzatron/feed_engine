class FeedItem < ActiveRecord::Base

  serialize :data, ActiveRecord::Coders::Hstore
  attr_accessible :data, :feed_item_points_count, :user_id
  belongs_to :user

  def method_missing(method, *args, &block)
    if valid_attrs.include?(method.to_s) && method.to_s.include?('=')
      self.data[method] = args.first
    elsif valid_attrs.include?(method.to_s)
      data && data[method.to_s]
    else
      super
    end
  end

  def valid_attrs
    []
  end

  def self.create_from_tuneline(input, user)
    create! do |item|
      item.user_id = user.id
      input.each do |key, value|
        item.data[key] = value
      end
    end
  end
end

  #(SHARED_ATTRS).each do |key|
  #  attr_accessible key
  #  scope "has_#{key}", lambda { |value| where("data @> hstore(?, ?)", key, value) }

  #  define_method(key) do
  #    data && data[key]
  #  end

  #  define_method("#{key}=") do |value|
  #    self.data["#{key}"] = value
  #  end
  #end

  #class FeedUpdater
  #  def for_all_users(type)
  #    User.all.each do |user|

  #      yield user
  #      FeedItem.create(type: t
  #    end
  #  end
  #end

  #class TwitterFeedUpdater < FeedUpdater
  #  def update
  #    for_all_users(:twitter) do |user|
  #      get atuh and get latest stuff
  #    end
  #  end
  #end

  #class UpdateWorker
  #  include Sidekiq::Worker

  #  def execute
  #    TwitterFeedUpdater.new.update
  #    LastFMFeedUpader.new.update
  #  end
  #end

  #def self.update_from_lastfm
  #  loop over all users
  #    grab the auth for last fm
  #    get the last fm scrobbles
  #    create new feed item for scrobbles
  #end

  #def self.create_from_tuneline(input, user)
  #  create! do |item|
  #    item.data["type"] = self.type(input)
  #    item.user_id = user.id
  #    input.each do |key, value|
  #      item.data[key] = value
  #    end
  #  end
  #end

  #def self.type(input)
  #  input.each do |key, value|
  #    return key if VALID_DATA_ATTRIBUTES.find(key)
  #  end
  #end

  #def self.method_missing(...)
  #  if method contains scope_
  #    where(...)
  #  else
  #    super
  #  end
  #end

  #def method_missing(method, *args, &block)
  #  if (VALID + MY_ATTRS).include?(method) method.to_s.include?('=')
  #    self.data[method] = args.first
  #  elsif method is in valid or my attrs
  #    data && data[key]
  #  else
  #    super
  #  end
  #end

  #def respond_to_missing?(method, * args, &block)

  #end