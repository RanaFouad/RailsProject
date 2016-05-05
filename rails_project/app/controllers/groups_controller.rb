class GroupsController < ApplicationController
	  before_action :authenticate_user!
	  before_action :set_group, only: [:show, :edit, :update, :destroy]

 def index
	 @groups = current_user.groups

    @group = Group.new
    @group_member = GroupMember.new
		  

 end 
 ################# Create
 def create
  
    @group = Group.create(params.require(:group).permit(:group_name))
    @group_name = params[:group][:group_name]


   
    if user_signed_in?  
    @group.user_id=current_user.id
    @group.group_name= @group_name
    @group.save()
     redirect_to @group
  

end
end


##########################Show
def show
   @groups = current_user.groups @group = Group.new
  
   @groups_member=Group.find(params[:id]).group_members
   @group_data=Group.find(params[:id])

    render('index')
  
  
 
  

 end
  
   


    #####################New 
 def new
       @group = Group.new
      redirect_to @Group
  end
  ###################Destroy
  def destroy
    if @group_data
      @group_data.destroy
    end

       @group.destroy
        redirect_to @group
      
    end

 def set_group

      @group = Group.find(params[:id])
    end
end

