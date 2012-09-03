class StreamStart
  @queue = :twitterstream

  def self.perform
    Stream.start
  end
end
class Stream
  include Mongoid::Document

  def self.start
    ids = TweeterId.all.map(&:twitter_id)
    TweetStream::Client.new.follow(ids) do |status|
      Stream.create(status)
    end
  end

  def self.async_stream
    Resque.enqueue(StreamStart)
  end
end
