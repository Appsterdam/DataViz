class Gituser
  include Mongoid::Document
  field :username, :type => String
  field :name, :type => String
  field :language, :type => String
  field :url, :type => String
  field :member_since, :type => String
  field :repos, :type => Integer
  field :email, :type => String
  field :followers, :type => Integer
  field :location, :type => String
  field :personal_url, :type => String
  field :company, :type => String
  field :projects, :type => Hash

  index :username, unique: true

  def self.import_from_file
    file=File.read('data/users.json')
    JSON.parse(file)['users'].each{ |i| Gituser.create(i) }
  end
end