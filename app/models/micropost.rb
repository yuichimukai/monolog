class Micropost < ApplicationRecord
	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy

	#通知モデルとの関連づけ
	has_many :notifications, dependent: :destroy

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

	#いいね通知作成
	def create_notification_like!(current_user)
		# すでに「いいね」されているか検索
		temp =
			Notification.where(
				[
					'visitor_id = ? and visited_id = ? and micropost_id = ? and action = ? ',
					current_user.id,
					user_id,
					id,
					'like',
				],
			)

		# いいねされていない場合のみ、通知レコードを作成
		if temp.blank?
			notification =
				current_user.active_notifications.new(
					micropost_id: id,
					visited_id: user_id,
					action: 'like',
				)

			# 自分の投稿に対するいいねの場合は、通知済みとする
			if notification.visitor_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end

	#コメント作成通知
	def create_notification_comment!(current_user, comment_id)
		# 自分以外にコメントしている人をすべて取得し、全員に通知を送る
		temp_ids =
			Comment
				.select(:user_id)
				.where(micropost_id: id)
				.where
				.not(user_id: current_user.id)
				.distinct
		temp_ids.each do |temp_id|
			save_notification_comment!(current_user, comment_id, temp_id['user_id'])
		end

		# まだ誰もコメントしていない場合は、投稿者に通知を送る
		if temp_ids.blank?
			save_notification_comment!(current_user, comment_id, user_id)
		end
	end

	def save_notification_comment!(current_user, comment_id, visited_id)
		# コメントは複数回することが考えられるため、１つの投稿に複数回通知する
		notification =
			current_user.active_notifications.new(
				micropost_id: id,
				comment_id: comment_id,
				visited_id: visited_id,
				action: 'comment',
			)

		# 自分の投稿に対するコメントの場合は、通知済みとする
		if notification.visitor_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end
end
