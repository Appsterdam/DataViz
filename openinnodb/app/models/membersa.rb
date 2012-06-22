class MembersaImportFromRaw
  @queue=:member
  def self.perform
    Membersa.importFromRaw
  end
end

class MembersaImportGroups
  @queue=:group
  def self.perform
    Membersa.importGroups
  end
end

class Membersa
  include Mongoid::Document
  include Mongoid::MapReduce

  field :lon,:type=>Float
  field :link,:type=>String
  field :lang,:type=>String
  field :city,:type=>String
  field :country,:type=>String
  field :visited,:type=>Integer
  field :meetup_id,:type=>Integer
  field :joined,:type=>Integer
  field :bio, :type=>String
  # field :photo,:type=>Hash
  field :name,:type=>String
  field :lat,:type=>Float
  field :state,:type=>String
  field :email,:type=>String


  embeds_many :topics
  embeds_many :other_services

  index :meetup_id, unique: true

  has_and_belongs_to_many :groupsas

  def self.dropdb
    Mongoid.master.collection("membersas").drop
  end

  def self.importFromRaw
    Member.all.each do |i|
      m=Membersa.new
      m.attributes=i.attributes
      m.save
    end
  end

  def self.importGroups
    Groupraw.all.each do |i|
      m=Membersa.where('meetup_id'=>i.member_id).first
        i.grps.all.each do |k|
          m.groupsas << k
        end

    end
  end

  def self.showgroups(mmbr)
     k=[]
    mmbr.groupsas.all.each do |i|
       k<<i.name
    end
    return k.join(",")
  end

  def self.async_scrape
    Resque.enqueue(MembersaImportFromRaw)
  end

  def self.async_relation
    Resque.enqueue(MembersaImportGroups)
  end
end

class Topic
  include Mongoid::Document
  include Mongoid::MapReduce

  field :topic_id,:type=>Integer
  field :urlkey,:type=>String
  field :name,:type=>String

  embedded_in :member
end

class OtherService
  include Mongoid::Document
  include Mongoid::MapReduce

  field :name
  field :srv_id

  embedded_in :member
end

