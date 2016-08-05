FactoryGirl.define do
  factory :page do
    url { Faker::Internet.url }
  end
end
