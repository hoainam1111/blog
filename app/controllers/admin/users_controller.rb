class Admin::UsersController < AdminController
  def index
    if params[:query].present?
      @users = User.paginate(page: params[:page], per_page: 5).where("name ILIKE ?", "%#{params[:query]}%").order(created_at: :desc)
    else
      @users = User.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    end
  end
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    @total_likes = @user.posts.sum(:likes_count)
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User was successfully destroyed."
  end
end
