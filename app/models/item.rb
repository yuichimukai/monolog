class Item < ApplicationRecord
	has_many :review
	has_many :favorite
end
