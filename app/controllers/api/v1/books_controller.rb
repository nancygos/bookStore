class Api::V1::BooksController < ApplicationController
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
    @book = Book.find(params[:id])

    if @book
      render json: @book, status: 200
    else
      render json: {
        error: "Book not found."
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

    # return header 
    if @book.destroy
      # head(:ok) 
      render json: "Book has beed deleted."
    else
      # head(:unprocessable_entity)
      render json: {
        error: "Cannot be deleted."
      }
    end
  end


  private

  def book_params
    params.permit(:name, :author, :price)
    # error comming in post request because of .require(:book)
  end
end

