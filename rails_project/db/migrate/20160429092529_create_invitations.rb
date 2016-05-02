class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :join

      t.timestamps null: false
    end
  end
end
