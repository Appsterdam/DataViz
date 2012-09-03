# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    company "MyString"
    cmp_id 1
    is_current false
    start_date ""
    end_date ""
    title "MyString"
    summary "MyString"
  end
end
