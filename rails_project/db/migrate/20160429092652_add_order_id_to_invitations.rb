class AddOrderIdToInvitations < ActiveRecord::Migration
  def change
    add_reference :invitations, :order, index: true, foreign_key: true
  end
end
