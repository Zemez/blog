class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_authorized, only: [:create, :new, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.includes(:user).page(params[:page]).per(5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.order(:created_at).page(params[:page]).per(5)
  end

  # GET /posts/new
  def new
    @post_user = current_user
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    # @post = Post.find(params[:id])
    @post_user = @post.user
    # respond_to do |format|
    #   if !(@post.user == current_user and current_user.creator or current_user.moderator)
    #     format.html { redirect_to :post, alert: t('message.you_are_not_authorized_to_edit_this_post.') }
    #   end
    # end
  end

  # POST /posts
  # POST /posts.json
  def create
    # @post_params = post_params
    # @post_params[:user_id] = current_user.id
    # @post_params[:visible] &&= current_user.moderator 
    @post = Post.new(force_params)
    respond_to do |format|
      if @post.user == current_user and current_user.creator or current_user.moderator 
        if @post.save
          format.html { redirect_to @post, notice: t('message.post_was_successfully_created.') }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to :posts, alert: t('message.you_are_not_authorized_to_create_posts.') }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.user == current_user and current_user.creator or current_user.moderator 
        if @post.update(force_params)
          format.html { redirect_to @post, notice: t('message.post_was_successfully_updated.') }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to :post, alert: t('message.you_are_not_authorized_to_update_this_post.') }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      if @post.user == current_user and current_user.creator or current_user.moderator 
        format.html { redirect_to posts_url, notice: t('message.post_was_successfully_destroyed.') }
        format.json { head :no_content }
      else
        format.html { redirect_to :post, alert: t('message.you_are_not_authorized_to_delete_this_post.') }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id, :visible)
    end

    def force_params
      ps = {}
      if current_user.moderator
        ps = params.require(:post).permit(:title, :body, :user_id, :visible)
        ps[:user_id] = current_user.id if ps[:user_id].blank?
      else
        ps = params.require(:post).permit(:title, :body)
        ps[:user_id] = current_user.id
      end
      ps
    end

    # Authorization filter
    def require_authorized
      unless ((@post.blank? or @post.user == current_user) and current_user.creator) or current_user.moderator
        redirect_to :posts, alert: t('message.you_are_not_authorized_in_to_access_this_section')
      end
    end
end
