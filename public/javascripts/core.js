var id_estoria = 0;

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
		height:140,
		modal: true,
		buttons: {
			"Sim": function() {
				bloqueia_tela();
				$( this ).dialog( "close" );
				$("#form_estoria").ajaxSubmit({
					success: retornoAtualiza,
					url: "/estorias/" + id_estoria,
					type: 'DELETE' 
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
});

function busca_estoria(id_estoria) {
	bloqueia_tela();
	$.getJSON('/estorias/' + id_estoria + '/busca',
		function(resposta) {
			$("#excluir_estoria").remove();
			$("#anexos12").empty();
			
			var estoria = resposta[0].estoria
			
			if (estoria.anexos.length == 0) {
				$('#anexos12').append(
					'<input type="hidden" name="id_estoria" id="id_estoria_anexo" />' +
    				'<label>Anexo: </label>' +
    				'<input type="file" name="anexo" id="anexo" style=" height: 25px;" /><br /><br />'
				);
			} else {
				$('#anexos12').append(
					"<a href='/estorias/download_anexo?id_anexo=" + estoria.anexos[0].id + "'>" +
					 "Download Anexo</a><br /><br />"
				);
			}
			
			$('#id_estoria').val(estoria.id);
			$('#id_estoria_anexo').val(estoria.id);
			$('#importancia').val(estoria.importancia);
			$('#estimativa').val(estoria.estimativa);
			$('#status').val(estoria.status);
			$('#tipo').val(estoria.tipo);
			$('#nome').val(estoria.nome);
			$('#descricao').val(estoria.descricao);
			$('#como_testar').val(estoria.como_testar);
			
			$('#botoes').append("<button id='excluir_estoria' type='button' onclick='exclui_estoria(" + estoria.id + ");'>Excluir</button>");
			
			$('#editar_estoria').dialog('open');
			desbloqueia_tela();
		});
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
	$("#nome_nova_estoria").val("");
	$("#descricao_nova_estoria").val("");
	$("#como_testar_nova_estoria").val("");
}

function download_anexo(id_anexo) {
	$.getJSON('/estorias/download_anexo',
		{id_anexo: id_anexo},
		function(resposta) {
			
		}
	);
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
