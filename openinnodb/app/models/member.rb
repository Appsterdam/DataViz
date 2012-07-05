class MemberImporter
  @queue = :member

  def self.perform
    Importer.meetupsave
  end
end

class Member
  include Mongoid::Document
  include Mongoid::MapReduce

  field :lon,       :type => Float
  field :link,      :type => String
  field :lang,      :type => String
  field :city,      :type => String
  field :country,   :type => String
  field :visited,   :type => Integer
  field :meetup_id, :type => Integer
  field :joined,    :type => Integer
  field :bio,       :type => String
  field :photo,     :type => Hash
  field :name,      :type => String
  field :lat,       :type => Float
  field :state,     :type => String
  field :email,     :type => String


  embeds_many :topics
  embeds_many :other_services

  index :meetup_id, unique: true

  def topics_titles
    topics.map(&:name)
  end

  def self.columns
    ["city", "country"]
  end

  def member_topics
    topics.map{|k| Hash[k.topic_id,k.name]}

    #tpcs=[]
    #member.topics.each { |i| tpcs<<Hash[i.topic_id, i.name] }
    #return tpcs
  end

  #def self.membertopicstitles(member)
  #  warn "Deprecated. User Member#topics_titles instead"
  #  member.topics_titles
  #end

  def self.all_topics
    Member.all.map(&:member_topics).flatten

    #tpc=[]
    #Member.all.each do |topics|
    #  tpc<<topics.member_topics
    #end
    #return tpc.flatten
  end


  def self.summarize
    h = Hash.new(0)
    all_topics.each { |v| h.store(v, h[v]+1) }
    return h
  end

  def self.async_scrape
    Resque.enqueue(MemberImporter)
  end

end


class Topic
  include Mongoid::Document
  include Mongoid::MapReduce

  field :topic_id, :type => Integer
  field :urlkey, :type => String
  field :name, :type => String

  embedded_in :member
end

class OtherService
  include Mongoid::Document
  include Mongoid::MapReduce

  field :name
  field :srv_id

  embedded_in :member
end




