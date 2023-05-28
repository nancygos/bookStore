class OrderItem < ApplicationRecord
    belongs_to :cart
    belongs_to :book
    # book is a book-store

    def total_price
        book.price * quantity
    end
end
