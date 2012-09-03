class ImportTopickeys
  @queue = :innoviz

  def self.perform
    Topickey.async_import
  end
end

class Topickey
  include Mongoid::Document
  field :topic_id, type: Integer
  field :urlkey, type: String
  field :name, type: String
  field :freq, type: Integer

  def self.import_topics
    a=Member.summarize_topics
    a.map{|k,v| Topickey.create(:topic_id=>k.map{|c,n| c}[0],:name=>k.map{|c,n| n}[0].unpack("C*").pack("U*"),:freq=>v)}
  end

  def self.android
    all.find_all { |t| t.name =~ /(android)/i }
  end

  def self.ios
    all.find_all { |t| t.name =~ /\b(iphone|ios|ipad|mac)\b/i }
  end

  def self.blackberry
    all.find_all { |t| t.name =~ /(blackberry)/i }
  end

  def self.windows
    all.find_all { |t| t.name =~ /\b(win|windows)\b/i }

  end

  def self.async_import
    Resque.enqueue(ImportTopickeys)
  end
end
