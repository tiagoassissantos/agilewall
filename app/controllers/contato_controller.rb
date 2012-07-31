# encoding: UTF-8
class ContatoController < ApplicationController
  def index
  end
  
  def enviar
    ContatoMailer.mensagem_contato(params[:nome], params[:email], params[:assunto], params[:mensagem]).deliver
    
    respond_to do |format|
      format.html { redirect_to(:controller => :contato, :action => :index, 
          :notice => 'Sua mensagem foi enviada com sucesso. Em breve entraremos em contato com você.') }
      format.xml  { render :xml => @equipes }
    end
  end
end
