class TlText < FeedItem
  validates_presence_of :content, :message => "Your submission can't be empty"
  validates_length_of :content, :maximum => 512, :message => "Your message must not exceed 512 characters"

  def self.create_from_form(input)
    date = DateTime.now.to_s
    create(
      api_created_at: date,
      data: input
    )
  end

  def valid_attrs
    %w[content]
  end
end
