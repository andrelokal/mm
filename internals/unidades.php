<div class="row" style="height: 100%">
	<div class="col-md-12">
		<div class="row">

			<div class="col-md-6">
				<div class="btn-group" role="group" aria-label="">
				  <button type="button" class="btn btn-default">Exportar Excel <span class="glyphicon glyphicon-save" aria-hidden="true"></span></button>
				</div>		
			</div>
		</div>
		<div class="clearfix">&nbsp;</div>
		<div class="row" style="height: 100%">
			<div class="col-md-12">
		 		<table class="table table-striped table-hover table-bordered table-condensed" id='datagrid'>

				</table>
		  	</div>
		  	
		</div>
	</div>
</div>


<script>
	
	$(function(){
		$('.responsive-h').responsive({padding:[0,0,300,0]});
	})

	var DataTableUnidades = null;
	var unidades = new $PHP('unidadeController');
		unidades.loaded = LoadGridUnidade;

	function LoadGridUnidade(){
		
		if( DataTableUnidades ) DataTableUnidades.destroy()
		//produtos.datable('selectAll',[0,100],'#datagrid');

		unidades.call('selectAll',[0,100],function( ret ){
			//console.log( produtos.data )
			DataTableUnidades = $('#datagrid').DataTable({
				"data" : unidades.data,
				searching: false,
			    pageLength: 6,
			    lengthChange : false,
			    lengthMenu : [5,10,20],
			    rowId: 'id',
		        columns: [
		            { data: "id", title: "ID" , width: "5%"},		            
		            { data: "descricao", title: "Unidade" , width: "85%"},
		            {
		                data : "active",
		                sortable: false,
		                "render": function ( data, type, full, meta ) {
		                    var textActive = "Desativar";
		                    var icon = "glyphicon-ban-circle";
		                    var cls = "danger unactive";
		                    if( full.active == 'n' ){
		                    	textActive = "Ativar";
		                    	cls = "success active";
		                    	icon = "glyphicon-ok-circle";
		                    }

		                    return '<button type="button" class="btn btn-'+cls+' btn-xs "> <span class="glyphicon glyphicon '+icon+'" aria-hidden="true"></span> '+textActive+'</button>';
		                }
		            }
		        ]
		    });

		    $('#datagrid .btn').unbind('click').click(function(){
		    	var id = $(this).parents('tr:eq(0)').attr('id')

		    	if( $(this).hasClass('unactive') ){
		    		//if( confirm('Deseja realmente continuar ?') ){
		    			unidades.call('save',[JSON.stringify({'active':'n','id':id})],function(){
		    				LoadGridUnidade()
		    			})
		    		//}
		    	}

		    	if( $(this).hasClass('active') ){
		    		//if( confirm('Deseja realmente continuar ?') ){
		    			unidades.call('save',[JSON.stringify({'active':'y','id':id})],function(){
		    				LoadGridUnidade()
		    			})
		    		//}
		    	}
		    	
		    	return false;
		    })
		    
		})
	}

	function CreateFormUnidade( id ){
		var formElement = $('#modal .modal-body form');
		formElement.attr('action','');
		formElement.removeClass('thre-columns');
		CallForm('forms/unidade.json', formElement, function(){

			if( id ){

				var unidades = new $PHP('unidadeController');
				unidades.loaded = function(){
					unidades.call('selectById',[id],function( ret ){
						if(ret.success){
							
							LoadDataForm(formElement,unidades.data)

						}
					})
				};

			}

		}, function(){

			var unidades = new $PHP('unidadeController');
			unidades.loaded = function(){
				unidades.call('save',[JSON.stringify( SerializeObject(formElement.serializeArray())  )],function( ret ){
					if(ret.success){
						LoadGridUnidade()
						$('.modal-close').click();
						AlertMessage( $('#datagrid').parent(), 'success', "Sucesso", "Categoria cadastrada com sucesso!", 3000 );

					}
				})
			};

		})
	}

</script>