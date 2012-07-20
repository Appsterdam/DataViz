class TagImport
	@queue = :member

	def self.perform
		Topictag.import
	end
end


class Topictag
  	include Mongoid::Document
	include	Mongoid::MapReduce

	field :tag,		:type=>String
	field :freq,	:type=>Integer

	index :tag, unique: true

	def self.summarize
		h=Hash.new(0)
		Topickey.all.map(&:title).join(" ").split.each { |v| h.store(v, h[v]+1) }
		return h
	end

	def self.import
		summarize.map{|k,v| Topictag.create(:tag=>k,:freq=>v)}
	end

	def self.async_scrape
		Resque.enqueue(TagImport)
	end

	def union_topickeys
		Topickey.all.find_all{|k| k.title=~/(#{self.tag})/i}
	end

end