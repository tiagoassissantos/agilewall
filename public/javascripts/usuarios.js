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
			"<button id='adicionar' onclick='add_ao_projeto("+ resultado[0].user.id +")'>Add</button>"
		);
	}
	$.unblockUI();
}

function add_ao_projeto(id_usuario) {
	bloqueia_tela();
	$.getJSON('/usuarios/inclui_user', {id_user: id_usuario, projeto: id_projeto}, retorno_add_usuario);
}

function retorno_add_usuario(retorno) {
	$("#usuarios_participantes").empty();
	
	for (var i = 0; i < retorno.length; i++) {
		$("#usuarios_participantes").append( retorno[i].user.email + "<br />" )
	}
	$("#usuarios_encontrados").empty();
	$.unblockUI();
}
