#Hiervon erben alle Controller; aenderungen hier sind also global
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale#Zuweisung dr gewaehlten Sprache

  private
  def current_user #wenn hier definiert, steht es ueberall zur Verfuegung
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
      # else
      # @current_user = nil
    end
  end
  
  def user_signed_in?
    current_user.present?
  end
  
  helper_method :user_signed_in? #als helper methode deklarieren
  
  def set_locale
    I18n.locale = params[:locale]
  end
  
  #Sprachkennung (de, en, ..) soll im Pfad stehen; Rails enthaelt default_url_options und url_for
  #zum Setzen von Parametern in url; hier ueberschreiben der Methode und setzen des Parameters 'locale'
  def default_url_options(options={})
    { locale: I18n.locale }
  end
  
  #wenn Sprache gewechselt wird, switch Sprachparam (de) in URL
  def locale_path(locale)
    locale_regexp = %r{/(en|de)/?}
    if request.env['PATH_INFO'] =~ locale_regexp
      "#{request.env['PATH_INFO']}".gsub(locale_regexp, "/#{locale}/")
    else
      "/#{locale}#{request.env['PATH_INFO']}"
    end
  end
  
  helper_method :locale_path#als helper zur Verfuegung stellen; kann man auch im view drauf zugreifen
  
end
