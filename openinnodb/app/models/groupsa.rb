class GroupsaImportFromRaw
  @queue=:group
  def self.perform
    Groupsa.importFromRaw
  end
end

class GroupsaImportMembers
  @queue=:groupmemberrelation
  def self.perform
    Groupsa.importMembers
  end
end

class Groupsa
  include Mongoid::Document
  include Mongoid::MapReduce

  has_and_belongs_to_many :membersas

  index :name, unique: true

  def self.dropdb
    Mongoid.master.collection("groupsas").drop
  end

  def self.importFromRaw
    Groupraw.all.each do |i|
      i.grps.each do |k|
          m=Groupsa.new
        m.attributes=k.attributes
        m.save
      end

    end
  end

  def self.importMembers
    Groupraw.all.each do |i|
      i.grps.all.each do |k|
      m=Groupsa.find(k.id)
        m.membersas << Membersa.where('meetup_id'=>i.member_id).first
      end

    end
  end

  def self.async_scrape
    Resque.enqueue(GroupsaImportFromRaw)
  end

  def self.async_relation
    Resque.enqueue(GroupsaImportMembers)
  end

end
