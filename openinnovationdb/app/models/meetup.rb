class Meetup
  include Mongoid::Document

  def self.db_collections
    db=Mongoid.master.collection_names
    shown_col=[]
      db.each do |el|
        if el.scan(/^system/).empty?
          shown_col << el
        end
      end

  end

  def self.countmembers  # Count the total members Appsterdam has
    begin
      return RMeetup::Client.fetch(:groups,{:group_urlname=>'Appsterdam'}).first.members
    rescue
      return "Unknown (max rate reached)"
    end
  end

  def self.filterString(inputString)  # filter the invalid characters
    res = ""
    (1..(inputString.size)).each do |i|
      if inputString[i-1] < 0xA0.chr then
        res = res + inputString[i-1]
      else
        res = res + "?"
      end
    end
    return res
  end

  def self.retrievedata # retrieve the Appsterdam member data directly from the API
    res=[]
    tms=RMeetup::Client.fetch(:groups,{:group_urlname=>'Appsterdam'}).first.members/200

    (0..tms).each do |i|
      partialres=[]
      partialres = RMeetup::Client.fetch(:members,{:group_urlname=>'Appsterdam',:offset=>i,:page=>200})
      res<<partialres
    end

    res.flatten

  end

  def self.filtermemberData(memberdata) # replace the 'id' field with 'member_id' as it raises exceptions when saving
    #res = self.retrievedata
    # change id to meetup_id and put them back to each member
    id_change={"id" => "meetup_id"}
    res=[]
    memberdata.each do |members|
      res<<Hash[members.member.map{|k,v| [id_change[k]||k, v.class==String ? self.filterString(v.force_encoding("BINARY")) : v] }]

    end
    return res
  end

  def self.filtertopicData( memberdata ) # replace 'id' field with 'topic_id'
    # change ["topics"]["id"] to ["topics"]["topicid"] and put them back to each member
    id_change={"id"=>"topic_id"}
    memberdata.each do |i|
      res=[]
      i['topics'].each do |topics|
        res<<Hash[topics.map{|k,v| [id_change[k]||k,v.class==String ? self.filterString(v.force_encoding("BINARY")) : v]}]
        i['topics']=res

      end
      # @final_res<<Hash[i["topics"].each {|topics| topics.map{|k,v| [t_id_change[k]||k,v]}}]
    end
    return memberdata

  end

  def self.filterservicesdata(memberdata)
    memberdata.each do |i|
      srvhash=[]
      i['other_services'].map do |k,v|
        srvhash<<Hash[name:k,srv_id:v.map{|c,n| n}[0]]
      i['other_services']=srvhash

        end

    end
  end

  def self.meetupretrieve
    return self.filterservicesdata(self.filtertopicData( self.filtermemberData( self.retrievedata ) ))
  end

  def self.meetupsave  # This is the function used to finally import the data
    JSON.parse(self.meetupretrieve.to_json).each do |i|
      m=Rawmember.new(i)
      m.save!
      #Member.create(i)
    end
  end

  def self.dropdb
    #Mongoid.master.collection("members").drop
    Rawember.destroy_all
  end

  def self.checkgroupq
    if Resque.size("group")==0
      return "No"
    else
      return "Yes"
    end
  end

end
