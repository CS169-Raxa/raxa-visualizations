# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :doctor do
    name "MyString"
    specialty "MyString"
    max_workload 1
  end
end
