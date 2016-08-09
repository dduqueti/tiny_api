class PagesControllerTest < ActionDispatch::IntegrationTest

	before do
		@page_one = FactoryGirl.create(:page, :with_page_elements)
		@page_two = FactoryGirl.create(:page)
	end

  it "should return list of pages and page elements on index" do
    get '/api/v1/pages', format: :json
    response.success?.must_equal true
    body.must_equal Page.all.to_json
    pages = JSON.parse(response.body)
    assert_equal 2, pages.count
    assert_equal true, pages.any?{|x| x["url"] == @page_one.url}
    assert_equal 2, pages.first["page_elements"].count
    assert_equal 0, pages.second["page_elements"].count
  end

  it "should return page on show" do
    get '/api/v1/pages', { id: @page_one.id }, format: :json
    assert_equal 200, status
    assert_response :success
    page = JSON.parse(response.body)
    assert_equal @page_one.url, page[0]['url']
  end

	it "can create a page on create" do
    assert_difference('Page.count', +1) do
	   post '/api/v1/pages', { page: { url: "http://www.google.com" } }
    end
    assert_response :success
    assert_equal 201, status
    assert_equal 3, Page.count
	end

	it "should destroy page on destroy" do
    assert_difference('Page.count', -1) do
      delete api_v1_page_url(@page_one)
    end
    assert_response :success
    assert_equal 204, status
    assert_equal 1, Page.count
    assert_equal @page_two, Page.first
  end
end