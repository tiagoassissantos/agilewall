# encoding: UTF-8
class EstoriasController < ApplicationController
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
  
  def show
    @estoria = Estoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estoria }
    end
  end
  
  def new
    @estoria = Estoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estoria }
    end
  end
  
  def edit
    @estoria = Estoria.find(params[:id])
  end
  
  def create
    @estoria = Estoria.new(params[:estoria])
    @estoria.status = 1
    @estoria.projeto = Projeto.find(params[:projeto_id])
    
    if @estoria.save
      if params[:anexo] != nil
        anexo = Anexo.new
        anexo.arquivo = params[:anexo]
        anexo.estoria = @estoria
        anexo.save!
      end
      
      @evento = Evento.find(1)
      historico = Historico.new
      historico.evento = @evento
      historico.estoria = @estoria
      historico.data = Date.today
      historico.user = current_user
      historico.save
      
      render :json => @estoria
      
    else
      render :json => @estoria.errors
    end
  end
  
  def update
    @estoria = Estoria.find(params[:id])

    respond_to do |format|
      if @estoria.update_attributes(params[:estoria])
        render :json => @estoria
      else
        render :json => @estoria.errors
      end
    end
  end

  def destroy
    @estoria = Estoria.find(params[:id])
    @estoria.destroy
    
    @evento = Evento.find(10)
    historico = Historico.new
    historico.evento = @evento
    historico.estoria = @estoria
    historico.data = Date.today
    historico.user = current_user
    historico.save
    
    render :json => @estoria
  end
  
  def atualizar
    @estoria = Estoria.find(params[:id])
    
    if @estoria.update_attributes(params[:estoria])
      
      if params[:anexo] != nil
        anexo = Anexo.new
        anexo.arquivo = params[:anexo]
        anexo.estoria = @estoria
        anexo.save!
      end
      
      historico = Historico.new
      historico.evento = @evento
      historico.estoria = @estoria
      historico.data = Date.today
      historico.user = current_user
      historico.save
      
      render :json => @estoria
    else
      render :json => @estoria.errors
    end
  end
  
  def atualizar_status
    @estoria = Estoria.find(params[:id])
    status_anterior = @estoria.status 
    @estoria.status = params[:status]
    
    if @estoria.update_attributes(params[:estoria])
      
      if @estoria.status == 2
        @evento = Evento.find(2)
        
      elsif @estoria.status == 3
        @evento = Evento.find(3)
        
      elsif @estoria.status == 4
        
        if status_anterior == 3
          @evento = Evento.find(4)
        elsif status_anterior == 6
          @evento = Evento.find(11)
        end
        
      elsif @estoria.status == 5
        @evento = Evento.find(5)
      
      elsif @estoria.status == 6
        @evento = Evento.find(6)
        
      elsif @estoria.status == 7
        @evento = Evento.find(7)
        
      elsif @estoria.status == 8
        @evento = Evento.find(8)
        
      elsif @estoria.status == 9
        @evento = Evento.find(9)
        @estoria.data_conclusao = Date.today
        @estoria.save
      end
      
      historico = Historico.new
      historico.evento = @evento
      historico.estoria = @estoria
      historico.data = Date.today
      historico.user = current_user
      historico.save
      
      resposta = Hash.new
      resposta[:resp] = "OK"
      render :json => resposta
    else
      render :json => @estoria.errors
    end
  end
  
  def busca
    @estoria = Estoria.find(params[:id])
    
    resposta = Hash.new
    resposta[:estoria] = @estoria.to_json(:include => :anexos)
    resposta[:pode_administrar] = can? :administrar, @estoria.projeto
    resposta[:pode_desenvolver] = can? :desenvolver, @estoria.projeto
    resposta[:pode_testar] = can? :testar, @estoria.projeto
    resposta[:pode_commitar] = can? :commitar, @estoria.projeto
    render :json => resposta
  end
  
  def lista_backlog
    @estorias = Estoria.where(:status => [1, 2], :projeto_id => params[:projeto]).order('importancia DESC')
    
    resposta = Array.new
    
    @estorias.each do |estoria|
    	estoria_map = Hash.new
    	estoria_map[:estoria] = estoria.to_json
   		estoria_map[:pode_administrar] = can? :administrar, estoria.projeto
	    estoria_map[:pode_desenvolver] = can? :desenvolver, estoria.projeto
	    estoria_map[:pode_testar] = can? :testar, estoria.projeto
	    estoria_map[:pode_commitar] = can? :commitar, estoria.projeto
	    
	    resposta << estoria_map
    end
    
    render :json => resposta
  end
  
  def lista
    @estorias = Estoria.where(:status => [3, 4, 5, 6, 7, 8], :projeto_id => params[:projeto]).order('importancia DESC')
    #render :json => @estorias.to_json(:include => { :historicos => {:include => :user} })
    
    resposta = Array.new
    
    @estorias.each do |estoria|
    	estoria_map = Hash.new
    	estoria_map[:estoria] = estoria.to_json(:include => { :historicos => {:include => :user} })
   		estoria_map[:pode_administrar] = can? :administrar, estoria.projeto
	    estoria_map[:pode_desenvolver] = can? :desenvolver, estoria.projeto
	    estoria_map[:pode_testar] = can? :testar, estoria.projeto
	    estoria_map[:pode_commitar] = can? :commitar, estoria.projeto
	    
	    resposta << estoria_map
    end
    
    render :json => resposta
  end
  
  def lista_producao
    @estorias = Estoria.where(:status => [9], :projeto_id => params[:projeto]).order('data_conclusao DESC')
    render :json => @estorias
  end
  
  def download_anexo
    anexo = Anexo.find(params[:id_anexo].to_i)
    send_file anexo.arquivo.url
  end
  
  def excluir_anexo
    anexo = Anexo.find(params[:id_anexo].to_i)
    anexo.destroy
    
    resposta = Hash.new
    resposta[:resp] = "OK"
    render :json => resposta
  end
end
