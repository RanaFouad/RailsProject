class AddOrderIdToOrderDetails < ActiveRecord::Migration
  def change
    add_reference :order_details, :order, index: true, foreign_key: true
  end
end
