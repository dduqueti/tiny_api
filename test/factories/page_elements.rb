FactoryGirl.define do
  factory :page_element do
    element_type 'h1'
    content 'This is a header'
    association :page
  end
end
