TweetStream.configure do |config|
  config.consumer_key       = ENV['TWEETER_KEY']
  config.consumer_secret    = ENV['TWEETER_SECRET']
  config.oauth_token        = ENV['TWEETER_TOKEN']
  config.oauth_token_secret = ENV['TWEETER_SECRET_TOKEN']
  config.auth_method        = :oauth
end

Twitter.configure do |config|
  config.consumer_key       = ENV['TWEETER_KEY']
  config.consumer_secret    = ENV['TWEETER_SECRET']
  config.oauth_token        = ENV['TWEETER_TOKEN']
  config.oauth_token_secret = ENV['TWEETER_SECRET_TOKEN']
end