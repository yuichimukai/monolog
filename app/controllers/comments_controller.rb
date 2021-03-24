class CommentsController < ApplicationController
	def create
		@micropost = Micropost.find(params[:micropost_id])
		@comment = @micropost.comments.build(comment_params)
		@comment.user_id = current_user.id
		@comment.save
		render :index
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		render :index
	end

	private

	def comment_params
		params.require(:comment).permit(:text, :micropost_id, :user_id)
	end
end
