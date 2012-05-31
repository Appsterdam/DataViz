require 'test_helper'

class ImporterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @db=Mongoid.master
  end

  test "if collections are retrieved" do
    @db.create_collection("test_collection")
    @db.collection_names.each do |i|
      unless i.scan(/^test_collection$/).empty?
        @count=1
      end
    end
    assert_equal(@count,1)
  end

  test "if system.indexes are not appearing on the list" do
    db.collection_names.each do |i|
      unless i.scan(/^system.indexes$/).empty?
        @count=1
      end
    end
    assert_equal(@count,1)

  end
end
