# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topickey do
    topic_id 1
    urlkey "MyString"
    name "MyString"
    freq 1
  end
end
