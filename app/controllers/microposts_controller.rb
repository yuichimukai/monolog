class MicropostsController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: %i[edit update destroy]

	def index
		@feed_items = current_user.feed.paginate(page: params[:page])
	end

	def new
		@micropost = current_user.microposts.build
	end

	def create
		@micropost = current_user.microposts.build(micropost_params)
		@micropost.image.attach(params[:micropost][:image])
		if @micropost.save
			flash[:success] = 'ツイートが作成されました'
			redirect_to action: :index
		else
			@feed_items = current_user.feed.paginate(page: params[:page])
			redirect_to action: :new
		end
	end

	def show
		@micropost = Micropost.find(params[:id])
	end

	def edit; end

	def update
		if @micropost.update_attributes(micropost_params)
			redirect_to '/'
		else
			render action: :edit
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = 'ツイートが削除されました'
		redirect_to current_user
	end

	private

	def micropost_params
		params.require(:micropost).permit(:content, :image)
	end

	def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_url if @micropost.nil?
	end
end
