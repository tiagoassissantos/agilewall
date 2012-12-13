# ecodding: UTF-8
class PortifolioController < ApplicationController
	before_filter :authenticate_user!

	def create
		@portifolio = Portifolio.new

		@portifolio.nome = params[:portifolio][:nome]
		@portifolio.descricao = params[:portifolio][:descricao]
		
		if @portifolio.save
        	
			@permissao = Permissao.new
			@permissao.user = current_user
			@permissao.portifolio = @portifolio
			@permissao.papel = Papel.find_by_nome(Papel::DONO)
			@permissao.save
				
			@permissao2 = Permissao.new
			@permissao2.user = current_user
			@permissao2.portifolio = @portifolio
			@permissao2.papel = Papel.find_by_nome(Papel::GERENTE)
			@permissao2.save
        		
			render :json => @portifolio

		else
			render :json => @portifolio.errors
		end
	end
  
	def update
		@portifolio = Portifolio.find(params[:portifolio][:id])

		@portifolio.nome = params[:portifolio][:nome]
		@portifolio.descricao = params[:portifolio][:descricao]

		if @portifolio.save
			render :json => @portifolio

		else
			render :json => @portifolio.errors
		end
	end
end
