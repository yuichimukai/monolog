class ReviewsController < ApplicationController
	#before_action :authenticate_user!
	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		if @review.save
			redirect_to item_reviews_path(@review.item)
		else
			@item = Item.find(params[:item_id])
			render 'items/show'
		end
	end

	private

	def review_params
		params.require(:review).permit(:item_id, :rate, :title)
	end
end
