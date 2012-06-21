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


end
