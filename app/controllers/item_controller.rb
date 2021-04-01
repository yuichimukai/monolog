class ItemController < ApplicationController
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

	def create; end

	def new
		@image = params[:item][:item_image_url]
		@link = params[:item][:url]
		@price = params[:item][:price]
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
end
