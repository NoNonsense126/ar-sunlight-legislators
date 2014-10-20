require 'twitter'

class TwitterImporter
  def self.login_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "nBlEh1b1DqLxAdeS88Idjw5LV"
      config.consumer_secret     = "gQqv7VaOKcYp7EcA4f0ENp8O3UEOfvQMuReYFcRNAhY1xkGgd0"
      config.access_token        = "612492229-uNAaywodCMpbhd6IVjnAvqoOV6QQjZq3naW0bZBa"
      config.access_token_secret = "QO3DAd9nZea98q5ZxO41NSMHDtYtiHFIZkRZBKje1x0hS"
    end
  end

  def self.get_last_10_tweets(politician_id)
    twitter_user = Politician.find(politician_id).twitter_id
    timeline = @client.user_timeline(twitter_user)[0..9]
    timeline.each do |tweet|
      new_tweet = Tweet.new
      new_tweet.text = tweet.text
      new_tweet.twitter_tweet_id = tweet.id
      new_tweet.politician_id = politician_id
      new_tweet.save
    end
  end

end
