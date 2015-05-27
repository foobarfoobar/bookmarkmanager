class UsersController < ApplicationController
 #soll Anmeldeformular laden und verarbeiten, wenn es abgeschickt wird
 around_filter :timing #wird vor und nach angefragter Action ausgefuehrt, ist unten definiert
 
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
  
  def timing
    logger.info("vorher: #{Time.now}") #schreibt in development.log
    yield #Aufruf der Action
    logger.info("nachher: #{Time.now}")
  end
  
end
