# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gituser do
    username "MyString"
    name "MyString"
    language "MyString"
    url "MyString"
    member_since "MyString"
    repos 1
    email "MyString"
    followers 1
    location "MyString"
    personal_url "MyString"
    company "MyString"
    projects ""
  end
end
