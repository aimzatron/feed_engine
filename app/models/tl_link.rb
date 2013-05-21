class TlLink < FeedItem
  validates_presence_of :content, :message => "Your submission can't be empty"
  validates_presence_of :link, :message => "Where is your link?"
  LINK_REGEX = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :link, :with => LINK_REGEX, :message => "Please enter a link in the format of www.example.com"
  validates_length_of :content, :maximum => 256


  def self.create_from_form(input)
    create(
      data: input,
      api_created_at: DateTime.now
    )
  end

  def valid_attrs
    %w[content link]
  end
end
