class LastfmTopTrack < FeedItem

  def self.update_all
    User.all.each do |user|
      unless user.lastfm_auths.empty?
        update_top_tracks_for_user(user.id)
      end
    end
  end

  def valid_attrs
    %[artist name rank playcount image_url]
  end

  def self.update_top_tracks_for_user(user_id)
    user = User.find(user_id)

    lastfm = Lastfm.new(ENV["LASTFM_CONSUMER_KEY"], ENV["LASTFM_CONSUMER_SECRET"])
    token = user.lastfm_auths.first.token
    lastfm.session = token

    lastfm_username = lastfm.user.get_info["name"]

    top_tracks = lastfm.user.get_top_tracks(lastfm_username).first(7)
    date = DateTime.now

    top_tracks.each do |track|
      if track["image"]
        user.lastfm_top_tracks.create(
          api_created_at: date,
          data: {
            "artist"    => track["artist"]["name"],
            "name"      => track["name"],
            "rank"      => track["rank"],
            "playcount" => track["playcount"],
            "image_url" => track["image"][3]["content"]
          })
      end
      date -= 1
    end
  end

end
