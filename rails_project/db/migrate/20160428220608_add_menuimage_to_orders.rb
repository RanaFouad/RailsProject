class AddMenuimageToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.attachment :menuimage
    end
  end

  def self.down
    drop_attached_file :orders, :menuimage
  end
end
