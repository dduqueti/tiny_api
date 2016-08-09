FactoryGirl.define do
  factory :page do
    url { Faker::Internet.url }
    trait :with_page_elements do
       after(:create) do |instance|
        create_list :page_element, 2, page: instance
      end
    end
  end
end
