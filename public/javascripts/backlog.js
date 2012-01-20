$(document).ready( function () {
	busca_estorias();
});

function busca_estorias() {
	$.getJSON('/estorias/lista_backlog', {projeto: id_projeto}, exibe_estorias);
	limpa_quadros();
}

function retornoAtualiza(resposta) {
	$('#editar_estoria').dialog('close');
	busca_estorias();
}

function retorno_nova_historia() {
	$('#dialogo_nova_estoria').dialog('close');
	limpa_dialogo_estoria();
	busca_estorias();
}

function limpa_quadros() {
	$("#estorias_nao_aprovadads").empty();
	$("#estorias_aprovadas").empty();
}

function exibe_estorias(estorias) {
	for (var i = 0; i < estorias.length; i++) {
		var estoria = estorias[i].estoria;
		var quadro = "";
		
		if (estoria.status == 1) {
			quadro = "#estorias_nao_aprovadads";
		} else if (estoria.status == 2) {
			quadro = "#estorias_aprovadas";
		}
		
		exibe_estorias_no_quadro(estoria, quadro);
	}
}

function exibe_estorias_no_quadro(estoria, quadro) {
	$(quadro).append(
		"<a href='javascript:void(0);' onclick='busca_estoria(" + estoria.id + ");'>" +
		"<div style='margin: 4px; background-color: #FFFF00; padding: 7px; width: 450px'>" +
			"<span style='width: 50px; display: block; float: left;'>" + estoria.importancia + "</span>" +
			"<span>" + estoria.nome + "</span><br />" +
		"</div>" +
		"</a>"
	);
}
