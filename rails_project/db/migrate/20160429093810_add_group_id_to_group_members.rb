class AddGroupIdToGroupMembers < ActiveRecord::Migration
  def change
    add_reference :group_members, :group, index: true, foreign_key: true
  end
end
