class MeetupGroup
  include Mongoid::Document

  field :member_id, :type => Integer

  embeds_many :grps

  index({ member_id: 1 }, { unique: true })

  def self.still_to_retrieve
    # retrieves the groups for each member who is still not in the MeetupGroup model
    all_ids               = Member.all.map(&:meetup_id)
    current_ids           = MeetupGroup.all.map(&:member_id)
    still_to_be_retrieved = all_ids - current_ids
  end

  def self.retrieve # info: This one actually retrieves the groups from MeetupAPI and saves them to the temp MeetupGroup model
    rem = Meetup.remaining_rate

    still_to_retrieve[0..rem-100].each do |id|  # Do not exhaust all the hit rate to MeetupAPI at once, but 100 less
      Member.where(:meetup_id => id).first.retrieve_single_member_groups

    end
  end

  def populate_groups  # saves the groups from proxy model to Group model

    self.grps.each do |m|
      g            = Group.new
      g.lon        = m.lon
      g.visibility = m.visibility
      g.organizer  = m.organizer
      g.link       = m.link
      g.join_mode  = m.join_mode
      g.who        = m.who
      g.country    = m.country
      g.city       = m.city
      g.group_id   = m.group_id
      g.category   = m.category
      g.topics     = m.topics
      unless g.group_photo.nil?
        g.group_photo ||= m.group_photo
      end
      g.created = m.created
      unless g.description.nil?
        g.description = m.description
      end
      g.name       = m.name
      g.rating     = m.rating
      g.urlname    = m.urlname
      g.lat        = m.lat
      g.member_vol = m.member_vol
      g.save
    end

  end

  def associate_with_members # Associate Group with Member
   begin
    m = Member.find_by_mid(self.member_id)
    self.grps.each do |i|
      m.groups << Group.where(:group_id => i.group_id).first
    end
    m.save
   rescue
   end

  end

end

class Grp
  include Mongoid::Document

  embedded_in :meetup_group, :inverse_of => :grps
end
