class SessionsController < ApplicationController
  
  def new
    #ist Session und hat kein model, daher wird hier kein neues Objekt erzeugt und action bleibt leer
    #im zugehoerigen view wird model-unabhaengiges Form. mit form_tag-Helper erstellt
  end
  
  def create
    user = User.find_by_email(params[:email])#Nutzer, dessen email mit der aus dem Form. uebereinstimmt, wird aus db gelesen
    if user && user.authenticate(params[:password])#Nutzer existiert; db-Password stimmt mit dem Form.-PW ueberein
                                                   #authenticate wird durch has_secure_password bereitgestellt 
      session[:user_id] = user.id
      redirect_to bookmarks_path, notice: t("messages.login")
    else
      flash.now.alert = t("messages.login_failure")
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t("messages.logout") #root_to steht durch Eintrag vonroot to: in routes zur Verfuegung
                                                 #bookmarks_path, notice: "Abgemeldet!"
  end
  
end
