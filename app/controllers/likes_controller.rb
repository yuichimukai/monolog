class LikesController < ApplicationController
	before_action :set_micropost

	def create
		#いいねボタンを連打しても1回しかいいね出来ない様に条件付与
		unless @micropost.liked_by?(current_user)
			like = current_user.likes.new(book_id: @book.id)
			like.save
			redirect_to @micropost
		end
	end

	def destroy
		like = current_user.likes.find_by(micropost_id: @micropost.id)
		like.destroy
		redirect_to @micropost
	end

	private

	def set_user
		@micropost = Micropost.find(params[:micropost_id])
	end
end
