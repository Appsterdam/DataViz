class Membersa
  include Mongoid::Document
  include Mongoid::MapReduce

  has_and_belongs_to_many :groupsas

  def self.dropdb
    Mongoid.master.collection("membersas").drop
  end

  def self.importFromRaw
    Member.all.each do |i|
      m=Membersa.new
      m.attributes=i.attributes
      m.save
    end
  end

  def self.importGroups
    Groupraw.all.each do |i|
      m=Membersa.where('meetup_id'=>i.member_id).first
      m.groupsas << i.grps

    end
  end
end
