# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    lon 1.5
    link "MyString"
    lang "MyString"
    city "MyString"
    country "MyString"
    visited 1
    meetup_id 1
    joined 1
    bio "MyString"
    photo ""
    name "MyString"
    lat 1.5
    state "MyString"
    email "MyString"
  end
end
