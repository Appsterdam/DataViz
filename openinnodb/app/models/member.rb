class Member
  include Mongoid::Document


def self.columns
  return ["meetup_id", "name", "lang", "city", "country"]
end


end
