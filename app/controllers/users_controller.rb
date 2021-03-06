class UsersController < ApplicationController
	before_action :authenticate_user!,
	              only: %i[index show edit update destroy following followers]
	before_action :correct_user, only: %i[edit update]
	before_action :admin_user, only: :destroy

	def index
		@users = User.all.page(params[:page])
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.page(params[:page])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.avatar.attach(params[:avatar]) if @user.avatar.blank?
		if @user.update(user_params) && @user.save
			flash[:success] = 'プロフィールが更新されました'
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = 'ユーザーを削除しました'
		redirect_to users_path
	end

	def following
		@title = 'フォロー'
		@user = User.find(params[:id])
		@users = @user.following.page(params[:page]).per(10)
		render 'show_follow'
	end

	def followers
		@title = 'フォロワー'
		@user = User.find(params[:id])
		@users = @user.followers.page(params[:page]).per(10)
		render 'show_follow'
	end

	private

	def user_params
		params.require(:user).permit(:username, :profile, :avatar)
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless @user == current_user
	end

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
