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

  def self.tweet_best_ideas # this is super bad
    User.find_each do |user|
      break if user.best_idea_today.nil?
      user.tweet_best_idea_today
    end
  end

  def assign_twitter_authentication(auth)
    self.oauth_token = auth.credentials.token
    self.oauth_secret = auth.credentials.secret
    self.provider = auth.provider
    self.uid = auth.uid
  end

  def best_idea_today
    return nil unless number_of_ideas_created_today > 0
    idea_id = ideas.ideas_created_today.collect { |idea| [idea.id, idea.rating] }.max_by(&:last)
    ideas.where(id: idea_id).first
  end

  def connected_with_twitter
    return true unless provider.nil?
  end

  def number_of_ideas_created_today
    return 0 unless ideas.any?
    ideas.ideas_created_today.count
  end

  def number_of_total_ideas
    return 0 unless ideas.any?
    ideas.count
  end

  def tweet_best_idea_today
    return unless best_idea_today.present?
    strategy = Devise.omniauth_configs[:twitter].strategy
    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = strategy.consumer_key
      config.consumer_secret     = strategy.consumer_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    idea_path = 'http://frugtbare.dk' + Rails.application.routes.url_helpers.idea_path(best_idea_today)
    tweet = "I submitted #{number_of_ideas_created_today} ideas in the Ideation Application today. Check out the best one: #{idea_path}"
    twitter.update(tweet)
  end
end
