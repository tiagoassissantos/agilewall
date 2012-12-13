projetos = Projeto.find(:all)

projetos.each do |projeto|
	portifolio = Portifolio.new
	portifolio.nome = 'Portifolio 1'
	portifolio.descricao = 'Portifolio 1'
	portifolio.save

	projeto.portifolio = portifolio
	projeto.save

	permissoes = Permissao.find_all_by_projeto_id(projeto.id)

	permissoes.each do |permissao|
		permissao.portifolio = portifolio
		permissao.save
	end
end
