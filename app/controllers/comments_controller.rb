class CommentsController < ApplicationController
  before_action :authenticate_user!


  def create
    @post = Post.find(params[:post_id])
    # Tạo một đối tượng mới nhưng không lưu vào cơ sở dữ liệu ngay lập tức. Bạn có thể kiểm tra tính hợp lệ của đối tượng, thực hiện các thao tác khác, sau đó lưu bằng .save.
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream { render :create, locals: { comment: @comment } }   # Tìm file create.js.erb để xử lý AJAX
      end
    else
      respond_to do |format|
        format.html { render "posts/show" }
        format.js   # Tìm file create.js.erb để xử lý lỗi
      end
    end
  end
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.user == current_user
      if @comment.destroy
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
          format.html { redirect_to @post }
        end
      end
    end
  end
  private


  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end
end
