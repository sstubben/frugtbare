class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

  has_many :ideas

  validates :email, :encrypted_password, presence: true

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first
    if user.nil?
      user.email = auth.info.email
      user.password ||= Devise.friendly_token[0, 20]
      user.assign_twitter_authentication(auth)
      user.save!
    elsif user.provider.nil?
      user.assign_twitter_authentication(auth)
      user.save!
    end
    user
  end

  def assign_twitter_authentication(auth)
    self.oauth_token = auth.credentials.token
    self.oauth_secret = auth.credentials.secret
    self.provider = auth.provider
    self.uid = auth.uid
  end

  def connected_with_twitter
    provider.present?
  end

  def number_of_ideas_created_today
    ideas.created_today.count
  end

  def number_of_total_ideas
    ideas.count
  end
end
