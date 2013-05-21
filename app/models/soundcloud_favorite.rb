class SoundcloudFavorite < FeedItem

  def self.update_all
    User.all.each do |user|
      unless user.soundcloud_auths.empty?
        update_favorites_for_user(user.id)
      end
    end
  end

  def self.update_favorites_for_user(user_id)
    user = User.find(user_id)

    token = user.soundcloud_auths.first.token

    client = Soundcloud.new(:access_token => token)
    favorites = client.get("/me/favorites")

    favorites.each do |favorite|
      song = favorite.permalink_url
      date = DateTime.strptime(favorite.created_at, '%Y/%m/%d %H:%M:%S')
      embed_info = client.get('/oembed', :url => song)

      user.soundcloud_favorites.create(
        data: {"html" => embed_info['html']},
        api_created_at: date
      )
    end
  end

  def valid_attrs
    %[html]
  end

end
