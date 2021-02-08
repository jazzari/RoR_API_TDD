FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "jsmith#{n}" }
    name { "John Smith" }
    url { |n| "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "Github" }
  end
end
