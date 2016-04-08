class Admins::UsersController < ApplicationController
  before_filter :authorized?

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    User.destroy(@user)
    redirect_to admins_users_path
  end

  private

  def authorized?
    if current_user == nil
      flash[:error] = "Please sign in!"
        redirect_to root_path
    elsif current_user.role != "admin"
      flash[:error] = "You are not authorized to view that page."
      redirect_to root_path
    end
  end
end
