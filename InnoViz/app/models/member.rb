# encoding: UTF-8

class ImportMember
  @queue = :innoviz

  def self.perform
    Meetup.import_meetup_members
    Member.sanitize_members
  end
end

class Member
  include Mongoid::Document


  field :lon, type: Float
  field :link, type: String
  field :lang, type: String
  field :city, type: String
  field :country, type: String
  field :visited, type: Integer
  field :meetup_id, type: Integer
  field :joined, type: Integer
  field :bio, type: String
  field :photo, type: Hash
  field :name, type: String
  field :lat, type: Float
  field :state, type: String
  field :email, type: String

  index({ meetup_id: 1 }, { unique: true })

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :gitusers
  has_one :tweeter_id
  has_many :positions
  embeds_many :topics
  embeds_many :other_services

  [:twitter, :linkedin, :facebook, :flickr].each do |f|
    define_method f do
      if other_services.where(:name => f.to_s).first.nil?
        return []
      else
        other_services.where(:name => f.to_s).first.srv_id

      end

    end
  end

  def self.find_by_mid(id)
    where(:meetup_id => id).first
  end

  def member_topics
    topics.map { |k| Hash[k.topic_id, k.name] }
  end

  def self.all_topics
    all.map(&:member_topics).flatten
  end

  def self.summarize_topics
    topics_hash = Hash.new(0)
    all_topics.each { |v| topics_hash.store(v, topics_hash[v]+1) }
    return topics_hash
  end

  def self.sanitize_members # Cleans the UTF-8 invalid character for all members
    Member.all.each do |member|
      member.name = member.correct_name
      member.city = member.correct_city
      unless member.bio.nil?
        member.bio = member.correct_bio
      end
      # qu: Use member#upsert here?
      member.save
    end
  end

  def self.async_import_members
    # info: This is the command to import meetup members to InnoViz
    Resque.enqueue(ImportMember)
  end

  def retrieve_single_member_groups
    # qu: why the below returns nil even if the rescue message return the match
    begin
      rawgroups = RMeetup::Client.fetch(:groups, { :member_id => "#{self.meetup_id}" })
      change_id ={ "id" => "group_id", "members" => "member_vol" }
      groups    =rawgroups.map { |i| Hash[i.group.map { |k, v| [change_id[k]||k, v] }] }

      m           = MeetupGroup.new
      m.member_id = self.meetup_id
      groups.each do |i|
        m.grps.new(i)
        m.save
      end
    rescue => e
      case e
        # info: this error pops up when member does not allow his groups to public view
        when e.message.match(/\b(The given member)\b/i)
          m           = MeetupGroup.new
          m.member_id = self.meetup_id

          m.grps = Hash["group_id", 1853731]
          m.save
          p "Saved"
        when e.message.match(/\b(again later)\b/i)
          # info: this error pops up when Maximum rate has been reached (800hits/hour)
          p "max API rate reached"
        else

      end
    end
  end


  def correct_name # Cleans the UTF-8 invalid character

    name.unpack("C*").pack("U*")
  end

  def correct_city # Cleans the UTF-8 invalid character

    city.unpack("C*").pack("U*")
  end

  def correct_bio # Cleans the UTF-8 invalid character
    bio.unpack("C*").pack("U*")
  end

  def retrieve_linkedin_positions

    #client = LinkedIn::Client.new('8timx3cot78n', 'Thc6nYWw0rR5CsWD')
    #client.authorize_from_access("b3ec14b7-3ef5-4a77-afc4-21abdb980ae7", "71360793-59c5-4d5c-8721-0c89e6be84cb")
    client = LinkedIn::Client.new('g7upruzb5i07', 'TYOwWEK3D58xdB98')
    client.authorize_from_access("12762eb4-2f9c-4ee8-a3e1-2b799dc91b70", "3190c08b-744c-4b65-808f-5c448ddd3cde")
    begin
      poses = client.profile(:url => self.linkedin, :fields => %w(positions)).positions.all
      poses.each do |position|
        l           = LinkedinPosition.new
        l.member_id = self.meetup_id
        l.positions = position
        l.save
      end
    rescue
    end


  end

  def retrieve_tweeter_id
    begin
      t            = TweeterId.new
      t.memberid = self.meetup_id
      t.srv_id     =self.twitter
      t.twitter_id = Twitter.user(self.twitter).id
      t.member     = self
      t.save
    rescue => e
      p e.message if e.message.match(/\bRate limit\b/i)

    end

  end


end

class Topic
  include Mongoid::Document


  field :topic_id, :type => Integer
  field :urlkey, :type => String
  field :name, :type => String

  embedded_in :member
end

class OtherService
  include Mongoid::Document


  field :name
  field :srv_id

  embedded_in :member
end
