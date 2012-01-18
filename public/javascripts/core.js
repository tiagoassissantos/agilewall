$(document).ready( function () {
	$('#editar_estoria').dialog({
		autoOpen: false,
		height: 450,
		width: 620,
		position: 'center',
		modal: true,
		close: function() {
			
		}
	});
	
	$('#dialogo_nova_estoria').dialog({
		autoOpen: false,
		height: 450,
		width: 620,
		position: 'center',
		modal: true,
		close: function() {
			
		}
	});
	
	$('#form_estoria').submit(function() {  
		$(this).ajaxSubmit({
			success: retornoAtualiza,
			url: '/estorias/atualizar',
			type: 'post' 
		});
		return false;
	});
	
	$('#form_nova_estoria').submit(function() {  
		$(this).ajaxSubmit({
			success: retorno_nova_historia,
			url: '/estorias',
			type: 'post' 
		});
		return false;
	});
});

function busca_estoria(id_estoria) {
	$.getJSON('/estorias/' + id_estoria + '/busca',
		function(resposta) {
			$("#excluir_estoria").remove();
			
			var estoria = resposta[0].estoria
			$('#id_estoria').val(estoria.id);
			$('#importancia').val(estoria.importancia);
			$('#estimativa').val(estoria.estimativa);
			$('#status').val(estoria.status);
			$('#tipo').val(estoria.tipo);
			$('#nome').val(estoria.nome);
			$('#descricao').val(estoria.descricao);
			$('#como_testar').val(estoria.como_testar);
			
			$('#botoes').append("<button id='excluir_estoria' type='button' onclick='exclui_estoria(" + estoria.id + ");'>Excluir</button>");
			
			$('#editar_estoria').dialog('open');
		});
}

function nova_estoria() {
	$('#dialogo_nova_estoria').dialog('open');
}

function exclui_estoria(id_estoria) {
	$("#form_estoria").ajaxSubmit({
		success: retornoAtualiza,
		url: "/estorias/" + id_estoria ,
		type: 'DELETE' 
	});
	$('#editar_estoria').dialog('close');
}
