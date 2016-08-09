class PageElement < ActiveRecord::Base

	ELEMENT_TYPES = %w(h1 h2 h3 a)

	# Relations
  belongs_to :page

  # Validations
  validates :element_type, presence: true, inclusion: { in: ELEMENT_TYPES }
  validates :page, presence: true
end
