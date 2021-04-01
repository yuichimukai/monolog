class CreateItems < ActiveRecord::Migration[6.0]
	def change
		create_table :items do |t|
			t.string :item_name
			t.text :item_url
			t.string :item_image_url
			t.string :price
			t.string :brand_id
			t.string :category_id
			t.timestamps
		end
	end
end
