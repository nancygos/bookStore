class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :cart_id
      t.integer :book_id
      t.integer :quantity , :default => 1

      t.timestamps
    end
  end
end
