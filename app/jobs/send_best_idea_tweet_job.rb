class SendBestIdeaTweetJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    User.tweet_best_ideas
  end
end
