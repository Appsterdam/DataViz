class TagImport
  @queue = :innoviz

  def self.perform
    Topictag.destroy_all
    Topictag.import
  end
end


class Topictag
  include Mongoid::Document

  field :tag, :type => String
  field :freq, :type => Integer

  index({ tag: 1 }, { unique: true })

  def self.normalized
    self.not.all(tag: [/\b(and|for|\\&|the|..?)\b/])
  end

  def self.summarize
    h=Hash.new(0)
    Topickey.all.map { |t| t.name.downcase }.join(" ").split.each { |v| h.store(v, h[v]+1) }
    return h
  end

  def self.import
    summarize.map { |k, v| Topictag.create(:tag => k, :freq => v) }
  end

  def self.async_import
    Resque.enqueue(TagImport)
  end

  def union_topickeys
    Topickey.all.find_all { |k| k.name=~/(\b#{self.tag}\b)/i }
  end

end
