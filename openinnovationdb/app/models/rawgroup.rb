class RawgroupImport
  @queue=:group
  
  def self.perform
    Rawgroup.retrieve_and_save
    Rawgroup.filter_rawgroup
  end
end

class Rawgroup
  include Mongoid::Document
  field :member_id, :type => Integer
  embeds_many :grps

  index :member_id, unique: true

  def self.dropdb
   # Mongoid.master.collection("groupraws").drop
    Rawgroup.destroy_all

  end



  def self.grouprawRetrieve(mmbr)

    begin
    gr=RMeetup::Client.fetch(:groups,{:member_id=>"#{mmbr}"})
    m=Rawgroup.new
    m.member_id=mmbr
    gr.each do |i|
      m.grps.new(i.group)
      m.save
    end
    rescue
      m=Rawgroup.new
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
    Rawgroup.all.each do |i|
      grouprawcurid<<i.member_id
    end
      return meetupidMapreduce-grouprawcurid

  end

  def self.filter_rawgroup
  	Rawgroup.all.each do |i|
  		i.grps.each do |u|
  			u.unset('members')
  		end
  	end
  end

  def self.retrieve_and_save
    withNoGroup[0..750].each do |i|
      grouprawRetrieve(i)
    end
  end

  def self.async_scrape
    Resque.enqueue(RawgroupImport)
  end

end

class Grp
  include Mongoid::Document

  embedded_in :rawgroup,:inverse_of => :grps
end

