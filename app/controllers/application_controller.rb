class ApplicationController < ActionController::Base
	# ログイン済ユーザーのみにアクセスを許可する
	# before_action :authenticate_user!

	#csrf対策
	protect_from_forgery with: :exception

	# deviseコントローラーにストロングパラメータを追加する
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		added_attrs = %i[email username password password_confirmation]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		devise_parameter_sanitizer.permit :account_update, keys: added_attrs
		devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
	end
end
