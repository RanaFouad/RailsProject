class GroupMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group_member, only: [:show, :edit, :update, :destroy]

  # GET /group_members
  # GET /group_members.json
  def index
    @group_members = GroupMember.all
  end

  # GET /group_members/1
  # GET /group_members/1.json
  def show
  end

  # GET /group_members/new
  def new
    @group_member = GroupMember.new
  end

  # GET /group_members/1/edit
  def edit
  end

  # POST /group_members
  # POST /group_members.json
  def create
   
    @group_member = GroupMember.new(params.require(:group_member).permit(:user_id,:group_id))
    @friend_id = params[:group_member][:user_id]
    if User.find_by(email: @friend_id)
    user = User.find_by(email: @friend_id).id
    if user_signed_in?  
    @group_member.user_id=user
    @group_member.group_id= params[:group_member][:group_id]
    @group_member.save()
    redirect_to :controller => 'groups', :action => 'show', :id =>  params[:group_member][:group_id]
  end
  else
       redirect_to :controller => 'groups', :action => 'show', :id =>  params[:group_member][:group_id] , notice: "Wrong Mail or user Not found"
    end
   

  end

  # PATCH/PUT /group_members/1
  # PATCH/PUT /group_members/1.json
  def update
    respond_to do |format|
      if @group_member.update(group_member_params)
        format.html { redirect_to @group_member, notice: 'Group member was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_member }
      else
        format.html { render :edit }
        format.json { render json: @group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.json
  def destroy
   
    @gro_mem = GroupMember.find params[:id]
    @gro_num=@gro_mem.group_id
    @group_member = GroupMember.new
    
    @gro_mem.destroy
    redirect_to :controller => 'groups', :action => 'show', :id => @gro_num
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_member
      @group_member = GroupMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_member_params
      params.fetch(:group_member, {})
    end
end
