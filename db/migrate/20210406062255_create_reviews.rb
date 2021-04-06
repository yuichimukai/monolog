class CreateReviews < ActiveRecord::Migration[6.0]
	def change
		create_table :reviews do |t|
			t.string :title
			t.text :content
			t.string :rate
			t.references :user, foreign_key: true
			t.references :item, foreign_key: true

			t.timestamps
		end
	end
end
