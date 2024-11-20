class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :edit, :update ]
  def show
    @user
    @posts = @user.posts
    @total_likes_posts = @user.posts.sum(:likes_count)
  end

  def edit
    if @user != current_user
      redirect_to profile_path(@user), alert: "You can only edit your own profile."
    end
  end
  def update
    if @user == current_user
      if @user.update(profile_params)
        redirect_to profile_path(@user), notice: "Profile updated successfully."
      else
        render :edit, alert: "Failed to update profile."
      end
    else
      redirect_to profiles_path, alert: "You are not authorized to update this profile."
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def profile_params
    params.require(:user).permit(:name, :email, :about, :avatar, :role)
  end
end
