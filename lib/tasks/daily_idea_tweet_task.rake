# frozen_string_literal: true

namespace :tweeter do
  desc 'Tweets best daily idea from all users who have submitted an idea'
  task daily_idea_tweet: :environment do
    User.find_each do |user|
      Tweeter.new(user).tweet_best_idea_today
    end
  end
end
