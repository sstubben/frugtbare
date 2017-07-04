class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    admin?(@users = User.all)
  end

  def show; end

  private

  def admin?(users_object)
    if current_user.admin?
      users_object # use yield here?
    else
      redirect_to root_path, notice: 'You are not authenticated to this page'
    end
  end

  def set_user
    @user = User.where(id: params[:id]).first
  end
end
