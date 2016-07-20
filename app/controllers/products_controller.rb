
class ProductsController < ApplicationController
  def index
    @search= Product.ransack params[:q]
    @products= @search.result.page params[:page]
    @search.build_sort
  end
  
  def show
    @product = Product.find_by id: params[:id]
    @comment = @product.comments.build
    if user_signed_in?
      @current_comment = @product.comments.find_by user_id: current_user.id
    end
    @comments = @product.comments.order("rating DESC")
      .page params[:page]
    unless @product
      flash[:danger] = t "products.show.noproduct"
      redirect_to products_path
    end
  end
end
