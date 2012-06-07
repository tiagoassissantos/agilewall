$(document).ready( function () {
	bloqueia_tela();
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
		} /*else if (estoria.status == 9) {
			quadro = "#deploy_em_producao";
		} else if (estoria.status == 10) {
			quadro = "#em_producao";
		} */
		
		if (estoria.status == 6) {
			exibe_estorias_em_impedimento_no_quadro(estoria, quadro);
		
		} else {
			exibe_estorias_no_quadro(estoria, quadro);
		}
	}
	
	desbloqueia_tela();
}

function exibe_estorias_no_quadro(estoria, quadro) {
	var historicos = estoria.historicos;
	var numHist = historicos.length;
	var usuario = historicos[numHist -1].user.email;
	var nome = usuario.split("@");
	
	var bug = "";
	if (estoria.tipo == 2) {
		bug = "<img src='images/bug.png' alt='BUG' title='BUG' title='BUG' width='15' height='15' />";
	}
	
	$(quadro).append(
		"<div style='margin: 3px 2px 3px 4px; background-color: #ccc; width: 97%' class='bordaArredondada'>" +
			"<div style='margin: 0px; padding: 5px 7px 3px 7px; height: 17px; background-color: #aaa' class='bordaSuperiorArredondada'>" +
				"<span title='Importância' style='width: 30px; display: block; float: left;'>" + estoria.importancia + "</span>" +
				bug +
				"<span title='Usuário' style='display: block; float: right;'>" + nome[0] + "</span>" +
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

function exibe_estorias_em_impedimento_no_quadro(estoria, quadro) {
	var historicos = estoria.historicos;
	var numHist = historicos.length;
	var usuario = historicos[numHist -1].user.email;
	var nome = usuario.split("@");
	
	var bug = "";
	if (estoria.tipo == 2) {
		bug = "<img src='images/bug.png' alt='BUG' title='BUG' title='BUG' width='15' height='15' />";
	}
	
	$(quadro).append(
		"<div style='margin: 3px 2px 3px 4px; margin-bottom: 3px; background-color: #ccc; width: 97%' class='bordaArredondada'>" +
			"<div style='margin: 0px; padding: 5px 7px 3px 7px; height: 17px; background-color: #aaa' class='bordaSuperiorArredondada'>" +
				"<span title='Importância' style='width: 30px; display: block; float: left;'>" + estoria.importancia + "</span>" +
				bug +
				"<span title='Usuário' style='display: block; float: right;'>" + nome[0] + "</span>" +
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


function limpa_quadros() {
	$("#nao_iniciado").empty();
	$("#em_desenvolvimento").empty();
	$("#pronto_desenvolvimento").empty();
	$("#com_impedimento").empty();
	$("#em_teste").empty();
	$("#teste_pronto").empty();
	//$("#deploy_em_producao").empty();
	//$("#em_producao").empty();
}
