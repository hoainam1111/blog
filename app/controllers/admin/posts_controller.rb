class Admin::PostsController < AdminController
  before_action :set_user
  before_action :set_post, only: [ :destroy ]

  def index
    @posts = @user.posts.all
  end
  def destroy
    if @post.destroy
      redirect_to params[:redirect_path] || admin_user_posts_path(@user), notice: "Post was successfully deleted."
    else
      redirect_to params[:redirect_path] || admin_user_posts_path(@user), notice: "Post was fail deleted."
    end
  end
  private
  def set_user
    # sử dụng user_id thay cho id vì trong file routes.rb đã định nghĩa đường dẫn với hai tham số: :user_id và :id
    @user = User.find(params[:user_id])
  end
  def set_post
    @post = @user.posts.find(params[:id])
  end
end
