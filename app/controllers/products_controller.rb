class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
    respond_to do |format|
      format.html {  }
      format.json { render json: ::ProductsDatatable.new(view_context) }
      format.js { }
    end
  end

  def show
    respond_to do |format|
      format.html {  }
      format.json { render json: @product.to_json }
      format.js { }
    end
  end

  def new
    @product = Product.new()
  end

  def edit
    respond_to do |format|
      format.html { redirect_to @product }
      format.js { render action: 'edit'}
    end
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.js { render action: 'redraw'}
      else
        format.html { render :new }
        format.js { render action: 'new'}
      end
    end
  end


  def update
    @product.assign_attributes(product_params)
    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.js { render action: 'redraw'}
      else
        format.html { redirect_to @product }
        format.js { render action: 'edit'}
      end
    end
  end

  def destroy
    if @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully deleted.' }
        format.js { render action: 'redraw'}
      end
    else
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product could not be deleted.' }
        format.js { render action: 'redraw'}
      end
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      parameters = params.require(:product).permit(:name, :price, :category)
      return parameters
    end
end
