class ReviewsController < ApplicationController
	before_action :correct_user, only: %i[edit update]
	before_action :set_review, only: %i[edit update destroy]

	def new; end

	def create
		@item = Item.find(params[:review][:item_id])
		@review = current_user.reviews.build(review_params)
		if @review.save
			flash[:success] = '口コミを投稿しました'
			redirect_to @item
		else
			flash.now[:danger] = '口コミの投稿に失敗しました'
			render 'items/show'
		end
	end

	def destroy
		return unless @review.destroy

		flash[:success] = '口コミを削除しました'
		redirect_back(fallback_location: root_path)
	end

	def edit; end

	def update
		if @review.update(review_params)
			flash[:success] = '口コミを更新しました'
			redirect_to @review.product
		else
			flash.now[:danger] = '口コミの編集に失敗しました'
			render :edit
		end
	end

	def index; end

	private

	def review_params
		params.require(:review).permit(:title, :rate, :picture, :item_id)
	end

	def correct_user
		@review = current_user.reviews.find_by(id: params[:id])
		redirect_to reviews_path if @review.nil?
	end

	def set_review
		@review = Review.find(params[:id])
	end
end
