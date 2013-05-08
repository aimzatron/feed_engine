OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'DkOkGk45mZXju35soiMmw', 'vkUeufA5lEmWH7pfZGyjg0uPrbPCu93rIKl54pT1bs'
end
