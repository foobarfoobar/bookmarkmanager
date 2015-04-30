#encoding: utf-8 #tells ruby how it should interprete this file
class BookmarksController < ApplicationController
  before_filter :require_login#prueft, ob ein user angemeldet ist (sonst Null-Pointer fuer nicht angemeldete user
  #auf current_user); wenn nicht, wird loginformular geladen; :require_login wird unten implementiert
  
  def index
    @bookmarks = current_user.bookmarks # Bookmark.all  ersetzt wegen user authentifizierung
        #Laden muss ueber current_user erfolgen, somit werden nur die user-Bookmarks gelistet, sonst durch raten der Id
        #moeglich, auf Bms anderer user zuzugreifen -> fuer diese ist current_user dann nil
        #current_user in application_controller def.
  end
  
  def edit
    @bookmark = current_user.bookmarks.find(params[:id]) # Bookmark.find(params[:id])
    #ueber params kann man auf die in der url eingebeben Parameter zugreifen
  end
  
  def update  # benoetigt von edit
    @bookmark = current_user.bookmarks.find(params[:id]) #Bookmark.find(params[:id])
    if @bookmark.update_attributes(bookmark_params)
      redirect_to bookmarks_path, notice: t("messages.edit_bookmark")
    else
      render edit
    end
  end
  
  def create
    # debugger if ENV['RAILS_ENV'] == 'development'
    
    @bookmark = current_user.bookmarks.build(bookmark_params) #Bookmark.new(bookmark_params)#Form-felder heißen so wie die Spalten in der db, deswegen koennen
          #die Params, die das Form. an die Action uebergibt, als Hash uebergeben werden;
          #params[:ObjektnameDesUebergebenenObjekts]
    
    if @bookmark.save #erfolgreich gespeichert, Anzeige index-Seite
      redirect_to bookmarks_path, notice: t("messages.new_bookmark")
    else
      render "new"  #Fehler (nicht alle Pflichtfelder ausgefüllt), Neuzeichnen der New-Seite, Daten bleiben erhalten
    end
  end
  
  def new
    @bookmark = current_user.bookmarks.build #Bookmark.new
  end
  
  def show
    @bookmark = current_user.bookmarks.find(params[:id]) #Bookmark.find(params[:id])
  end
  
  def destroy
    @bookmark = current_user.bookmarks.find(params[:id]) #Bookmark.find(params[:id])
    @bookmark.destroy
    
    respond_to do |format|
      # format.html {redirect_to bookmarks_url}
      # format.json {head :ok}
      format.js#Akzeptiere JS AJAX -anfrage
    end
    
    # redirect_to bookmarks_url, notice: t("messages.delete_bookmark") #entfaellt bei AJAX ->you may only
                                                                    #call render OR redirect
  end
  
  private
  #Rails 4: the needed parameters must be marked as required
  # Using a private method to encapsulate the permissible parameters
  # is just a good pattern since you'll be able to reuse the same
  # permit list between create and update. Also, you can specialize
  # this method with per-user checking of permissible attributes.
  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :comment)
  end
  
  def require_login
    unless user_signed_in?
      redirect_to login_path, alert: t("messages.not_logged_in")
    end
  end
  
end
