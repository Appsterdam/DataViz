class Company
  include Mongoid::Document
  field :name,              :type => String
  field :website,           :type => String
  field :place,             :type => String
  field :founded_at,        :type => Integer
  field :fte,               :type => Integer
  field :game_devel,        :type => Boolean
  field :first_name_owner,  :type => String
  field :salutation,        :type => String
  field :email_address,     :type => String
  field :telephone_number,  :type => String
  field :function,          :type => String
  field :street,            :type => String
  field :postcode,          :type => String
  field :year2007,          :type => Boolean
  field :year2008,          :type => Boolean
  field :year2009,          :type => Boolean
  field :console,           :type => Boolean
  field :pc,                :type => Boolean
  field :adventure,         :type => Boolean
  field :serious,           :type => Boolean
  field :simulation,        :type => Boolean
  field :web,               :type => Boolean
  field :type1,             :type => String
  field :type2,             :type => String

  index :name, unique: true

  def self.import_from_xls
    game_cmpns=BatchFactory.from_file("data/game_companies.xls")
    iad=BatchFactory.from_file("data/innovation_awards_database.xls")

    game_cmpns.rows.each do |i|
      Company.create(i)
    end

    iad.rows.each do |i|
      Company.create(i)
    end
  end


end
