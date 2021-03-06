require 'open-uri'
require 'nokogiri'
require 'openssl'

class ParsePageService

  attr_reader :page, :data

  def initialize(page_id)
    @page = Page.find(page_id)
  end

  def parse
    return page unless page.valid?
    PageElement::ELEMENT_TYPES.each do |key, value|
      data.css(key.to_s).each do |element|
        content = fetch_content(element, value)
        create_element(key.to_s, content) if content
      end
    end
    page.parsing = false
    page.save
    page
  end

  def fetch_content(element, value)
    if PageElement::ELEMENT_ATTRIBUTES.include? value.to_s
      element.attribute(value)
    else
      element.send(value.to_s)
    end
  end

  def create_element(type, content)
    page.page_elements.build(element_type: type, content: content)
  end

  def data
    @data ||= Nokogiri::HTML(open(page.url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
  end
end