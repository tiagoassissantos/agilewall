class UsuariosController < ApplicationController
  layout 'layout_projetos'
  before_filter :authenticate_user!
  
  def index
    #begin
      @projeto = Projeto.find( params[:projeto] )
      if cannot? :read, @projeto
        redirect_to "/dashboard"
      end
    #rescue Exception => e
    #   redirect_to "/dashboard"
    #end
  end
  
  def pesquisa
    @usuario = User.find_all_by_email(params[:email])
    render :json => @usuario
  end
  
  def inclui_user
    @usuario = User.find(params[:id_user])
    @projeto = Projeto.find( params[:projeto] )
    @projeto.users << @usuario
    
    render :json => @projeto.users
  end
end
