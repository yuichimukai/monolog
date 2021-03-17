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
	          uniqueness: {
			case_sensitive: :false,
	          },
	          length: {
			minimum: 2,
			maximum: 20,
	          }
	validates :profile, length: { maximum: 200 }
	attr_accessor :login

	#アップロード画像の紐付け
	has_one_attached :avatar

	#avatarのバリデーション
	# validate :validate_avatar

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
