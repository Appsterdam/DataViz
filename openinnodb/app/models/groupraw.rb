class Groupraw
  include Mongoid::Document
  field :member_id, :type => Integer
  embeds_many :grps


  def self.dropdb
    Mongoid.master.collection("groupraws").drop
  end

  def self.grouprawRetrieve(mmbr)
    begin
    gr=RMeetup::Client.fetch(:groups,{:member_id=>"#{mmbr}"})
    rescue
    gr={}
    end
    m=Groupraw.new
    m.member_id=mmbr
    gr.each do |i|
      m.grps.new(i.group)
    end
    m.save

  end

  def self.meetupidMapreduce
    mr=Member.map_reduce(:meetup_id).keys
    mrc=[]
    mr.each do |i|
      mrc<<i.to_i
    end
    return mrc
  end

  def self.remainingRate
    http = Curl::Easy.perform('http://api.meetup.com/members/?relation=self&key=#{ENV["MEETUP"]}')
    return http.header_str.match(/(X-RateLimit-Remaining):(....)/)[2].to_i
  end

  def self.withNoGroup
    grouprawcurid=[]
    memberid=[]
    Groupraw.all.each do |i|
      grouprawcurid<<i.member_id
    end
      return meetupidMapreduce-grouprawcurid

  end

  def self.retrieveAndSave
    withNoGroup.each do |i|
      grouprawRetrieve(i)
    end
  end

end

class Grp
  include Mongoid::Document

  embedded_in :groupraw,:inverse_of => :grps
end
