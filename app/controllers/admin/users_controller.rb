class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
  	@users = User.order(:name).paginate page: params[:page],
      per_page: Settings.per_page
  end
end