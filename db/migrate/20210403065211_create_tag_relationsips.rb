class CreateTagRelationsips < ActiveRecord::Migration[6.0]
	def change
		create_table :tag_relationsips do |t|
			t.references :item, foreign_key: true
			t.references :tag, foreign_key: true

			t.timestamps
		end
		add_index :tag_relationsips, %i[item_id tag_id], unique: true
	end
end
