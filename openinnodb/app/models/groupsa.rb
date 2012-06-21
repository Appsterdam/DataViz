class Groupsa
  include Mongoid::Document
  include Mongoid::MapReduce

  has_and_belongs_to_many :membersas

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


end
