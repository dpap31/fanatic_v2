class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :role]
  respond_to :html, :json
  # GET /users
  # GET /users.json
  def index
   @user = current_user
   @trending_authors = User.all.sort_by { |u| [-u.reputation_for(:votes).to_i] }.first(5)
   @followed_authors = User.all.sort_by { |u| [-u.friendships.count] }.first(5)
   @top_authors = User.all.sort_by { |u| [-u.posts.count] }.first(5)
   @recommended_authors = recommended_authors(current_user).first(5)
   @users = User.all
   respond_to do |format|
     format.json { render :json => @users.as_json(:only => [:id, :name, :username, :image])} 
     format.html { render :html => @users}
   end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = current_user
    @teams = current_user.teams
    @my_posts = current_user.posts.limit(6)
    @my_posts_count = current_user.posts.count
    @my_posts_cheers = current_user.reputation_for(:votes).to_i
    # Used SQL so current user doesnt appear in their own activity log ("owner_id != ?", current_user.id)
    # Mapped current_users friendships ID so only friend will appear in activity feed. 
    @activities = PublicActivity::Activity.limit(15).order("created_at desc").where(owner_id: current_user.friendships.all.map {|x| x.friend_id}).where("owner_id != ?", current_user.id)
    @recommended_authors = recommended_authors(current_user).first(8)
    @hot_posts = hottness(Post.all).first(6)
  end

  # GET /users/new
  def new
    @user = current_user
  end

  # GET /users/1/edit
  def edit
    @user = current_user
    respond_with @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

# Used to get all posts created by a specific user
  def posts
    @user = User.find_by_id(params[:id])
    @teams = @user.teams
    @posts = @user.posts.page(params[:page]).per_page(12)
  end

private
    def hottness(post)
      post.sort_by {|p| (((p.reputation_for(:votes).to_i + p.comments.count)-1)/((Time.now - p.created_at) / 1.hour.round+2)**1.5)}.reverse
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit(:id, :username, :first_name, :last_name, :email, :name, :image, :search, :role, :description, team_ids: [])
    end
  end

