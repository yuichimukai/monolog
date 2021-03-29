class CreateItems < ActiveRecord::Migration[6.0]
	def change
		create_table :items do |t|
			t.string 'title'
			t.text 'url'
			t.string 'image_url'
			t.string 'asin'
			t.string 'price'
			t.string 'brand_amazon_name'
			t.text 'offficial_url'
			t.string 'brand_id'
			t.string 'category_id'
			t.string 'point'
			t.timestamps
		end
	end
end
