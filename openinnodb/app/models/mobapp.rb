class Mobapp
  include Mongoid::Document
  field :name, :type => String
  field :creator, :type => String
  field :commissioner, :type => String
  field :copyright, :type => String
  field :appic, :type => String
  field :novel, :type => Boolean
  field :repackaged, :type => Boolean
  field :devlanguage, :type => String
  field :platform, :type => String
  field :hardware, :type => String
  field :date, :type => Date
  field :updated, :type => String
  field :location, :type => String
  field :downloads, :type => Integer
  field :returnusers, :type => Integer
  field :rating, :type => Integer
  field :free, :type => Boolean
  field :paid, :type => Boolean
  field :category, :type => String
end
