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
    @estorias = Estoria.where(:status => [3, 4, 5, 6, 7, 8, 9, 10], :projeto_id => params[:projeto]).order('importancia DESC')
    
    render :json => @estorias
  end
end
