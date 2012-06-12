# encoding: utf-8
# @splir
class Importer
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

  def self.meetupretrieve
    #  results=get_response("http://api.meetup.com/2/members.json?key=#{api_key}&sign=true&group_urlname=Appsterdam&page=20")
    # api_key='76324a2830c76662b7b2c3f4f305e39'
    #  res=JSON.parse(results)["results"]

    res=[]
    tms=RMeetup::Client.fetch(:groups,{:group_urlname=>'Appsterdam'}).first.members/1000
    (1..tms).each do
    partialres = RMeetup::Client.fetch(:members,{:group_urlname=>'Appsterdam',:offset=>tms})
    res<<partialres
    end
    res=res.flatten
    # change id to meetup_id and put them back to each member
    id_change={"id"=>"meetup_id"}
    new_res=[]
    res.each do |i|
      new_res<<Hash[i.member.map{|k,v| [id_change[k]||k,v]}]

    end
    # change ["topics"]["id"] to ["topics"]["topicid"] and put them back to each member
    t_id_change={"id"=>"topic_id"}
    new_res.each do |i|
      final_res=[]
      i['topics'].each do |topics|
        final_res<<Hash[topics.map{|c,n| [t_id_change[c]||c,n.class==String ? n.force_encoding("BINARY").gsub!(/\\0x...?$/,"o") : n]}]
        i['topics']=final_res

      end



      @finale=new_res
      # @final_res<<Hash[i["topics"].each {|topics| topics.map{|k,v| [t_id_change[k]||k,v]}}]
    end

  end
  # @finalres=new_res


  def self.meetupsave
    JSON.parse(@finale.to_json).each do |i|
      m=Member.new(i)
      m.save!
      #Member.create(i)
    end
  end

  def self.dropdb
    Mongoid.master.collection("members").drop
  end

end
