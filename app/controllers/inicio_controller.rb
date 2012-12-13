# encoding: UTF-8
class InicioController < ApplicationController
	before_filter :authenticate_user!
	def index
		@portifolios = Portifolio.joins(:permissoes).where('permissoes.user_id' => current_user.id).group('id')
	end
end
