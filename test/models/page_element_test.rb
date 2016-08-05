require 'test_helper'

class PageElementTest < ActiveSupport::TestCase

  let(:page_element) { FactoryGirl.create(:page_element) }

  it 'has a valid factory' do
    page_element.must_be_instance_of PageElement
  end

  it "does not creates with nil element_type" do
    page_element = FactoryGirl.build(:page_element, element_type: nil)
    page_element.invalid?(:element_type).must_equal true
    page_element.errors[:element_type].must_equal ["can't be blank", "is not included in the list"]
  end

  it "does not creates with nil page" do
    page_element = FactoryGirl.build(:page_element, page: nil)
    page_element.invalid?(:page).must_equal true
    page_element.errors[:page].must_equal ["can't be blank"]
  end

  it "does not creates with invalid element type" do
    page_element = FactoryGirl.build(:page_element, element_type: "nothing")
    page_element.invalid?(:page_element).must_equal true
    page_element.errors[:element_type].must_equal ["is not included in the list"]
  end

  it "creates with valid element type" do
    page_element = FactoryGirl.build(:page_element, element_type: "h1")
    page_element.valid?(:page_element).must_equal true
  end
end
