require 'test_helper'

class MeetupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @a = RMeetup::Client.fetch(:groups, { :group_urlname => 'Appsterdam' }).first.members
    @b = RMeetup::Client.fetch(:members, { :group_urlname => 'Appsterdam', :offset => 1, :page => 20 })
  end


  test 'meetup members amount' do
    assert_equal(@a.class.to_s, "Fixnum")
  end

  test 'meetup members retrieve' do
    assert_equal(@b.count, 20)
  end

  test 'meetup id change' do
    change_id = { "id" => "meetup_id" }
    res       = Hash[@b.first.member.map { |k, v| [change_id[k]||k, v] }]
    assert_not_equal(res['meetup_id'], nil)
  end

  test 'topic id change' do
    change_id = { "id" => "topic_id" }
    idx       = 0
    while idx < @b.count do
      unless @b[idx].topics.empty?
        res = @b[idx].member['topics'].map { |k| Hash[k.map { |c, n| [change_id[c]||c, n] }] }
        assert_not_equal(res.last['topic_id'], nil)
        break
      end
      idx += 1
    end
  end

  # qu: Shall I use testing for noting down an idea
  test 'change the structure of other_services' do
    idx = 0
    while idx < @b.count do
      unless @b[idx].other_services.empty? do
        a = @b[idx].member['other_services'].map { |k, v| Hash['name' => k, 'srv_id' => v.map { |c, n| n }[0]] }
        !assert_true(a['name'].empty?)
        break
      end
      end
      idx += 1

    end
  end

  # qu: ...or to exclusively test methods in the respective model?

  test 'restructuring of other_services' do
    a = @b.last.member.restructure_other_services

  end

end
