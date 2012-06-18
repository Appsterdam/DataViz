class Member
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

def self.columns
  [ "city", "country"]
end

def self.membertopics(member)
   tpcs=[]
  member.topics.each{|i| tpcs<<Hash[i.topic_id,i.name]}
  return tpcs
end

def self.membertopicstitles(member)
    tpcs=[]
    member.topics.each{|i| tpcs<<i.name}
    return tpcs
end
def self.alltopics
  tpc=[]
  Member.all.each do |topics|
    tpc<<Member.membertopics(topics)
  end
   return tpc.flatten
end


  def self.aggregate(what)
    h = Hash.new(0)
    what.each { | v | h.store(v, h[v]+1) }
    return h
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

#class Twitter
#  include Mongoid::Document
#
#  field :srv_id
#  embedded_in :other_services
#end
#
#class Linkedin
#   include Mongoid::Document
#   field :srv_id
#   embedded_in :other_service
#end
#
#class Tumblr
#  include Mongoid::Document
#  field :srv_id
#  embedded_in :other_service
#end
#
#class Flickr
#  include Mongoid::Document
#  field :srv_id
#  embedded_in :other_service
#end