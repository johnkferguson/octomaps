FactoryGirl.define do
  factory :person do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    sequence(:github_id) { |n| n }
    github_username { Faker::Internet.user_name }
    avatar_url { Faker::Internet.http_url }
    gravatar_id { Faker::Lorem.characters(20) }
    company { Faker::Company.name }
    blog { Faker::Internet.http_url }
    hireable false
    bio { Faker::Lorem.paragraph(3) }
    github_public_repos_count { Random.new.rand(0..100) }
    github_public_gists_count { Random.new.rand(0..100) }
    github_followers_count { Random.new.rand(0..100) }
    github_following_count { Random.new.rand(0..100) }
    github_created_at { DateTime.new }
    github_updated_at { DateTime.new }
  end
end
