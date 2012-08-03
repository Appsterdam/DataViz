class MemberImportFromRaw
  @queue=:member

  def self.perform
    Member.import_from_raw
  end
end

class MemberImportGroups
  @queue=:group

  def self.perform
    Member.import_groups
  end
end

class BuildLinkedin
  @queue=:group

  def self.perform
    Member.all.each{|i| i.build_linkedin}
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
  embeds_many :events

  index :meetup_id, unique: true

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :gitusers
  has_one :lnkdin

  def topics_titles
    topics.map(&:name)
  end

  def groups_titles
    groups.map(&:name)
  end

  def member_topics
      topics.map{|k| Hash[k.topic_id,k.name]}
  end

  def self.all_topics
      Rawmember.all.map(&:member_topics).flatten
  end

  def self.summarize
      h = Hash.new(0)
      all_topics.each { |v| h.store(v, h[v]+1) }
      return h
  end

  def self.search(search, page)
    paginate :per_page => 5, :page => page, :conditions => ['name like ?', "%#{search}%"], :order => 'name'
  end

  def self.dropdb
   # Mongoid.master.collection("membersas").drop
    Member.destroy_all
  end

  def self.import_from_raw
    Rawmember.all.each do |i|
      m=Member.new
      m.attributes=i.attributes
      m.save
    end
  end

  def self.import_groups
    Rawgroup.all.each do |i|
      m=Member.where('meetup_id' => i.member_id).first
      i.grps.all.each do |k|
        m.groups << k
      end

    end
  end

  def show_groups
    groups.map(&:name).join(",")

    #k=[]
    #self.groupsas.all.each do |i|
    #  k<<i.name
    #end
    #return k.join(",")
  end

  def import_past_events
    events=RMeetup::Client.fetch(:events,{:member_id=>self.meetup_id,:status=>"past"})
    member=Member.where(:meetup_id=>self.meetup_id).first
    ch={"id"=>"event_id"}
    events.each do |i|
      ev=Hash[i.event.map{|k,v| [ch[k]||k,v]}]
      member.events.create(ev)
    end

  end

  def self.async_scrape
    Resque.enqueue(MemberImportFromRaw)
  end

  def self.async_relation
    Resque.enqueue(MemberImportGroups)
  end

  def linkedin_companies
    begin
    unless self.other_services.where(:name=>"linkedin").first.nil?
      client = LinkedIn::Client.new('8timx3cot78n', 'Thc6nYWw0rR5CsWD')
      client.authorize_from_access("b3ec14b7-3ef5-4a77-afc4-21abdb980ae7","71360793-59c5-4d5c-8721-0c89e6be84cb")
      client.profile(:url=>self.other_services.where(:name=>"linkedin").first.srv_id, :fields => %w(positions)).positions.all
    end
    rescue
    return "Linkedin details not correct!"
    end

  end

  def build_linkedin
    m=Lnkdin.new
    m.user_meetup_id = self.meetup_id
    m.member = self
    m.positions = self.linkedin_companies
    m.save
  end

  def poses
    unless self.lnkdin.positions == nil || self.lnkdin.positions == "Linkedin details not correct!"
      self.lnkdin.positions.map{ |k| k['company']['name'] }
    end
  end

  def self.async_scrape_linkedin
    Resque.enqueue(BuildLinkedin)
  end
end

class Topic
  include Mongoid::Document
  include Mongoid::MapReduce

  field :topic_id,  :type => Integer
  field :urlkey,    :type => String
  field :name,      :type => String

  embedded_in :member
end

class OtherService
  include Mongoid::Document
  include Mongoid::MapReduce

  field :name
  field :srv_id

  embedded_in :member
end

class Event
  include Mongoid::Document

  embedded_in :member
end
