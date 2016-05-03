class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	orders = current_user.orders.last(3)
  	@myorders=[]
  	i=0
  	orders.each do |order| 
	  	linkorder=[]
	  	linkorder[0]=order.order_title + " on " + order.created_at.to_s
	  	linkorder[1]=order
	  	@myorders[i]=linkorder
	  	i=i+1;
	end 
  	@myfriendsActivity = current_user.friends
  end
end
