# encoding: UTF-8


require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "sanitization of members" do
    name_str = "Dani\xE8l"
    city_str = "Gen\xE8ve"
    bio_str  = "Dani\xE8l"
    m        = Member.new
    m.name   = name_str
    m.city   = city_str
    m.bio    = bio_str
    assert_equal(m.correct_bio, "Danièl")
    assert_equal(m.correct_city, "Genève")
    assert_equal(m.correct_name, "Danièl")


  end

end
