require 'faker'

FactoryGirl.define do
  base_password = 'password'

  factory :author do
    name { Faker::Name.name }
    user
  end

  factory :admin do
    name { Faker::Name.name }
    user
  end

  factory :user do
    email { Faker::Internet.email }
    crypted_password "bob"
    salt "salt"
  end

  factory :widget do
    id 1
    some_other_id 1
    some_id 1
  end

  factory :book do
    title "Title"
    description "description"
    blurb "blurb"
    author
  end

end
