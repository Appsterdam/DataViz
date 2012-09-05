class ImportTweeterIds
  @queue = :twitterid

  def self.perform
    TweeterId.import
  end
end

class TweeterId
  include Mongoid::Document

  field :memberid, type: Integer
  field :twitter_id, type: Integer
  field :srv_id, type: String

  belongs_to :member

  index({ memberid: 1 }, { unique: true })

  def self.no_id
    current_member    = Member.all.map { |k| k.meetup_id unless k.twitter.empty? }.compact
    current_tweeterid = TweeterId.all.map(&:memberid)
    current_member - current_tweeterid
  end

  def self.import
    no_id.each do |mmbr|
      Member.where(:meetup_id => mmbr).first.retrieve_tweeter_id
    end
  end

  def self.async_import
    Resque.enqueue(ImportTweeterIds)
  end

end
