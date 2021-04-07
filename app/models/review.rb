class Review < ApplicationRecord
	belongs_to :user
	belongs_to :item

	validates :title, presence: true, length: { maximum: 50 }
	validates :rate, presence: true
	validates :content, length: { maximum: 300 }
	# validates :user_id, uniquness: {scope: {:item_id}}
end
