class LikesController < ApplicationController
	def create
		Like.create(user_id: current_user.id, micropost_id: params[:id])
		redirect_to microposts_path
	end

	def destroy
		Like.find_by(user_id: current_user.id, micropost_id: params[:id]).destroy
		redirect_to microposts_path
	end
end
