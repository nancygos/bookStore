class Api::V1::CartsController < ApplicationController
  # before_action :set_cart, only: %i[:show, :edit, :destroy, :update]

  def index
    @carts = Cart.all
  end

  def new
  end

  def show
    @cart = Cart.find(params[:id])

    if @cart
      render json: @cart , status: :ok
      session[:amount] = cart.total_price
    else 
      render json: {error: "This cart id doesnot exist."} , status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @cart = Cart.find(params[:id])

    if @cart.update
      render json: {message: "Cart is updated."}, status: :ok
    else
      render json: {error: "Cart cannot be updated"} , status: :unprocessable_entity
    end
  end

  def create
    @cart = Cart.new(cart_params)
    # token = encode_user_data({ user_data: @cart.id })

    if @cart.save
      # render json: {token: token, message: "Cart is created successfully. This token can be used to find current cart."} , status: :ok
      render json: {message: "Cart is created successfully with id: #{@cart.id}."} , status: :ok
    else
      render json: {error: "Cart can not be created"} , status: :unprocessable_entity
    end
  end

  def destroy
    @cart = Cart.find_by(id: params[:id])
    if @cart
      @cart.destroy
      # session.delete(:cart_id)->with token
      render json: {message: "Cart is destroyed with id: #{@cart.id}"} , status: :ok
    else
      render json: {message: "There is no cart present with id: #{params[:id]} ."}
    end
  end

  # def checkout
  #   @cart = Cart.find_by(id: params[:id])

  #   if @cart
  #     amount_to_charge = 
  end

  private

  def cart_params
    params[:cart]
  end
end
