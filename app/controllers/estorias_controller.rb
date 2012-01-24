# encoding: UTF-8
class EstoriasController < ApplicationController
  layout 'layout_projetos'
  before_filter :authenticate_user!
  
  # GET /estorias
  # GET /estorias.xml
  def index
    #begin
      @projeto = Projeto.find( params[:projeto] )
      if cannot? :read, @projeto
        redirect_to "/dashboard"
      end
    #rescue Exception => e
    #   redirect_to "/dashboard"
    #end
  end

  # GET /estorias/1
  # GET /estorias/1.xml
  def show
    @estoria = Estoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estoria }
    end
  end

  # GET /estorias/new
  # GET /estorias/new.xml
  def new
    @estoria = Estoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estoria }
    end
  end

  # GET /estorias/1/edit
  def edit
    @estoria = Estoria.find(params[:id])
  end

  # POST /estorias
  # POST /estorias.xml
  def create
    @estoria = Estoria.new(params[:estoria])
    @estoria.status = 1
    @estoria.projeto = Projeto.find(params[:projeto_id])
    
    if @estoria.save
      @evento = Evento.find(1)
      historico = Historico.new
      historico.evento = @evento
      historico.estoria = @estoria
      historico.data = Date.today
      historico.save
      
      render :json => @estoria
      
    else
      render :json => @estoria.errors
    end
  end

  # PUT /estorias/1
  # PUT /estorias/1.xml
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

  # DELETE /estorias/1
  # DELETE /estorias/1.xml
  def destroy
    @estoria = Estoria.find(params[:id])
    @estoria.destroy

    render :json => @estoria
  end
  
  def atualizar
    @estoria = Estoria.find(params[:id])
    
    if @estoria.update_attributes(params[:estoria])
      
      if @estoria.status == 2
        @evento = Evento.find(2)
        
      elsif @estoria.status == 4
        @evento = Evento.find(4)
        
      elsif @estoria.status == 5
        @evento = Evento.find(5)
      
      elsif @estoria.status == 6
        @evento = Evento.find(6)
        
      elsif @estoria.status == 7
        @evento = Evento.find(8)
        
      elsif @estoria.status == 8
        @evento = Evento.find(9)
        
      elsif @estoria.status == 10
        @evento = Evento.find(10)
        @estoria.data_conclusao = Date.today
        @estoria.save
      end
      
      historico = Historico.new
      historico.evento = @evento
      historico.estoria = @estoria
      historico.data = Date.today
      historico.save
      
      render :json => @estoria
    else
      render :json => @estoria.errors
    end
  end
  
  def busca
    @estoria = Estoria.find_all_by_id(params[:id])
    render :json => @estoria
  end
  
  def lista_backlog
    @estorias = Estoria.where(:status => [1, 2], :projeto_id => params[:projeto]).order('importancia DESC')
    
    render :json => @estorias
  end
  
  def lista
    @estorias = Estoria.where(:status => [3, 4, 5, 6, 7, 8], :projeto_id => params[:projeto]).order('importancia DESC')
    
    render :json => @estorias
  end
end
