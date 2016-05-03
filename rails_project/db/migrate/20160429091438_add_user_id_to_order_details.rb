class AddUserIdToOrderDetails < ActiveRecord::Migration
  def change
    add_reference :order_details, :user, index: true, foreign_key: true
  end
end
