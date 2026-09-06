class V1::BooksController < ApplicationController
  # before_action :authentication
  before_action :admin_logged_in? , only: [:new, :edit, :show, :destroy, :update]

  def index
    @books = Book.all 
    render json: @books, status: :ok
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def show
    # id as a hidden param pass hoti hai
    @book = Book.find(params[:id])

    if @book
      render json: @book, status: 200
    else
      render json: {
        error: "Book not found.", 
        status: :unauthorized
      }
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      render json: @book, status: :ok
    else
      render json: {
        error: "Book cannot be updated."
      }
    end
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book , status: :created
    else 
      render json: {
        error: "Book can not be created."
      }
    end
  end

  def destroy
    @book = Book.find(params[:id])

    if @book.destroy
      render json: "Book has beed deleted."
    else
      render json: {
        error: "Cannot be deleted."
      }
    end
  end

  def admin_logged_in?
    if !current_user
      render json: {message: "You need to login as an Admin first."} , status: :unauthorized
    elsif current_user and current_user.role == 1
      true
    else 
      render json: {message: "current user is not an Admin"} , status: :unauthorized
    end
  end

  # using redis cache to store the best seller books
  def best_seller_books
    @best_seller_books = Rails.cache.fetch("top_3_books", expires_in: 20.minutes) do
      Book.joins(:order_items).group(:book_id).order("sum(order_items.quantity) DESC").limit(3).as_json
    end
    render json: @best_seller_books, status: :ok
  end

  private

  def book_params
    params.permit(:name, :author, :price)
    # error comming in post request because of .require(:book)
  end
end

