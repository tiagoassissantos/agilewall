# encoding: UTF-8
class QuadroController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    begin
      @projeto = Projeto.find(params[:projeto])
      if cannot? :read, @projeto
        redirect_to "/dashboard"
      end
    rescue Exception => e
      redirect_to "/dashboard"
    end
  end
end
