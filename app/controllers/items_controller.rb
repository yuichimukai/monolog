class ItemsController < ApplicationController
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
		if @item.save
			redirect_to root_path
		else
			render :new
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
		params.require(:item).permit(:item_image_url, :price, :item_url, :item_name)
	end
end
