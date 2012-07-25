class Importkeys
  @queue=:member

  def self.perform
    Topickey.import
  end
end

class Topickey
  include Mongoid::Document
  include Mongoid::MapReduce

  field :topic_id,:type=>Integer
  field :title,:type=>String
  field :freq,:type=>Integer

  index :topic_id, unique: true 

  def self.android
  	all.find_all { |t| t.title =~ /(android)/i }
  end

  def self.ios
  	all.find_all { |t| t.title =~ /(iphone|ios|ipad|mac)/i }
  end

  def self.blackberry
    all.find_all { |t| t.title =~ /(blackberry)/i }
  end

  def self.windows
    all.find_all { |t| t.title =~ /\b(win|windows)\b/i }

  end
  def self.import
    a=Member.summarize
    a.map{|k,v| Topickey.create(:topic_id=>k.map{|c,n| c}[0],:title=>k.map{|c,n| n}[0],:freq=>v)}
  end

  # def self.columns
  #   ['Title','Freq']
  # end

  #def self.aggregate
  #  topics=[]
  #  self.all.each{|i| topics<<i.title}
  #  h = Hash.new(0)
  #  topics.each { | v | h.store(v, h[v]+1) }
  #  return h
  #end

  def self.dropdb
   # Mongoid.master.collection("topickeys").drop
    Topickey.destroy_all
  end

  def self.async_scrape
    Resque.enqueue(Importkeys)
  end
end




