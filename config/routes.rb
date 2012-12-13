AgileWall::Application.routes.draw do
	post '/portifolio/update', :controller => :portifolio, :action => :update
	post '/portifolio/novo', :controller => :portifolio, :action => :create

	get "inicio/index"

	get "contato/index"

	get "contato/enviar"

	get "producao", :controller => :producao, :action => :index

	get "usuarios/remove_permissao"
	get "usuarios/inclui_user"
	get "usuarios/pesquisa"
	get "usuarios", :controller => :usuarios, :action => :index

	resources :projetos

	get "home/index"

	match '/inicio' => "inicio#index", :as => :user_root
	devise_for :users
		
	get 'quadro', :controller => :quadro, :action => :index

	get 'backlog', :controller => :estorias, :action => :index

	post '/estorias/atualizar_status'
	get '/estorias/lista_producao'
	get '/estorias/excluir_anexo'
	get '/estorias/download_anexo'
	get '/estorias/lista_backlog'
	get '/estorias/lista'
	post '/estorias/atualizar'
	  
	resources :estorias do
		member do
			post :destroy
			get :busca
		end
	end
  
	get 'dashboard', :controller => :dashboard, :action => :index

	root :to => 'home#index'
end
