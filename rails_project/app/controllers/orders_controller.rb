class OrdersController < ApplicationController
before_action :authenticate_user!
def index
	# @x=params[:value]
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
	@order = Order.find params[:id]
	@users = User.all	
end

def destroy
end

private
def order_params
params.require(:order).permit(:order_title, :from, :status, :menuimage, :friends)

end

end
