class Admin::CategoriesController < AdminController
  before_action :set_category, only: [ :edit, :update ]
  def index
    if params[:query].present?
      @categories = Category.where("name ILIKE ?", "%#{params[:query]}%").order(created_at: :desc)
    else
      @categories = Category.all
    end
  end
  def edit
  end
  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
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
  private
  def set_category
    @category = Category.find(params[:id])
  end
  def category_params
    params.require(:category).permit(:name)
  end
end
