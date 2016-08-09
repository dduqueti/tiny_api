require 'open-uri'
require 'nokogiri'

class ParsePageService

  attr_reader :page

  def initialize(page)
    @page = page
  end

  def parse
    return page unless page.valid?
    html = open(page.url)
    doc = Nokogiri::HTML(html)
    PageElement::ELEMENT_TYPES.each do |key, value|
      doc.css(key.to_s).each do |element|
        create_element(key.to_s, element.attribute(value))
      end
    end
    page.save
    page
  end

  def create_element(type, content)
    page.page_elements.build(element_type: type, content: content)
  end

end