class UsuariosController < ApplicationController
  layout 'layout_projetos'
  before_filter :authenticate_user!
  
  def index
    begin
      @projeto = Projeto.find( params[:projeto] )
      if cannot? :read, @projeto
        redirect_to "/dashboard"
      end
      
      if cannot? :gerenciar_usuario, @projeto
        redirect_to "/dashboard"
      end
      
      @usuarios = User.joins(:permissoes).where('permissoes.projeto_id' => @projeto.id).group('id')
    rescue Exception => e
       redirect_to "/dashboard"
    end
  end
  
  def pesquisa
    @usuario = User.find_all_by_email(params[:email])
    render :json => @usuario
  end
  
  def inclui_user
    @usuario = User.find(params[:id_user])
    @projeto = Projeto.find( params[:projeto] )
    @papel = Papel.find_by_nome( params[:papel] )
    
    permissao = Permissao.where('user_id = ? and projeto_id = ? and papel_id = ?', @usuario.id, @projeto.id, @papel.id)
    
    if permissao.empty?
      @permissao = Permissao.new
      @permissao.user = @usuario
      @permissao.projeto = @projeto
      @permissao.papel = @papel
      @permissao.save
    end
    
    usuarios = User.joins(:permissoes).where('permissoes.projeto_id' => @projeto.id).group('id')
    
    render :json => usuarios.to_json(:include => { :permissoes => {:include => :papel} })
  end
  
  def remove_permissao
    permissao = Permissao.find(params[:id])
    permissao.destroy
    
    projeto = Projeto.find( params[:projeto] )
    usuarios = User.joins(:permissoes).where('permissoes.projeto_id' => projeto.id).group('id')
    
    render :json => usuarios.to_json(:include => { :permissoes => {:include => :papel} })
  end
end
