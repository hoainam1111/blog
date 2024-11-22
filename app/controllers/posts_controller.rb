class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :update, :destroy ]
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if params[:query].present?
      # sử dụng ILike để tìm kiếm ko phân biệt hoa và thường trong pgsql
      # @posts = Post.where("title ILIKE ? OR content ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
      # suwr dungj pgsearch, muốn biết cái search by kia thì qua bên post.rb
      @posts = Post.search_by_title_and_content(params[:query])
    else
      @posts = Post.all
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    if @post.category.nil?
      @relative_posts = Post.where.not(id: @post.id).order(likes_count: :desc).limit(3)
    else
      @relative_posts = Post.where(category: @post.category).where.not(id: @post.id).order(likes_count: :desc).limit(3)
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save

        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :picture, :category_id)
    end
end
