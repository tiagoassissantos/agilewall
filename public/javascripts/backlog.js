$(document).ready( function () {
	bloqueia_tela();
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
	
	desbloqueia_tela();
}

function exibe_estorias_no_quadro(estoria, quadro) {
	$(quadro).append(
		"<div style='margin: 3px 2px 3px 4px; margin-bottom: 3px; background-color: #ccc; width: 98%' class='bordaArredondada'>" +
			"<div style='margin: 0px; padding: 5px 7px 3px 7px; height: 15px; background-color: #aaa' class='bordaSuperiorArredondada'>" +
				"<span title='Importância' style='width: 50px; display: block; float: left;'>" + estoria.importancia + "</span>" +
			"</div>" +
			"<hr style='margin: 0px'>" +
			"<a href='javascript:void(0);' onclick='busca_estoria(" + estoria.id + ");'>" +
				"<div style='margin: 0px; padding: 7px 7px 3px 7px;'>" +
					"<span>" + estoria.titulo + "</span><br />" +
				"</div>" +
			"</a>" +
			"<hr style='margin: 0px'>" +
			"<div style='margin: 0px; padding: 7px 7px 3px 7px; height: 3px'>" +
			"</div>" +
		"</div>"
	);
}
