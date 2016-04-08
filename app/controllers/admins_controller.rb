class AdminsController < ApplicationController
  before_filter :authorized?

  def index
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
