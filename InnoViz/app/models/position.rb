class ImportPositions
  @queue = :linkedin

  def self.perform
    Position.import
  end
end

class Position
  include Mongoid::Document
  field :name,        type: String
  field :cmp_id,      type: Integer
  field :industry,    type: String
  field :is_current,  type: Boolean
  field :start_date,  type: Hash
  field :end_date,    type: Hash
  field :title,       type: String
  field :summary,     type: String

  belongs_to :member

  def self.import
    LinkedinPosition.each{|pos| pos.create_position }
  end

  def self.async_import
    Resque.enqueue(ImportPositions)
  end

end
