class Member
  include Mongoid::Document
  include Mongoid::MapReduce

 embeds_many :topics
 embeds_many :other_services

def self.columns
  [ "city", "country","meetup_id"]
end

def self.membertopics(member)
   tpcs=[]
  member.topics.each{|i| tpcs<<i.name}
  return tpcs
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