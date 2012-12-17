var id_estoria = 0;
var id_anexo = 0;

$(document).ready( function () {
	$('#editar_estoria').dialog({
		autoOpen: false,
		height: 480,
		width: 620,
		position: 'center',
		modal: true,
		close: function() {
			
		}
	});
	
	$('#dialogo_nova_estoria').dialog({
		autoOpen: false,
		height: 480,
		width: 620,
		position: 'center',
		modal: true,
		close: function() {
			limpa_dialogo_estoria();
		}
	});
	
	$('#form_estoria').submit(function() {
		bloqueia_tela();
		$(this).ajaxSubmit({
			success: retornoAtualiza,
			url: '/estorias/atualizar',
			type: 'post' 
		});
		return false;
	});
	
	$('#form_anexo').submit(function() {
		bloqueia_tela();
		$(this).ajaxSubmit({
			success: retornoAnexar,
			url: '/estorias/anexar',
			type: 'post' 
		});
		return false;
	});
	
	$('#form_nova_estoria').submit(function() {  
		bloqueia_tela();
		$(this).ajaxSubmit({
			success: retorno_nova_historia,
			url: '/estorias',
			type: 'post' 
		});
		return false;
	});
	
	$("#confirma_exclusao_estoria").dialog({
		autoOpen: false,
		resizable: false,
		height:150,
		modal: true,
		buttons: {
			"Sim": function() {
				bloqueia_tela();
				$( this ).dialog( "close" );
				$("#form_estoria").ajaxSubmit({
					success: retornoAtualiza,
					url: "/estorias/" + id_estoria,
					type: 'POST' 
				});
				$('#editar_estoria').dialog('close');
				id_estoria = 0;
			},
			"Não": function() {
				$( this ).dialog( "close" );
				id_estoria = 0;
			}
		}
	});
	
	
	$("#confirma_exclusao_anexo").dialog({
		autoOpen: false,
		resizable: false,
		height:150,
		modal: true,
		buttons: {
			"Sim": function() {
				bloqueia_tela();
				$( this ).dialog( "close" );

				$.getJSON('/estorias/excluir_anexo',
					{id_anexo: id_anexo},
					function(resposta) {
						$('#editar_estoria').dialog('close');
						id_anexo = 0;
						desbloqueia_tela();
					}
				);
			},
			"Não": function() {
				$( this ).dialog( "close" );
				id_anexo = 0;
			}
		}
	});
});

function busca_estoria(id_estoria) {
	bloqueia_tela();
	$.getJSON('/estorias/' + id_estoria + '/busca',
		preenche_dialogo_estoria
	);
}

function preenche_dialogo_estoria(resposta) {
	$("#excluir_estoria").remove();
	$("#anexos12").empty();
	$("#status_estoria").empty();
	
	var estoria =  $.parseJSON(resposta.estoria).estoria;
	
	if (estoria.anexos.length == 0) {
		$('#anexos12').append(
			'<input type="hidden" name="id_estoria" id="id_estoria_anexo" />' +
				'<label>Anexo: </label>' +
 				'<input type="file" name="anexo" id="anexo" style=" height: 25px;" /><br /><br />'
		);
	} else {
		$('#anexos12').append(
			"<a href='/estorias/download_anexo?id_anexo=" + estoria.anexos[0].id + "'>" +
			 "Download Anexo</a>"
		);
		$('#anexos12').append(
			"<a href='javascript:void(0);' onclick='exclui_anexo(" + estoria.anexos[0].id + ");' style='margin-left: 15px; font-size: 10px;'>" +
			 "Excluir</a><br /><br />"
		);
	}
	
	$('#id_estoria').val(estoria.id);
	$('#id_estoria_anexo').val(estoria.id);
	$('#importancia').val(estoria.importancia);
	$('#estimativa').val(estoria.estimativa);
	
	
	
	if (estoria.status == 1) {
		$("#status_estoria").append("Aguardando Aprovação");
		if (resposta.pode_administrar) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(2, " + estoria.id + ")'>Aprovar</button>");
		}
		
	} else if (estoria.status == 2) {
		$("#status_estoria").append("Aprovado");
		if (resposta.pode_administrar) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(1, " + estoria.id + ")'>Reprovar</button>");
			$("#status_estoria").append("<button type='button' onclick='mudar_status(3, " + estoria.id + ")'>Escolher</button>");
		}
		
	} else if (estoria.status == 3) {
		$("#status_estoria").append("Não Iníciado");
		if (resposta.pode_administrar) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(2, " + estoria.id + ")'>Voltar backlog</button>");
		}
		if (resposta.pode_desenvolver) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(4, " + estoria.id + ")'>Desenvolver</button>");
		}
		
	} else if (estoria.status == 4) {
		$("#status_estoria").append("Em Desenvolvimento");
		if (resposta.pode_desenvolver) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(3, " + estoria.id + ")'>Parar</button>");
			$("#status_estoria").append("<button type='button' onclick='mudar_status(6, " + estoria.id + ")'>Impedimento</button>");
			$("#status_estoria").append("<button type='button' onclick='mudar_status(5, " + estoria.id + ")'>Finalizar</button>");
		}
		
	} else if (estoria.status == 5) {
		$("#status_estoria").append("Desenvolvimento Finalizado");
		if (resposta.pode_desenvolver) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(4, " + estoria.id + ")'>Voltar Desenvolvimento</button>");
		}
		if (resposta.pode_testar) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(7, " + estoria.id + ")'>Testar</button>");
		}
		
	} else if (estoria.status == 6) {
		$("#status_estoria").append("Impedimento");
		if (resposta.pode_desenvolver) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(4, " + estoria.id + ")'>Desenvolver</button>");
		}		
	} else if (estoria.status == 7) {
		$("#status_estoria").append("Em Teste");
		if (resposta.pode_testar) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(5, " + estoria.id + ")'>Parar Teste</button>");
			$("#status_estoria").append("<button type='button' onclick='mudar_status(8, " + estoria.id + ")'>Finalizar Teste</button>");
		}
		
	} else if (estoria.status == 8) {
		$("#status_estoria").append("Teste Finalizado");
		if (resposta.pode_testar) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(7, " + estoria.id + ")'>Testar Novamente</button>");
		}
		if (resposta.pode_commitar) {
			$("#status_estoria").append("<button type='button' onclick='mudar_status(9, " + estoria.id + ")'>Finalizar Estória</button>");
		}
	}
	
	$('#tipo').val(estoria.tipo);
	$('#titulo1').val(estoria.titulo);
	$('#descricao').val(estoria.descricao);
	$('#observacoes').val(estoria.observacoes);
	
	if (resposta.pode_administrar) {
		$('#botoes').append("<button id='excluir_estoria' type='button' onclick='exclui_estoria(" + estoria.id + ");'>Excluir</button>");
	}
	
	$('#editar_estoria').dialog('open');
	
	desbloqueia_tela();
}

function nova_estoria() {
	$('#dialogo_nova_estoria').dialog('open');
}

function exclui_estoria(estoria_id) {
	id_estoria = estoria_id;
	$("#confirma_exclusao_estoria").dialog("open");
}

function fecha_dialogo_editar() {
	$('#editar_estoria').dialog('close');
}

function fecha_dialogo_nova_estoria() {
	$('#dialogo_nova_estoria').dialog('close');
	//limpa_dialogo_estoria();
	$('#form_nova_estoria').resetForm();
}

function limpa_dialogo_estoria() {
	$("#id_nova_estoria").val("");
	$("#importancia_nova_estoria").val("");
	$("#estimativa_nova_estoria").val("");
	$("#titulo_nova_estoria").val("");
	$("#descricao_nova_estoria").val("");
	$("#observacoes_nova_estoria").val("");
}

function exclui_anexo(anexo) {
	id_anexo = anexo;
	$("#confirma_exclusao_anexo").dialog("open");
}

function mudar_status(status, estoria) {
	bloqueia_tela();
	$.ajax({
  		type: 'POST',
  		url: 'estorias/atualizar_status',
  		data: {id: estoria, status: status},
  		dataType: 'json',
  		success: retornoAtualiza
	});
}

function bloqueia_tela() {
	$.blockUI({
		message: '<h2>Aguarde...</h2>',
		css: { 
            border: 'none', 
            padding: '15px', 
            backgroundColor: '#000', 
            '-webkit-border-radius': '10px', 
            '-moz-border-radius': '10px', 
            opacity: .5, 
            color: '#fff' 
        } 
	});
}

function desbloqueia_tela() {
	$.unblockUI();
}

function retornoAnexar(retorno) {
	$.unblockUI();
}

