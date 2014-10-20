require_relative '../config'

class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.integer  :twitter_tweet_id
      t.integer :politician_id
      t.timestamps
    end
  end
end