Rails.application.routes.draw do
  
  # The Rails router recognizes URLs and dispatches them to a controller's action. 
  # It can also generate paths and URLs, avoiding the need to hardcode strings in
  # your views.
  
  #get 'bookmarks/show'
  
  # resources :bookmarks  soll anderes ersetzen -> funzt nicht..
  
  #____________________mit locale_switcher, 'de' im Pfad______________________________
  scope "(:locale)", locale: /en|de/ do #um 'de' allen durchs Routing generierten Pfaden voranzustellen
    resources :bookmarks#, constraints: {id: /[0-9+]/}    #Routing-Helper nach REST-Standard, ersetzt die 7 bookmark-Routing-Eintraege unten
                          # constraints: Bedingung: id ist Zahl; Rails gibt bspw. andere Meldung wenn /aa eingegeben wird
                          # funzt hier weil nicht nur fuer id-Uebergabe?
    resources :users, only: [:new, :create] #stellt u.a. new_user_path zur Verfuegung
    get "login" => "sessions#new", as: "login"
    post "sessions" => "sessions#create", as: "sessions" #stellt sessions_path und sessions_url zur Verfuegung
    delete "logout" => "sessions#destroy", as: "logout"
  end
  get '/:locale' => "pages#home" #fuer host/de/..
  root to: 'pages#home' #Startseite; stellt u.a. root_path zur Verfuegung
  #___________________________________________________________________________________


  #____________________ohne locale-switcher____________________________________________
  # get 'bookmarks/new', as: "new_bookmark"
  # # get "hello" => "bookmarks#hello"  #method hello in class (controller) bookmarks
  # # get "bookmarks/hello" #keine Zuweisung noetig, Rails geht davon aus, dass controller/action gemeint ist
  # get "bookmarks" => "bookmarks#index", as: "bookmarks" #as: Mehrzahl, soll zu vielen führen (Bookmark.all im Controller)  
  # get "bookmarks/:id" => "bookmarks#show", as: "bookmark" #muss an letzter Stelle stehen, sonst wuerde bspw.
                                          # #auch new an show weiter geleitet; as: unter welchem Methodennamen der Pfad
                                          # #zum Eintrag generiert werden soll - soll zur Detailseite von 1 Bookmark
                                          # #fuehren => 'bookmark', nun stehen bookmark_url und bookmark_path zur Verf.   
  # get 'bookmarks/:id/edit' => "bookmarks#edit", as: "edit_bookmark" 
  # #nun stehen edit_bookmark_url und edit_bookmark_path zur Verf.  
  # post "bookmarks" => "bookmarks#create"                                          
  # patch "bookmarks/:id" => "bookmarks#update"
  # #<%= form_for(@bookmark) do |f| %> in edit.html.erb way before Ruby 4, works still if using patch instead of put in routes  
  # delete "bookmarks/:id" => "bookmarks#destroy" #, as: "destroy_bookmark"  
  # #liefert Routen für eine RESTful Resource, 'only' schraenkt Routen auf new und create ein
  # resources :users, only: [:new, :create]  
  # get "login" => "sessions#new", as: "login"
  # post "sessions" => "sessions#create", as: "sessions" #stellt path zur Verfuegung
  # delete "logout" => "sessions#destroy", as: "logout"  
  # root to: 'pages#home'
  
  # get 'users/new', as: "user"
  
  # resources :users, :path => '/'
  # root :to => 'users#new' 
  #_____________________________________________________________________________________
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
