# encoding: UTF-8
class QuadroController < ApplicationController
  layout 'layout_projetos'
  before_filter :authenticate_user!
  
  def index
    begin
      @portifolio = Portifolio.find(params[:po])
      if cannot? :read, @portifolio
        redirect_to "/dashboard?portifolio=" + params[:po]
      end
      @projeto = Projeto.find( params[:pr] )
    rescue Exception => e
      redirect_to "/dashboard"
    end
  end
end
