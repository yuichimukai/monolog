class Tag < ApplicationRecord
	has_many :tag_relationsips, dependent: :destroy
	has_many :item, through: :tag_relationships
	validates :name, uniqueness: true
end
