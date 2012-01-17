# encoding: UTF-8
class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
   begin
      @projeto = Projeto.find(params[:projeto])
      if cannot? :read, @projeto
        redirect_to "/projetos"
      end
    rescue Exception => e
      puts e
      redirect_to "/projetos"
    end
  end

end
