class FeedItem < ActiveRecord::Base

  serialize :data, ActiveRecord::Coders::Hstore
  attr_accessible :data, :feed_item_points_count, :user_id, :photo, :api_created_at
  has_attached_file :photo,
                    :styles => {:small => "340x490"}


  belongs_to :user

  def method_missing(method, *args)
    if valid_attrs.include?(method.to_s) && method.to_s.include?('=')
      self.data[method.to_s] = args.first
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
      item.photo = input["photo"]
    end
  end
end
