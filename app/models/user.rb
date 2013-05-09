class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    name = auth["info"]["nickname"]
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]  
      user.name = name
      user.subdomain = name.downcase 
    end
  end
end
