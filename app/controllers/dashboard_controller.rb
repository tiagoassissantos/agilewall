# encoding: UTF-8
class DashboardController < ApplicationController
  layout 'layout_projetos'
  before_filter :authenticate_user!
  
  def index
   begin
      @projeto = Projeto.find(params[:projeto])
      if cannot? :read, @projeto
        redirect_to "/projetos"
      end
      
      @usuarios = User.joins(:permissoes).where('permissoes.projeto_id' => @projeto.id).group('id')
      
      @usuarios.each do |usuario|
        usuario.permissoes.delete_if {|x| x.projeto_id != @projeto.id}
      end
      
    rescue Exception => e
      puts e
      redirect_to "/projetos"
    end
  end

end
