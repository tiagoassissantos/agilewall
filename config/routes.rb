AgileWall::Application.routes.draw do
  resources :projetos

  get "home/index"
  
  match '/user' => "projetos#index", :as => :user_root
  devise_for :users
  
  get 'quadro', :controller => :quadro, :action => :index
  
  get '/estorias/lista_backlog'
  get '/estorias/lista'
  post '/estorias/atualizar'
  get 'backlog', :controller => :estorias, :action => :index
  
  resources :estorias do
    member do
      get :altera_status
      get :busca
    end
  end
  
  get 'dashboard', :controller => :dashboard, :action => :index
  
  root :to => 'home#index'
end
