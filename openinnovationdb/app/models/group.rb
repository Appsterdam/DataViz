class GroupImportFromRaw
  @queue=:group

  def self.perform
    Group.import_from_raw
  end
end

class GroupImportMembers
  @queue=:group

  def self.perform
    Group.import_members
  end
end

class Group
  include Mongoid::Document
  include Mongoid::MapReduce

	field :city,		    :type=>String
	field :country,		  :type=>String
	field :created,		  :type=>Integer
	field :description,	:type=>String
	field :group_photo,	:type=>Hash
	field :join_mode,	  :type=>String
	field :lat,			    :type=>Float
	field :link,		    :type=>String
	field :lon,			    :type=>Float
	field :name,		    :type=>String
	field :organizer,	  :type=>String
	field :rating,		  :type=>String
	field :state,		    :type=>String
	field :topics,		  :type=>Hash
	field :urlname,		  :type=>String
	field :visibility,	:type=>String
	field :who,			    :type=>String

  has_and_belongs_to_many :members

  index :name, unique: true

  def self.dropdb
    #Mongoid.master.collection("groupsas").drop
    Group.destroy_all
  end

  def filter_rawgroup
  	Rawgroup.each do |i|
  		i.grps.each do |u|
  			u.unset('members')
  		end
  	end
  end

  def self.import_from_raw
    Rawgroup.all.each do |i|
      i.grps.each do |k|
        m=Group.new
        m.attributes=k.attributes
        m.save
      end

    end
  end

  def self.import_members
    Rawgroup.all.each do |i|
      i.grps.all.each do |k|
        m=Group.find(k.id)
        m.members << Member.where('meetup_id' => i.member_id).first
      end

    end
  end

  def self.async_scrape
    Resque.enqueue(GroupImportFromRaw)
  end

  def self.async_relation
    Resque.enqueue(GroupImportMembers)
  end

end

