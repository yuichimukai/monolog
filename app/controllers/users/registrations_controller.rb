# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
	before_action :configure_sign_up_params, only: [:login]
	before_action :ensure_normal_user, only: %i[update destroy]

	# before_action :configure_account_update_params, only: [:update]
	# GET /resource/sign_up
	# def new
	#   super
	# end
	# POST /resource
	# def create
	#   super
	# end
	# GET /resource/edit
	# def edit
	#   super
	# end
	# PUT /resource
	# def update
	#   super
	# end
	# DELETE /resource
	# def destroy
	#   super
	# end
	# GET /resource/cancel
	# Forces the session data which is usually expired after sign
	# in to be expired now. This is useful if the user wants to
	# cancel oauth signing in/up in the middle of the process,
	# removing all OAuth session data.
	# def cancel
	#   super
	# end
	# protected
	# If you have extra params to permit, append them to the sanitizer.
	def configure_sign_up_params
		devise_parameter_sanitizer.permit(:sign_up, keys: [:login])
	end

	def following
		@title = 'フォロー'
		@user = User.friendly.find(params[:id])
		@users = @user.following
		render 'show_follow'
	end

	def followers
		@title = 'フォロワー'
		@user = User.friendly.find(params[:id])
		@users = @user.followers
		render 'show_follow'
	end

	#ゲストユーザーが削除機能を利用できないようにする
	def ensure_normal_user
		if resource.email == 'guest@example.com'
			redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません'
		end
	end

	# If you have extra params to permit, append them to the sanitizer.
	# def configure_account_update_params
	#   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
	# end
	# The path used after sign up.
	# def after_sign_up_path_for(resource)
	#   super(resource)
	# end
	# The path used after sign up for inactive accounts.
	# def after_inactive_sign_up_path_for(resource)
	#   super(resource)
	# end

	protected

	def update_resource(resource, params)
		resource.update_without_current_password(params)
	end
end
