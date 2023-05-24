class Api::V1::OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[:show, :edit, :update, :destroy]

  def index
    @order_items = OrderItem.all

    render json: @order_items, status: :ok
  end

  def new
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    param.permit(:cart_id, :quantitiy, :book_id)
  end
end
