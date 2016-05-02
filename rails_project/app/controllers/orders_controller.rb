class OrdersController < ApplicationController
before_action :authenticate_user!
def index
	@all_orders = current_user.orders.paginate(:page => params[:page], :per_page => 3)
	@page=params[:page].to_i
	if current_user.orders.size%3 ==0
		@count=(current_user.orders.size/3).to_i
	else
		@count=(current_user.orders.size/3).to_i+1
	end
end
def upadteStatus
	
	format.html { render :index }
end

def batota
	if params[:friends] == nil
        @friends = [0,]
    else
		@friends = params[:friends]
	end
	if params[:groups] == nil
        @groups = [0,]
      else
        @groups = params[:groups]
    end

	@users = User.where("username LIKE ?","%#{params[:query]}%").where("id in (?)",current_user.friends.ids).where("id not in (?)", @friends)
	@suggestions = {suggestions: []}
	@users.each do |user|
		@suggestions[:suggestions].push({value: user.username,data: {id: user.id, picture: user.picture}})	
	end

    @matched_groups = Group.where("group_name LIKE ?","%#{params[:query]}%").where("user_id = #{current_user.id}").where("id not in (?)", @groups)
	@matched_groups.each do |group|
		@members = []
		group.group_members.each do |member|
			if !@friends.include? member.user_id.to_s
            	@members.push(User.select(:id,:username,:picture_file_name).find(member.user_id))
        	end

		end
		@suggestions[:suggestions].push({value: group.group_name,data: {id: group.id, members: @members }})	
	end	

	render json: @suggestions.to_json
end







def create
	@order = Order.new(order_params)
	@order['user_id'] = current_user.id
	@order['status'] = "waiting"
    respond_to do |format|
	  	if @order.save
         	params[:friends].each  do |friend|
          		@order.invitations.create(order_id: @order.id,user_id: friend, join: 0) 
          	end	
	        format.html { redirect_to @order, notice: 'Order was successfully created.' }
	        format.json { render :show, status: :created, location: @order }
		else
	        format.html { render :new }
	        format.json { render json: @order.errors, status: :unprocessable_entity }
	    end
	end
end

def new
	@order = Order.new
end

def edit
	
end

def update
	
end

def show
	# @order_id=params[:id]
	@order = Order.find(params[:id])
	@curentuser_invites=current_user.invitations.find_by(order_id: params[:id])
	if (@curentuser_invites != nil)
		@curentuser_join=@curentuser_invites.join
		
	end	
	@order_detail = OrderDetail.new
	@all_orders_details = @order.order_details.select(:id, :item, :amount, :price, :comment, :user_id)

end


def details
	
	@order = Order.find(params[:id])
	@invited_friends = {invites: [],creator: 0, invitations_id: []}
	@order.invitations.each do |order|
		if(order.join == 0)
			@user = User.find(order.user_id)
			@invited_friends [:invites].push(@user)
			@invited_friends[:invitations_id].push(order.id)
		end
	end	
	if(@order.user_id == current_user.id)
		@invited_friends[:creator] =1
	end		
	render json: @invited_friends
	
end


def join_details
	@order = Order.find(params[:id])
	@joined_friends = {join: [],creator: 0, invitations_id: []}
	@order.invitations.each do |order|
	if(order.join == 1)	
		@user = User.find(order.user_id)
		@joined_friends [:join].push(@user)
		@joined_friends[:invitations_id].push(order.id)
		end
	end	
	if(@order.user_id == current_user.id)
		@joined_friends[:creator] =1
	end
	render json: @joined_friends
end



def destroy
end

def delete_invitation
	
	@invitation = Invitation.find params[:id]
	@invitation.destroy
	render json: @invitation


end

private
def order_params
params.require(:order).permit(:order_title, :from, :status, :menuimage, :friends)

end

end
