class Tweeter
  def self.tweet_best_ideas
    User.find_each do |user|
      break unless user.best_idea_today
      new(user).tweet_best_idea_today
    end
  end

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def tweet_best_idea_today
    return unless best_idea_today.present?

    idea_path = 'http://frugtbare.dk' + Rails.application.routes.url_helpers.idea_path(best_idea_today)
    tweet = "I submitted #{number_of_ideas_created_today} ideas in the Ideation Application today. Check out the best one: #{idea_path}"
    client.update(tweet)
  end

  private

  def best_idea_today
    idea_id = ideas.ideas_created_today.collect { |idea| [idea.id, idea.rating] }.max_by(&:last)
    ideas.find_by(id: idea_id)
  end

  def ideas
    user.ideas
  end

  def client
    strategy = Devise.omniauth_configs[:twitter].strategy

    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = strategy.consumer_key
      config.consumer_secret     = strategy.consumer_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
  end
end
