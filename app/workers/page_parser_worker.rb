class PageParserWorker

  @queue = :default

  def self.perform(page_id)
  	ParsePageService.new(page_id).parse
  end
end