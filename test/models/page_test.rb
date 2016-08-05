require 'test_helper'

class PageTest < ActiveSupport::TestCase

	let(:page) { FactoryGirl.create(:page, url: "http://www.google.com") }

  it 'has a valid factory' do
    page.must_be_instance_of Page
  end

  it "does not creates with nil url" do
    page = FactoryGirl.build(:page, url: nil)
    page.invalid?(:url).must_equal true
    page.errors[:url].must_equal ["can't be blank", "is not a valid URL"]
  end

  it "does not creates with invalid url" do
    page = FactoryGirl.build(:page, url: "sup")
    page.invalid?(:url).must_equal true
    page.errors[:url].must_equal ["is not a valid URL"]
  end

  it "creates with valid url" do
    page = FactoryGirl.create(:page, url: "http://www.google.com")
    page.valid?(:url).must_equal true
    Page.all.count.must_equal 1
  end
end
