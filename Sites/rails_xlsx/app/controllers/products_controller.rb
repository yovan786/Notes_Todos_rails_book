class ProductsController < ApplicationController
  def index
  	@products = Product.order('created_at DESC')
  	respond_to do |format|
    	format.html
    	format.xlsx
  	end
  end
end
