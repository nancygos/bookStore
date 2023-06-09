class Api::V1::CartsController < ApplicationController
  # before_action :set_cart, only: %i[:show, :edit, :destroy, :update]
  before_action :user_logged_in? , only: [:checkout, :order_history] 

  def index
    @carts = Cart.all
  end

  def new
  end

  def show
    @cart = Cart.find_by(id: params[:id])

    if @cart
      amount_to_charge = @cart.total_price
      cart_items = @cart.order_items        #all the items present in cart

      # Rendering multiple things
      render json: { 
        :cart => @cart, 
        :cart_items => cart_items, 
        :amount_to_charge => amount_to_charge 
      } , status: :ok
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


  def user_logged_in?
    if current_user
      if current_user.role == 1
        render json: {error: "Admin cannot place orders."}, status: :unauthorized
      elsif current_user.role == 0
        true
      end

    else
      render json: {error:" Login first."}
    end
  end


  def checkout
    @cart = Cart.find_by(id: params[:id])
    # order_placed(@cart.id)
    if @cart
      amount_to_charge = @cart.total_price
      render json: {message: "Order placed successfully of total ammount of Rs #{amount_to_charge}."},  status: :ok
    else
      render json: {error: "Cart id does not exit"} , status: :unprocessable_entity
    end
  end

  # #######################################################################################
  # def order_history
  #   # placed = @cart.order_placed(cart_id)
  #   render json: call_order_history
  # end

  private

  def cart_params
    params[:cart]
  end
end
