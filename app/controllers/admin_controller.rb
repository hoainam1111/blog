class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @quick_stats = {
      sign_ups: User.where("created_at > ?", 1.week.ago).count,
      posts: Post.where("created_at > ?", 1.week.ago).count,
      total_posts: Post.count,
      total_likes: Like.count,
      total_sign_ups: User.count
    }
    @most_likes_posts = Post.order("likes_count DESC").limit(3)
  end
end
