class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_title
      t.string :from
      t.string :status

      t.timestamps null: false
    end
  end
end
