class Friend < ActiveRecord::Base
	has_one :user
	has_one :friend, :class_name => "User"
end
