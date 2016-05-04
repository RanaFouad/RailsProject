class InvitationsController < ApplicationController

def join
	@invitation = Invitation.find(params[:id])
	@invitation.update(join: 1)
	redirect_to order_path(@invitation.order_id) 
	
end

end
