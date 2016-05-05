class GroupMember < ActiveRecord::Base
	belongs_to :group
  	belongs_to :user
    validates_associated :group
     validates_uniqueness_of :user_id, scope: :group_id

 
end
