class CommentsController < ApplicationController
  before_action :authenticate_user!


  def create
    # Tạo một đối tượng mới nhưng không lưu vào cơ sở dữ liệu ngay lập tức. Bạn có thể kiểm tra tính hợp lệ của đối tượng, thực hiện các thao tác khác, sau đó lưu bằng .save.
    @comment = current_user.comments.new(comment_params)
    puts "this is #{@comment}"
    if @comment.save
      redirect_to post_path(params[:post_id]), notice: "Comment was successfully created."
    else
      render :show, notice: "Comment could not be created"
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully deleted."
  end

  private


  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end
end
