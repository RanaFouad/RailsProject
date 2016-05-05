class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
    ary = Array.new
   # @friends_data=User.joins(:friends)
    ##############get Data From user###########
    @Data=Friendship.where('user_id=?',current_user.id)
    @friends_data=current_user.friends
  

    @friendship = Friendship.new

   
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendships = Friendship.all
    @friends= Friendship.where("user_id = ?",current_user.id )

    @friendship = Friendship.new
     @friends_data=current_user.friends
  
    redirect_to @friendship
  

  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
      redirect_to @friendship
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
  
    @friendship = Friendship.create(params.require(:friendship).permit(:friend_id))
    @friend_id = params[:friendship][:friend_id]
    if User.find_by(email: @friend_id)

       user = User.find_by(email: @friend_id).id
        if user_signed_in?  
        @friendship.user_id=current_user.id
        @friendship.friend_id= user
        @friendship.save()
        redirect_to @friendship
      end
      ##############End of else###########
    else
        redirect_to @friendship ,notice: "Wrong Mail or user Not found"
    end
   
  
   

  
  ##################33New Function 
    def new
  @friendship = Friendship.new
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
    if @friend
      @friend.destroy
    else
     @friendship.destroy
    end
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.fetch(:friendship, {})
      params.require(:friendship).permit(:friend_email)
    end
end
