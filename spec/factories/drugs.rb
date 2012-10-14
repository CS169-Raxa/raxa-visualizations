# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drug do
    name "MyString"
    quantity 1.5
    estimated_rate 1.5
    user_rate 1.5
    alert_level 1.5
  end
end
