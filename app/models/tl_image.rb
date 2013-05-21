class TlImage < FeedItem
  validates_length_of :content, :maximum => 256
  validates_presence_of :photo

  def self.create_from_form(input)
    create(
      data: input,
      api_created_at: DateTime.now
    )
  end

  def valid_attrs
    %w[content]
  end
end
