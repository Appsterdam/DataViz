require 'test_helper'

class MeetupGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'initialization of groups' do
    Member.new(:meetup_id=>"123456").save
    m=MeetupGroup.new
    m.member_id=Member.where(:meetup_id=>"123456").first.meetup_id
    m.save

    assert_equal(MeetupGroup.first.member_id.to_s,"123456")
  end

end
