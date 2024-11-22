class Admin::CategoriesController < AdminController
  def index
    @categories = Category.all
  end
  def edit
  end
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
  end
  def destroy
    @category = Category.find(params[:id])
    @category.posts.update_all(category_id: nil)
    @category.destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: "Category was successfully deleted."
    else
      redirect_to admin_categories_path, notice: "Failed to delete the category."
    end
  end
end
