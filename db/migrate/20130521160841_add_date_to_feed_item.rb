class AddDateToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :api_created_at, :datetime
  end
end
