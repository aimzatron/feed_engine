class TlImage < FeedItem
  validates_length_of :content, :maximum => 256
  validates_presence_of :photo

  def self.create_from_form(input)
    create! do |tl_image|
      tl_image.data["content"] = input["content"]
    end
  end

  def valid_attrs
    %w[content]
  end
end
