class Cart < ApplicationRecord
    has_many :order_item , :dependent => :destroy         # if cart destroys order item(all books) is also destroyed
    
    def add_product(book_id)
        current_item = order_items.find_by_book_id(book_id)
        if current_item
            current_item.quantity += 1
        else
            current_item = order_items.build(:book_id => book_id)
        end
        current_item
    end

    def total_price
        order_items.to_a.sum{
            |item| item.total_price
        }
    end
end
