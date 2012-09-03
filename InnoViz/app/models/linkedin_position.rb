class ImportPositions
  @queue = :linkedin

  def self.perform
    LinkedinPosition.destroy_all
    LinkedinPosition.import
  end
end

class LinkedinPosition
  include Mongoid::Document
  field :member_id, type: Integer
  field :positions, type: Hash


  def create_position
    p           = Position.new
    p.name      = self.name
    p.cmp_id    = self.cmp_id
    p.industry  = self.industry unless self.industry.nil?
    p.is_current= self['is_current']
    p.start_date= self['start_date']
    p.summary   = self['summary'] unless self['summary'].nil?
    p.title     = self['title']
    p.member    = Member.where(:meetup_id => self.member_id).first
    p.save
  end

  def self.import
    Member.all.each { |m| m.retrieve_linkedin_positions }
  end

  def self.async_import
    Resque.enqueue(ImportPositions)
  end


  def company
    positions['company']
  end

  def name
    positions['company']['name']
  end

  def cmp_id
    positions['company']['id']
  end

  def industry
    positions['company']['industry']
  end


end
