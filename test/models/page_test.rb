require 'test_helper'

class PageTest < ActiveSupport::TestCase

	let(:page) { FactoryGirl.create(:page, url: "http://www.google.com") }

  it 'has a valid factory' do
    page.must_be_instance_of Page
  end

  it "does not creates with nil url" do
    page = FactoryGirl.build(:page, url: nil)
    page.invalid?(:url).must_equal true
    page.errors[:url].must_equal ["can't be blank"]
  end
end
