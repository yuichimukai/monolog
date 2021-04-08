class ItemsController < ApplicationController
	before_action :set_item, only: %i[edit update show]

	def search
		@items = []

		@item = params[:keyword]
		if @item.present?
			results = RakutenWebService::Ichiba::Item.search(keyword: @item, hits: 20)

			results.each do |result|
				item = Item.new(read(result))
				@items << item
			end
		end
	end

	def new
		@item = Item.new
		@image = params[:item][:item_image_url]
		@price = params[:item][:price]
		@link = params[:item][:url]
	end

	def create
		@item = Item.new(item_params)
		tag_list = params[:item][:tag_ids].split(nil)
		if @item.save
			@item.save_tags(tag_list)
			flash[:success] = '商品を登録しました'
			redirect_to items_path
		else
			render :new
		end
	end

	def show
		@review = Review.new
		@reviews =
			Review.includes(:user, :item).where(item_id: @item.id).page(params[:page])
	end

	def index
		@items = Item.all.page(params[:page])
	end

	def destroy
		@item = Item.find_by(id: params[:item_id])
		flash[:success] = '商品を削除しました' if @item.destroy
		redirect_back(fallback_location: items_path)
	end

	def edit; end

	def update
		if @item.update(item_params)
			flash[:success] = 'アイテムを更新しました'
			redirect_to @item
		else
			render :edit
			flash.now[:danger] = 'アイテムの更新に失敗しました'
		end
	end

	private

	def read(result)
		item_name = result['itemName']
		item_image_url = result['mediumImageUrls'][0]
		item_url = result.url
		price = result.price

		{
			item_name: item_name,
			item_url: item_url,
			item_image_url: item_image_url,
			price: price,
		}
	end

	def item_params
		params
			.require(:item)
			.permit(:item_image_url, :price, :item_url, :item_name, :category_id)
	end

	def set_item
		@item = Item.find(params[:id])
	end
end
