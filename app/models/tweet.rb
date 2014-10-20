require_relative '../../db/config'

class Tweet < ActiveRecord::Base
  belongs_to :politician
  validates :twitter_tweet_id, uniqueness: true
end





