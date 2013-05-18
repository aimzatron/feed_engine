class AddPhotosToFeedItems < ActiveRecord::Migration
  def self.up
    add_attachment :feed_items, :photo
  end

  def self.down
    remove_attachment :feed_items, :photo
  end
end
