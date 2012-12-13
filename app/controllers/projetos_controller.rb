# encoding: UTF-8
class ProjetosController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /projetos/1
  # GET /projetos/1.xml
  def show
    @projeto = Projeto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @projeto }
    end
  end

  # GET /projetos/new
  # GET /projetos/new.xml
  def new
    @projeto = Projeto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @projeto }
    end
  end

  # GET /projetos/1/edit
  def edit
    @projeto = Projeto.find(params[:id])
  end

  # POST /projetos
  # POST /projetos.xml
  def create
    @portifolio = Portifolio.find( params[:po] )

    @projeto = Projeto.new
    @projeto.nome = params[:projeto][:nome]
    @projeto.descricao = params[:projeto][:descricao]
    @projeto.portifolio = @portifolio
    
    respond_to do |format|
      if @projeto.save
        
        #@permissao = Permissao.new
        #@permissao.user = current_user
        #@permissao.projeto = @projeto
        #@permissao.papel = Papel.find_by_nome(Papel::DONO)
        #@permissao.save
        
        #@permissao2 = Permissao.new
        #@permissao2.user = current_user
        #@permissao2.projeto = @projeto
        #@permissao2.papel = Papel.find_by_nome(Papel::GERENTE)
        #@permissao2.save
        
        format.html { redirect_to(:controller => 'dashboard', :action => 'index', :po => @portifolio.id, :notice => 'Projeto was successfully created.') }
        format.xml  { render :xml => @projeto, :status => :created, :location => @projeto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @projeto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projetos/1
  # PUT /projetos/1.xml
  def update
    @projeto = Projeto.find(params[:id])

    respond_to do |format|
      if @projeto.update_attributes(params[:projeto])
        format.html { redirect_to(@projeto, :notice => 'Projeto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @projeto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projetos/1
  # DELETE /projetos/1.xml
  def destroy
    @projeto = Projeto.find(params[:id])
    @projeto.destroy

    respond_to do |format|
      format.html { redirect_to(projetos_url) }
      format.xml  { head :ok }
    end
  end
end
