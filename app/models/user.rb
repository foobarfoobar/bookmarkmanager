class User < ActiveRecord::Base
  has_secure_password #Methoden zum Speichern, Validieren des PW & der PW-Wiederholung, Authentifizierungsfklt.
  has_many :bookmarks #Datenbankrelation, liefert user.bookmarks, ...
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #/\A([\A@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  validates :email, format: VALID_EMAIL_REGEX, uniqueness: true
  # attr_accessible :email, :password, :password_confirmation 
  #specifies a whitelist of attributes that are allowed to be updated in bulk,
  #old mass assignment stuff, in ruby 4 not needed anymore
end
