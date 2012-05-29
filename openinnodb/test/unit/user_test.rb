require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "user creation" do
    user=User.new(firstname:"Nikos")
    user.save
    assert_equal(User.count,1)
  end

  test "user read" do
    user=User.new(firstname:"Nikos")
    user.save
    user=User.first
    assert_equal(user.firstname,"Nikos")
  end

  test "update user" do
    user=User.new(firstname:"Nikos")
    user.save
    user=User.where(firstname:"Nikos").first
    user.lastname="Papadopoulos"
    user.save
    user=User.where(firstname:"Nikos").first
    assert_equal(user.lastname,"Papadopoulos")
  end

  test "user deletion" do
    user=User.new(firstname:"Nikos")
    user.save
    howmany=User.count
    user=User.where(firstname:"Nikos")
    user.destroy
    assert_equal(howmany-1,0)
  end
end
