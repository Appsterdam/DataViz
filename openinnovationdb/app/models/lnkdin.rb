class Lnkdin
  include Mongoid::Document
  field :user_meetup_id, :type => Integer
  field :positions, :type => Hash

  index :user_meetup_id, unique: true


  belongs_to :member
end
