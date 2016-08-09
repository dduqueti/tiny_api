class Page < ActiveRecord::Base

  # Relations
  has_many :page_elements, dependent: :destroy

  # Validations
  validates :url, presence: true, length: { maximum: 2000 }, url: true

  # Override as_json
  def as_json(options = { })
    h = super(options)
    h["page_elements"] = self.page_elements
    return h
  end

end
