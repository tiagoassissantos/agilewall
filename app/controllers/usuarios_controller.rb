# encoding: UTF-8
class UsuariosController < ApplicationController
  layout 'layout_projetos'
  before_filter :authenticate_user!
  
  def index
    begin
      @portifolio = Portifolio.find( params[:po] )
      if cannot? :read, @portifolio
        redirect_to "/inicio"
      end
      
      if cannot? :gerenciar_usuario, @portifolio
        redirect_to "/inicio"
      end
      
      @usuarios = User.joins(:permissoes).where('permissoes.portifolio_id' => @portifolio.id).group('id')
      
      @usuarios.each do |usuario|
        usuario.permissoes.delete_if {|x| x.portifolio_id != @portifolio.id}
      end
      
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
    @portifolio = Portifolio.find( params[:portifolio] )
    @papel = Papel.find_by_nome( params[:papel] )
    
    permissao = Permissao.where('user_id = ? and portifolio_id = ? and papel_id = ?', @usuario.id, @portifolio.id, @papel.id)
    
    if permissao.empty?
      @permissao = Permissao.new
      @permissao.user = @usuario
      @permissao.portifolio = @portifolio
      @permissao.papel = @papel
      @permissao.save
    end
    
    usuarios = User.joins(:permissoes).where('permissoes.portifolio_id' => @portifolio.id).group('id')
    
    usuarios.each do |usuario|
      usuario.permissoes.delete_if {|x| x.portifolio_id != @portifolio.id}
    end
    
    render :json => usuarios.to_json(:include => { :permissoes => {:include => :papel} })
  end
  
  def remove_permissao
    permissao = Permissao.find(params[:id])
    permissao.destroy
    
    portifolio = Portifolio.find( params[:portifolio] )
    usuarios = User.joins(:permissoes).where('permissoes.portifolio_id' => portifolio.id).group('id')
    
    usuarios.each do |usuario|
		  if usuario.permissoes.empty?
			 usuario.permissoes.delete_if {|x| x.portifolio_id != @portifolio.id}
		  end
    end
    
    render :json => usuarios.to_json(:include => { :permissoes => {:include => :papel} })
  end
end
