class Bookmark < ActiveRecord::Base
  belongs_to :user #Datenbankrelation
  validates :title, :url, presence: true #pflichtfelder in der db
end
