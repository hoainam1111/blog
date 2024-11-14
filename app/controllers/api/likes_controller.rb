module Api
  class LikesController < ApplicationController
    # được sử dụng để bảo vệ ứng dụng khỏi các cuộc tấn công CSRF (Cross-Site Request Forgery), đặc biệt trong các API controllers.
    protect_from_forgery with: :null_session

    def create
      like = Like.create!(like_params)
      respond_to do |format|
        format.json do
          # Trả về phản hồi ở định dạng JSON.
          # Trong trường hợp thành công,
          # phản hồi sẽ chứa đối tượng wishlist vừa tạo ở trạng thái HTTP 200 (:ok).
          render json: like.to_json, status: :ok
        end
    end

    def destroy
      like = Like.find(params[:id])
      like.destroy()
      respond_to do |format|
        format.json do
          # Trả về mã trạng thái HTTP 204 (No Content),
          # nghĩa là yêu cầu đã được thực hiện thành công
          # nhưng không trả về nội dung nào.
          render json: like.to_json, status: 204
        end
      end
    end
    end

    private

    def like_params
      params.permit(:user_id, :post_id)
    end
  end
end
