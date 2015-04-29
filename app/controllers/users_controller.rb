class UsersController < ApplicationController
 #soll Anmeldeformular laden und verarbeiten, wenn es abgeschickt wird
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: t("messages.new_user") #Auth., bookmarks_path, notice: "Benutzerkonto angelegt!"
    else
      render "new"
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
end
