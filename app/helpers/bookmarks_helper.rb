#encoding: utf-8
module BookmarksHelper
  def back_to_list
    content_tag(:p, #content_tag: Rails-Helper-Methode, um HTML-Tag definieren zu koennen
    link_to(t("links.back_to_bookmarks"), bookmarks_path), class: "subNavigation") #weil Indexmethode im controller alle Bookmarks laedt, 
                    #muss hier kein Obj. uebergeben werden; class: fuer css
  end
end
