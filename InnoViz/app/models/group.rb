class ImportGroups
  @queue = :innoviz

  def self.perform
    MeetupGroup.retrieve
    Group.import
  end
end

class Group
  include Mongoid::Document

  field :group_id, type: Integer
  field :city, type: String
  field :country, type: String
  field :created, type: Integer
  field :description, type: String
  field :group_photo, type: Hash
  field :join_mode, type: String
  field :lat, type: Float
  field :link, type: String
  field :lon, type: Float
  field :name, type: String
  field :organizer, type: Hash
  field :rating, type: String
  field :state, type: String
  field :topics, type: Hash
  field :urlname, type: String
  field :visibility, type: String
  field :who, type: String
  field :member_vol, type: String
  field :category, type: Hash

  has_and_belongs_to_many :members


  index({ group_id: 1 }, { unique: true })

  def members_vol
    member_vol.to_i
  end

  def self.import # INFO: imports from temp MeetupGroup model to Group and builds associations Group with Member
    MeetupGroup.all.each { |i| p i.member_id;i.populate_groups; i.associate_with_members }
  end

  def self.async_import
    Resque.enqueue(ImportGroups)
  end
end
