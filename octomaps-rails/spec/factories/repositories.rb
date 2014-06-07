FactoryGirl.define do
  factory :repository do
    owner { "#{Faker::Internet.user_name}" }
    name { "#{Faker::Lorem.word}" }
    full_name { "#{owner}/#{name}" }
    description { Faker::Company.catch_phrase }
    forks_count { Random.new.rand(0..100) }
    stargazers_count { Random.new.rand(0..100) }
    watchers_count { Random.new.rand(0..100) }
    forked false
  end
end
