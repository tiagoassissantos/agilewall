# encoding: UTF-8
class DashboardController < ApplicationController
  layout 'layout_projetos'
  before_filter :authenticate_user!
  
  def index
   begin
      @portifolio = Portifolio.find(params[:po])
      if cannot? :read, @portifolio
        redirect_to "/inicio"
      end
      
      @usuarios = User.joins(:permissoes).where('permissoes.portifolio_id' => @portifolio.id).group('id')
      
      @usuarios.each do |usuario|
        usuario.permissoes.delete_if {|x| x.projeto_id != @portifolio.id}
      end

      @projetos = @portifolio.projetos
      
    rescue Exception => e
      puts "------------------------------------------------------------------"
      puts e
      puts "------------------------------------------------------------------"
      redirect_to "/inicio"
    end
  end

end
