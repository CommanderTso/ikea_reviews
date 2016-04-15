class Admins::UsersController < AdminsController
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.reviews.destroy_all
    flash[:notice] = "#{@user.email} has been deleted!"
    @user.destroy
    redirect_to admins_users_path
  end
end
