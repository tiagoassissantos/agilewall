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
      
    rescue Exception => e
      puts e
      redirect_to "/projetos"
    end
  end

end
