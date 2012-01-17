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
			var estoria = resposta[0].estoria
			$('#id_estoria').val(estoria.id);
			$('#importancia').val(estoria.importancia);
			$('#estimativa').val(estoria.estimativa);
			$('#status').val(estoria.status);
			$('#tipo').val(estoria.tipo);
			$('#nome').val(estoria.nome);
			$('#descricao').val(estoria.descricao);
			$('#como_testar').val(estoria.como_testar);
			
			$('#editar_estoria').dialog('open');
		});
}

function nova_estoria() {
	$('#dialogo_nova_estoria').dialog('open');
}
