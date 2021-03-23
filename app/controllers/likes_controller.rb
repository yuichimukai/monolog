class LikesController < ApplicationController
	before_action :micropost_params
	def create
		Like.create(user_id: current_user.id, micropost_id: params[:id])
	end

	def destroy
		Like.find_by(user_id: current_user.id, micropost_id: params[:id]).destroy
	end

	def micropost_params
		@micropost = Micropost.find(params[:id])
	end
end
