class User
  include Mongoid::Document
  field :firstname, :type => String
  field :lastname, :type => String
  field :twitterid, :type => String
  field :emailadd, :type => String
  field :urladd, :type => String
  field :origin, :type => String
  field :location, :type => String
  field :age, :type => String
  field :background, :type => String
  field :yearsofexp, :type => String
  field :sex, :type => String
  field :education, :type => String
  field :mentor, :type => String
  field :income, :type => Integer
end
