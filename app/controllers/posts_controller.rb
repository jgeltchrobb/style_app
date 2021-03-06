class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order(:created_at).reverse_order
    filter_params.each do |key,value|
      @posts = @posts.public_send(key, value) if value.present?
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # render plain: post_params.inspect
  end

  # GET /posts/new
  def new
    not_authorised and return unless current_user.can_create?(@post)
    finish_profile and return unless current_user.completed_profile?
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    not_authorised and return unless current_user.can_update?(@post)    
  end

  # POST /posts
  # POST /posts.json
  def create
    not_authorised and return unless current_user.can_create?(@post)
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    not_authorised and return unless current_user.can_update?(@post)

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    not_authorised and return unless current_user.can_delete?(@post)

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:id, :title, :content, :image, :owner_role, :profile_id, :user_id)
    end

    def filter_params
      params.slice(:title, :content, :owner_role)
    end

    def finish_profile
      flash[:notice] = "You need to complete your profile before you can post"
      redirect_to edit_profile_path(current_user.profile.id)
    end

    def not_authorised
      flash[:notice] = "You are not authorised!"
      redirect_to posts_path
    end
    
end
