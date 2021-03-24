class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable,
	       :registerable,
	       :recoverable,
	       :rememberable,
	       :validatable,
	       authentication_keys: [:login]
	validates :username,
	          presence: true,
	          uniqueness: {},
	          length: {
			minimum: 2,
			maximum: 20,
	          }
	validates :profile, length: { maximum: 200 }
	attr_accessor :login

	#アップロード画像の紐付け
	has_one_attached :avatar

	#micropostとの関連付け
	has_many :microposts, dependent: :destroy

	#likeとの関連づけ
	has_many :likes, dependent: :destroy

	#コメントとの関連付け
	has_many :comments, dependent: :destroy

	#能動的関係に関しての関連づけ
	has_many :active_relationships,
	         class_name: 'Relationship',
	         foreign_key: 'follower_id',
	         dependent: :destroy
	has_many :passive_relationships,
	         class_name: 'Relationship',
	         foreign_key: 'followed_id',
	         dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

	#ログイン認証の書き換え(ユーザー名でもメールアドレスでもログインできるようにする)
	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions)
				.where(
					[
						'username = :value OR lower(email) = lower(:value)',
						{ value: login },
					],
				)
				.first
		else
			where(conditions).first
		end
	end

	#devise password入力なしでユーザー情報の更新を行う
	def update_without_current_password(params, *options)
		params.delete(:current_password)

		if params[:password].blank? && params[:password_confirmation].blank?
			params.delete(:password)
			params.delete(:password_confirmation)
		end

		result = update_attributes(params, *options)
		clean_up_passwords
		result
	end

	# 試作feedの定義
	def feed
		following_ids =
			'SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id'
		Micropost.where(
			"user_id IN (#{following_ids})
                     OR user_id = :user_id",
			user_id: id,
		)
	end

	#ユーザーをフォロー
	def follow(other_user)
		unless self == other_user
			self.active_relationships.find_or_create_by(followed_id: other_user.id)
		end
	end

	#ユーザーをフォロー解除
	def unfollow(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy
	end

	#現在のユーザーがフォローしていたらtrueを返す
	def following?(other_user)
		self.following.include?(other_user)
	end

	def liked_by?(micropost_id)
		likes.where(micropost_id: micropost_id).exists?
	end
	# #avatarのバリデーション内容
	# def validate_avatar
	# 	return unless avatar.attached?

	# 	#画像サイズの制限
	# 	if avatar.blob.byte_size > 10.megabytes
	# 		#エラーメッセージはi18nから取得
	# 		errors.add(:avatar, :file_too_large)
	# 	else
	# 		!image?
	# 		errors.add(:avatar, :file_type_not_image)
	# 	end
	# end

	# #拡張子でファイルの種類確認
	# def image?
	# 	avatar.content_type.in?('"image/jpeg image/jpg image/png"')
	# end
end
