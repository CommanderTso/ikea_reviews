class Devise::Custom::RegistrationsController < Devise::RegistrationsController
  def destroy
    @user = current_user
    @user.reviews.destroy_all
    @user.destroy
    flash[:notice] = "Your account has been deleted. You will be missed!"
    redirect_to root_path
  end
end
