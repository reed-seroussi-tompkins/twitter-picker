class Search < ActiveRecord::Base
  require 'rubygems'
require 'oauth'
require 'json'

  attr_accessor :tweet, :winner, :created, :followers

  def find_hashtags
  # You will need to set your application type to
  # read/write on dev.twitter.com and regenerate your access
  # token.  Enter the new values here:
consumer_key = OAuth::Consumer.new(
  "vk591UPPhkvjE6ubSb5dyJciK",
  "eAwhXWZAciJDYk7e5FGKaROq15vmr6QzKRKaD0UeP1EjjXMnSx")
access_token = OAuth::Token.new(
  "2706806756-8GEjrtrGpAlxG3QYYGAEU4jJmrS9zBkmgx9kn7o",
  "8w7SELE3CQ32BDYbAmCZa6hJqRC83QN5XAFt2p6DTI5Xp")

  # Note that the type of request has changed to POST.
  # The request parameters have also moved to the body
  # of the request instead of being put in the URL.
    baseurl = "https://api.twitter.com"
    path    = "/1.1/search/tweets.json"
    query   = URI.encode_www_form("q" => self.hashtag)
    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri

    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Parse and print the Tweet if the response code was 200
    
    
    if response.code == '200' then
      tweets = JSON.parse(response.body)
      index = rand(tweets["statuses"].count)
      #tweets["statuses"].each do |tweet|
      chosen_tweet = tweets["statuses"][index]
      self.tweet = chosen_tweet["text"]
      self.winner = chosen_tweet["user"]["screen_name"]
      self.created = chosen_tweet["created_at"]
      self.followers = chosen_tweet["user"]["followers_count"]
      
    end


  end
end
