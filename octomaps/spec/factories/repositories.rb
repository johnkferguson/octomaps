# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repository do
    full_name "MyString"
    description "MyString"
    forks_count 1
    stargazers_count 1
    watchers_count 1
    fork false
  end
end
