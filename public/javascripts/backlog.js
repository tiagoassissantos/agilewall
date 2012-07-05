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
		var estoria = $.parseJSON(estorias[i].estoria).estoria;
		
		var quadro = "";
		
		if (estoria.status == 1) {
			quadro = "#estorias_nao_aprovadads";
		} else if (estoria.status == 2) {
			quadro = "#estorias_aprovadas";
		}
		
		exibe_estorias_no_quadro(estorias[i], quadro);
	}
	
	desbloqueia_tela();
}

function exibe_estorias_no_quadro(estoria_perm, quadro) {
	var estoria = $.parseJSON(estoria_perm.estoria).estoria;
	
	var bug = "";
	if (estoria.tipo == 1) {
		bug = "<img src='images/green.png' alt='Funcionalidade' title='Funcionalidade' title='Funcionalidade' width='15' height='15' />";
	} else if (estoria.tipo == 2) {
		bug = "<img src='images/red.png' alt='BUG' title='BUG' title='BUG' width='15' height='15' />";
	} else if (estoria.tipo == 3) {
		bug = "<img src='images/blue.png' alt='Técnica' title='Técnica' title='Técnica' width='15' height='15' />";
	}
	
	var botoes = "";
	
	if (estoria.status == 1) {
		if (estoria_perm.pode_administrar) {
			botoes = "<a href='javascript:void(0)' class='botao_quadro' onclick='mudar_status(2, " + estoria.id + ")'>Aprovar</a>";
		}
		
	} else if (estoria.status == 2) {
		if (estoria_perm.pode_administrar) {
			botoes = "<a href='javascript:void(0)' class='botao_quadro' onclick='mudar_status(1, " + estoria.id + ")'>Reprovar</a>";
			botoes = botoes + "<a href='javascript:void(0)' class='botao_quadro' onclick='mudar_status(3, " + estoria.id + ")'>Escolher</a>";
		}
	}
	
	$(quadro).append(
		"<div style='margin: 3px 2px 3px 4px; margin-bottom: 3px; background-color: #ccc; width: 98%' class='bordaArredondada'>" +
			"<div style='margin: 0px; padding: 5px 7px 3px 7px; height: 17px; background-color: #aaa' class='bordaSuperiorArredondada'>" +
				"<span title='Importância' style='width: 30px; display: block; float: left;'>" + estoria.importancia + "</span>" +
				bug +
			"</div>" +
			"<hr style='margin: 0px'>" +
			"<a href='javascript:void(0);' onclick='busca_estoria(" + estoria.id + ");'>" +
				"<div style='margin: 0px; padding: 7px 7px 3px 7px;'>" +
					"<span>" + estoria.titulo + "</span><br />" +
				"</div>" +
			"</a>" +
			"<hr style='margin: 0px'>" +
			"<div style='margin: 0px; padding: 1px 7px 3px 7px; height: 20px'>" +
				"<div style='float: right;'>" +
					botoes +
				"</div>" +
			"</div>" +
		"</div>"
	);
}
