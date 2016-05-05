class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	
  validates_uniqueness_of :friend_id, scope: :user_id
   validate :check_user
  def check_user
    if self.friend_id == self.user_id
      errors.add(:friend, "can't be yourself")
    end
  end
end
