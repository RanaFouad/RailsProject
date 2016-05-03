class OrderDetailsController < ApplicationController
 before_action :authenticate_user!
def index

	# @x=params[:value]
end

def create
	@order_detail = OrderDetail.new(order_detail_params)

    respond_to do |format|
	  	if @order_detail.save
	        format.html { redirect_to @order_detail.order, notice: 'Order was successfully created.' }
	        format.json { render :show, status: :created, location: @order_detail }
		else
	        format.html { render :new }
	        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
	    end
	end

	
end

def new
	@order_detail = OrderDetail.new
end

def edit
	
end

def update
	
end

def show
	@x=params[:id]	
end

def destroy
	@order_detail = OrderDetail.find params[:id]
	@order_id = @order_detail.order_id
	 @order_detail.destroy
	# redirect_to order_path(@order_id)
	render json: @order_detail
	  
end

private
def order_detail_params
params.require(:order_detail).permit(:item, :comment, :price, :amount, :user_id, :order_id)

end

end
