class GroupRawImport
  @queue=:group
  def self.perform
    Groupraw.retrieveAndSave
  end
end

class Groupraw
  include Mongoid::Document
  field :member_id, :type => Integer
  embeds_many :grps

  index :member_id, unique: true

  def self.dropdb
   # Mongoid.master.collection("groupraws").drop
    Groupraw.destroy_all

  end



  def self.grouprawRetrieve(mmbr)

    begin
    gr=RMeetup::Client.fetch(:groups,{:member_id=>"#{mmbr}"})
    m=Groupraw.new
    m.member_id=mmbr
    gr.each do |i|
      m.grps.new(i.group)
      m.save
    end
    rescue
      m=Groupraw.new
      m.member_id=mmbr

        m.grps=Hash[]

    m.save
    end

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
    m=ENV['MEETUP']
    http = Curl::Easy.perform("http://api.meetup.com/members/?relation=self&key="+m)
    return http.header_str.match(/^(X-RateLimit-Remaining):(..?.?.?.?.?\s)$/)[2].to_i
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
    withNoGroup[0..750].each do |i|
      grouprawRetrieve(i)
    end
  end

  def self.async_scrape
    Resque.enqueue(GroupRawImport)
  end

end

class Grp
  include Mongoid::Document

  embedded_in :groupraw,:inverse_of => :grps
end
