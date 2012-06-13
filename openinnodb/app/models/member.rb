class Member
  include Mongoid::Document

 embeds_many :topics


def self.columns
   return ["name", "lang", "city", "country"]
end


end

class Topic
  include Mongoid::Document

  field :topic_id,:type=>Integer
  field :urlkey,:type=>String
  field :name,:type=>String

  embedded_in :member
end
