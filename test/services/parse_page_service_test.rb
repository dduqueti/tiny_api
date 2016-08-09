require 'test_helper'

class ParsePageServiceTest < ActiveSupport::TestCase

  before do
    @page_one = FactoryGirl.build(:page, url: "http://www.google.com")
    @parse_service = ParsePageService.new(@page_one)
  end

  it "parses page content from valid url" do
    page = @parse_service.parse
    assert_equal 1, Page.count
    assert_operator 0, :<, Page.first.page_elements.count
    assert_equal false, Page.first.page_elements.any? { |e| e.content.nil? }
  end

  it "delivers errors when invalid url" do
    page = FactoryGirl.build(:page, url: "google.com")
    page = ParsePageService.new(page).parse
    assert_equal false, page.valid?
    assert_operator page.errors.count, :>, 0
  end
end
