$(document).ready( function () {
	busca_estorias();
});

function retornoAtualiza(resposta) {
	$('#editar_estoria').dialog('close');
	busca_estorias();
}

function busca_estorias() {
	$.getJSON('/estorias/lista', {projeto: id_projeto}, exibe_estorias);
	limpa_quadros();
}

function exibe_estorias(estorias) {
	for (var i = 0; i < estorias.length; i++) {
		var estoria = estorias[i].estoria;
		var quadro = "";
		
		if (estoria.status == 3) {
			quadro = "#nao_iniciado";
		} else if (estoria.status == 4) {
			quadro = "#em_desenvolvimento";
		} else if (estoria.status == 5) {
			quadro = "#pronto_desenvolvimento";
		} else if (estoria.status == 6) {
			quadro = "#com_impedimento";
		} else if (estoria.status == 7) {
			quadro = "#em_teste";
		} else if (estoria.status == 8) {
			quadro = "#teste_pronto";
		} else if (estoria.status == 9) {
			quadro = "#deploy_em_producao";
		} else if (estoria.status == 10) {
			quadro = "#em_producao";
		}
		
		exibe_estorias_no_quadro(estoria, quadro);
	}
}

function exibe_estorias_no_quadro(estoria, quadro) {
	$(quadro).append(
		"<div style=' float: left;'>" +
		"<a href='javascript:void(0);' onclick='busca_estoria(" + estoria.id + ");'>" +
		"<div style='margin: 4px; background-color: #FFFF00; padding: 7px; width: 150px'>" +
			"<div>" +
				"<span style='width: 50px; display: block; float: left;'>" + estoria.importancia + "</span><span>" + estoria.estimativa + "</span>" +
			"</div>" +
			"<span>" + estoria.nome + "</span><br />" +
		"</div>" +
		"</a>" +
		"</div>"
	);
}

function limpa_quadros() {
	$("#nao_iniciado").empty();
	$("#em_desenvolvimento").empty();
	$("#pronto_desenvolvimento").empty();
	$("#com_impedimento").empty();
	$("#em_teste").empty();
	$("#teste_pronto").empty();
	$("#deploy_em_producao").empty();
	$("#em_producao").empty();
}
