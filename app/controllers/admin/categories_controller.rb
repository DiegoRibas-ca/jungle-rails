class Admin::CategoriesController < ApplicationController
  # before_filter :authorize_admin
  http_basic_authenticate_with name: ENV['USERADMIN'], password: ENV['PASSWORD']

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Categorie created!'
    else
      render :new
    end
  end


  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
