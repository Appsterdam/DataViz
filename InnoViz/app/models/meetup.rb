# encoding: UTF-8

class Meetup
  include Mongoid::Document

  def update # This only updates the whole database
    Member.async_import_members
    Group.async_import
    Topickey.async_import
    Topictag.async_import
    Company.async_import
    Gituser.async_import
  end

  def reimport # This will destroy the local DB first and then import evrything back, takes time
               # TODO: Construct an algorithm to overcome the 800hits/hour limitation.

               # Case example: Appsterdam Meetup group members > 1600:
               # We hit the API at 13:45 and we get 800 members. Rate has reached its max for this window.
               # We hit again the API at 14:01 and we get another 800 members. Rate has reached its max for this window.
               # We need to wait until 15:01 to get the rest. Thus it takes around 3 hours to get all of them
    Member.destroy_all
    Meetupgroup.destroy_all
    Group.destroy_all
    Topickey.destroy_all
    Topictag.destroy_all
    Company.destroy_all
    Gituser.destroy_all
    Meetup.new.update

  end

  def self.import_meetup_members
    members = retrieve_members

    MeetupMember.destroy_all
    Member.destroy_all

    members.each do |mmbr|
      MeetupMember.create(mmbr.member)
      Member.create(mmbr.member.correct_member_id.correct_topic_id.restructure_other_services)
    end
  end

  def self.count_members # Count the total members Appsterdam has
    begin
      return RMeetup::Client.fetch(:groups, { :group_urlname => 'Appsterdam' }).first.members
    rescue
      return "Unknown (max rate reached)"
    end
  end

  def self.remaining_rate
    m    =ENV['MEETUP']
    http = Curl::Easy.perform("http://api.meetup.com/members/?relation=self&key="+m)
    return http.header_str.match(/^(X-RateLimit-Remaining):(..?.?.?.?.?\s)$/)[2].to_i
  end

  private

  def self.retrieve_members
    res = []
    tms = RMeetup::Client.fetch(:groups, { :group_urlname => 'Appsterdam' }).first.members/200

    (0..tms).each do |i|
      res << RMeetup::Client.fetch(:members, { :group_urlname => 'Appsterdam', :offset => i, :page => 200 })
    end

    res.flatten
  end


end

class Hash

  # qu: Is that monkey patching?
  # qu: Is there any way I can set a default value to X if X.nil?

  def restructure_other_services
    # qu: Is this DRY?
    if self['other_services']['srv_id'].nil?
      self['other_services'] = self['other_services'].map { |k, v| Hash['name' => k, 'srv_id' => v.map { |c, n| n }[0].to_s] }
    end
    self

  end


  def correct_member_id

    change_id = { "id" => "meetup_id" }
    Hash[self.map { |k, v| [change_id[k]||k, v] }]

  end

  def correct_topic_id
    unless self['topics'].empty?
      change_id      = { "id" => "topic_id" }
      self['topics'] = self['topics'].map { |k| Hash[k.map { |c, n| [change_id[c]||c, n] }] }
    end
    self

  end

  #def correct_positions_id
  #  change_id    = { "id" => "iid" }
  #  self = self.map { |c, n| Hash[change_id[c]||c, n] }
  #  self
  #end


end

