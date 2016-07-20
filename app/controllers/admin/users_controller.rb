class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search= User.ransack params[:q]
    @users= @search.result.order("name").page params[:page]
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.success"
    else
      flash[:danger] = t "user.failed"
    end
    redirect_to admin_users_url
  end  
end
