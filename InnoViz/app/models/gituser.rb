class ImportGitusers
  @queue = :innoviz

  def self.perform
    Gituser.destroy_all
    Gituser.import_from_file
    Gituser.associate_with_members
  end
end

class Gituser
  include Mongoid::Document
  field :username, type: String
  field :name, type: String
  field :language, type: String
  field :url, type: String
  field :member_since, type: String
  field :repos, type: Integer
  field :email, type: String
  field :followers, type: Integer
  field :location, type: String
  field :personal_url, type: String
  field :company, type: String
  field :projects, type: Hash

  index({ username: 1 }, { unique: true })

  has_and_belongs_to_many :members

  def self.import_from_file
    file=File.read('data/users.json')
    JSON.parse(file)['users'].each { |i| Gituser.create(i) }
  end

  def match_members
    Member.all(name: [/\b#{self.name}\b/i])
  end

  def self.associate_with_members
    Gituser.each do |gituser|
      gituser.members << gituser.match_members
      gituser.save
    end
  end

  def self.async_import
    Resque.enqueue(ImportGitusers)
  end
end
