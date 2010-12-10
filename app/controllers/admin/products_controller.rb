class Admin::ProductsController < Admin::ApplicationController
  
  unloadable
  
  before_filter :set_current_tab

  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
    
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @product = Product.new(params[:product])
    @product.save
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @product = Product.find(params[:id])

    if params[:previous] =~ /(\d+)\z/
      @previous = Product.find($1)
    end

    rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @product
  end
  
  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destory
    respond_to do |format|
      format.js
    end
  end
  
end