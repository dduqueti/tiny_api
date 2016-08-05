class Page < ActiveRecord::Base

	# Relations
	has_many :page_elements

	# Validations
	validates :url, presence: true, length: { maximum: 2000 }
end
