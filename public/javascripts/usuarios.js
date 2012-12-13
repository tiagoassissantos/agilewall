$(document).ready( function () {
	$("#pesquisar").click(function(){
		bloqueia_tela();
		busca_usuario($("#email").val());
	});
});

function busca_usuario(email_usuario) {
	$.getJSON('/usuarios/pesquisa', {email: email_usuario}, mostra_resultado);
}

function mostra_resultado(resultado) {
	$("#usuarios_encontrados").empty();
	
	if (resultado.length > 0) {
		$("#usuarios_encontrados").append(
			"<label>" + resultado[0].user.email + "</label>" +
			
			"<select id='papel'>" +
				"<option value='DV'>Desenvolvedor Membro da Equipe</option>" +
				"<option value='GP'>Gerente do Projeto</option>" +
				"<option value='PO'>Dono do Produto (Cliente)</option>" +
				"<option value='TT'>Testador</option>" +
			"</select>" +
			
			"<button id='adicionar' onclick='add_ao_projeto("+ resultado[0].user.id +")'>Add</button>"
		);
	}
	$.unblockUI();
}

function add_ao_projeto(id_usuario) {
	bloqueia_tela();
	$.getJSON('/usuarios/inclui_user', {id_user: id_usuario, portifolio: id_portifolio, papel: $("#papel").val()}, retorno_add_usuario);
}

function retorno_add_usuario(retorno) {
	$("#usuarios_participantes").empty();
	
	for (var i = 0; i < retorno.length; i++) {
		var usuario = retorno[i].user;
		$("#usuarios_participantes").append( usuario.email );
		var permissoes = usuario.permissoes;
		
		for (var p = 0; p < permissoes.length; p++) {
			var papel = permissoes[p].papel;
			$("#usuarios_participantes").append(
				" - <label title='" + papel.descricao + "'>" + papel.nome + "</label>"
			);
			$("#usuarios_participantes").append(
				"<a href='javascript:void(0);' title='Remover Permissão' onclick='remove_permissao(" + permissoes[p].id + ");'><img src='/images/remove_small.png'></a>"
			);
		}
		
		$("#usuarios_participantes").append( "<br />" );
	}
	
	$("#usuarios_encontrados").empty();
	$.unblockUI();
}

function remove_permissao(id) {
	bloqueia_tela();
	$.getJSON('/usuarios/remove_permissao', {id: id, portifolio: id_portifolio}, retorno_add_usuario);
}
