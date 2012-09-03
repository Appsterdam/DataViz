require 'test_helper'

class TopickeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'topickey import' do
    a = Member.summarize_topics
    Topickey.import_topics
    assert_equal(Topickey.count,a.count)
  end
end
