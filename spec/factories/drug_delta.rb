# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drug_deltum, :class => 'DrugDelta' do
    timestamp "2012-10-13 10:40:55"
    amount 1.5
    description "MyString"
    drug nil
  end
end
