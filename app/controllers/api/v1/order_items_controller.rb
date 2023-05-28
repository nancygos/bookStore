class Api::V1::OrderItemsController < ApplicationController
  # before_action :set_order_item, only: %i[:show, :edit, :update, :destroy] 

  def index
    @order_items = OrderItem.all

    render json: @order_items, status: :ok
  end

  def new
    @order_item = OrderItem.new
  end

  def show
    @order_item = OrderItem.find(params[:id])

    if @order_item
      render json: @order_item , status: :ok
    else
      render json: {error: "Order doesnot exist."} , status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @order_item = OrderItem.find_by(id: params[:id])

    if @order_item.update(order_item_params)
      render json: {message: "Cart is updated successfully"} , status: :ok
    else
      render json: {error: "Cart cannot be updated"}
    end
  end

  def create
    @cart = current_cart(params[:cart_id] )
    # @acart = Cart.find_by(id: params[:cart_id])
    @product = Book.find_by(id: params[:book_id])

    @order_item = @cart.add_product(@product.id)  # add_product method in model cart

    if @order_item.save
      render json: {:show => "show"}, status: :ok
    else
      render json: {error: "Book cannot be added"}
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    if @order_item
      @order_item.destroy
      render json: {message: "Order is destroyed"} , status: :ok
    end
  end

  private

  def order_item_params
    params.permit(:cart_id, :quantitiy, :book_id)
  end

end
