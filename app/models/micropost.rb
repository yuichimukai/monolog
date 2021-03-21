class Micropost < ApplicationRecord
	belongs_to :user

	#activestorage
	has_one_attached :image

	#micropost順序付け
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :content, length: { maximum: 140 }
	validates :image,
	          content_type: {
			in: %w[image/jpeg image/gif image/png],
			message: 'フォーマットを正しいものにしてください',
	          },
	          size: {
			less_than: 5.megabytes,
			message: '5MBより小さいものを投稿してください',
	          }

	def user
		return User.find_by(id: self.user_id)
	end

	#表示用のリサイズ済み画像を返すメソッド
	def display_image
		image.variant(resize_to_limit: [500, 500])
	end
end
