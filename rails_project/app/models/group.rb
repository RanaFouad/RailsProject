class Group < ActiveRecord::Base
	belongs_to :user
	has_many :group_members, :dependent => :delete_all
	validates_uniqueness_of :group_name, scope: :user_id
end
