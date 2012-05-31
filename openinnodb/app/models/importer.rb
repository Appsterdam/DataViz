class Importer
  include Mongoid::Document

  def self.db_collections
    db=Mongoid.master.collection_names
    shown_col=[]
    db.each do |el|
      if el.scan(/^system/).empty?
        shown_col << el
      end
    end
      @cols=shown_col
  end
end
