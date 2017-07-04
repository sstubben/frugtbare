class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    admin?(@users = User.all)
  end

  private

  def admin?(users_object)
    if current_user.admin?
      users_object # use yield here?
    else
      redirect_to root_path, notice: 'You are not authenticated to this page'
    end
  end
end
