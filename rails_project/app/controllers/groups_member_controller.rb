class GroupsMemberController < ApplicationController

  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    @group_member= GroupMember.all
    
  

    @group_member = GroupMember.new

   
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendships = GroupMember.all
    @friends= GroupMember.where("user_id = ?",current_user.id )

    @group_member = GroupMember.new
     @friends_data=current_user.friends
  
    redirect_to @friendship
  

  end

  # GET /friendships/new
  def new
    @group_member = GroupMember.new
      redirect_to @friendship
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
  
@group_member = GroupMember.new(params)
    @group_memb = params[:q]
    @group_id=params[:group_id]

    user = User.find_by(email: @group_memb).id
    if user_signed_in?  
    @group_member.user_id=current_user.id
    @group_member.group_id=  @group_id
    @group_member.save()
    redirect_to :controller => 'groups', :action => 'show', :id => @gro_num

  
   

    end
    def new
  @group_member = GroupMember.new
end

  
  
 
    

    
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @gro_mem = GroupMember.find params[:id]
    @gro_num=@gro_mem.group_id
    @group_member = GroupMember.new
    
    @gro_mem.destroy
    redirect_to :controller => 'groups', :action => 'show', :id => @gro_num
    #redirect_to groups_path(id: @gro_num )
 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group_member = GroupMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.fetch(:friendship, {})
      params.require(:friendship).permit(:friend_email)
    end
end

  