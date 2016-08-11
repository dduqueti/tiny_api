require 'test_helper'

class ParsePageServiceTest < ActiveSupport::TestCase

  before do
    @page_one = FactoryGirl.create(:page, url: "http://www.google.com")
    @parse_service = ParsePageService.new(@page_one.id)
    raw_response_file = File.new("#{Rails.root}/test/fixtures/all_sample_elements_fixture.txt")
    stub_request(:get, "http://www.google.com").to_return(raw_response_file)
  end

  it "parses page content from valid url" do
    page = @parse_service.parse
    assert_equal 0, page.errors.count
    assert_equal 1, Page.count
    assert_equal false, Page.first.page_elements.any? { |e| e.content.nil? }
    assert_equal false, Page.first.parsing
    assert_operator 8, :==, Page.first.page_elements.count
  end

  it "parses page content from valid url with https protocol" do
    WebMock.allow_net_connect!
    @page_one = FactoryGirl.create(:page, url: "https://www.twitter.com")
    page = ParsePageService.new(@page_one.id).parse
    assert_equal 0, page.errors.count
    assert_equal 2, Page.count
    assert_operator 0, :<, Page.last.page_elements.count
    assert_equal false, Page.last.page_elements.any? { |e| e.content.nil? }
    assert_equal false, Page.last.parsing
    assert_operator 0, :<, Page.last.page_elements.count
  end

  it "saves all expected page element types" do
    page = @parse_service.parse
    assert_equal 0, page.errors.count
    assert_equal 1, Page.count
    page_elements = Page.first.page_elements
    assert_operator 8, :==, page_elements.count
    PageElement::ELEMENT_TYPES.keys.map(&:to_s).each do |type|
      assert_equal true, page_elements.any? { |e| e.element_type.eql? type }
    end
  end
end
