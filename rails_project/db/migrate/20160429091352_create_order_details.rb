class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.string :item
      t.integer :amount
      t.decimal :price
      t.string :comment

      t.timestamps null: false
    end
  end
end
