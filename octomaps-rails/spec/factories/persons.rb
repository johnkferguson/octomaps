FactoryGirl.define do
  factory :person do
    etag { Faker::Lorem.characters(20) }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
  end
end
