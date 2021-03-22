class CreateLikes < ActiveRecord::Migration[6.0]
	def change
		create_table :likes do |t|
			t.integer 'user_id'
			t.integer 'micropost_id'
			t.datetime 'created_at', null: false
			t.datetime 'updated_at', null: false
		end
	end
end
