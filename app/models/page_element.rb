class PageElement < ActiveRecord::Base

  ELEMENT_TYPES = { h1: 'text', h2: 'text', h3: 'text', a: 'href'}
  ELEMENT_ATTRIBUTES = %w(href)

  # Relations
  belongs_to :page

  # Validations
  validates :element_type, presence: true, inclusion: { in: ELEMENT_TYPES.keys.map(&:to_s) }
  validates :page, presence: true
end
