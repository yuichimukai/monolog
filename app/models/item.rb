class Item < ApplicationRecord
	belongs_to :category
	has_many :tag_relationsips, dependent: :destroy
	has_many :tags, through: :tag_relationsips

	def save_tags(saveitem_tags)
		saveitem_tags.each do |new_name|
			item_tag = Tag.find_or_create_by(name: new_name)
			self.tags << item_tag
		end
	end
end
