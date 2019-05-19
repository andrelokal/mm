<div class="row" style="height: 100%">
	<div class="col-md-12">
		<div class="row">

			<div class="col-md-6">
				<div class="btn-group" role="group" aria-label="">
				  <button class="btn btn-success" type="submit" modal='internals/form.php' callback='CreateFormCategoria' data-modaltitle='Cadastro de Categoria' modalsize='sm'>Adicionar Categoria <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span></button>
				  <button type="button" class="btn btn-default excel">Exportar Excel <span class="glyphicon glyphicon-save" aria-hidden="true"></span></button>
				</div>		
			</div>
			<div class="col-md-6">
				<div class="input-group ">
			      	<input type="text" class="form-control" placeholder="Pesquisar...">
		      		<span class="input-group-btn">
			        	<button class="btn btn-primary" type="button">Buscar</button>
			      	</span>
			   	</div><!-- /input-group -->
				
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
		$('.excel').unbind('click').click(function(){
			ExportExcel( categorias.data, "Categorias",["id","Produto"]);
		})
	})

	var DataTableCategoria = null;
	var categorias = new $PHP('categoriaController');
		categorias.loaded = LoadGridCategoria;

	function LoadGridCategoria(){
		
		$('#datagrid').html( '' );
		categorias.call('selectAll',[0,100],function( ret ){
			//console.log( produtos.data )
			DataTableCategoria = $('#datagrid').DataTable({
				"data" : categorias.data,
				searching: false,
			    pageLength: 6,
			    lengthChange : false,
			    rowId: 'id',
		        columns: [
		            { data: "id", title: "ID" , width: "5%"},		            
		            { data: "nome", title: "Produto" , width: "85%"},
		            { data: "", title: "", width:"auto" }
		        ],
		        "columnDefs": [{
		            "targets": -1,
		            "data": null,
		            "defaultContent": "<div class='btn-group ' role='group' aria-label=''><button class='btn btn-default btn-xs edit' type='button'>Editar</button><button class='btn btn-default btn-xs delete' type='button'>Excluir</button></div>"
		        }],
		        destroy: true
		    }).on( 'draw', function () {
			    initJs();
			    ActiveButtons()
			    
			});

		    ActiveButtons()
		    
		})
	}

	function ActiveButtons(){
		$('#datagrid .btn').unbind('click').click(function(){
	    	var id = $(this).parents('tr:eq(0)').attr('id')

	    	if( $(this).hasClass('edit') ){
	    		Modal( "Editar Categoria", 'internals/form.php', function(){ CreateFormCategoria( id ) }, 'sm' )	
	    	}

	    	if( $(this).hasClass('delete') ){
	    		if( confirm('Deseja realmente agapar registro ?') ){
	    			categorias.call('delete',[id],function(){
	    				LoadGridCategoria()
	    			})
	    		}
	    	}
	    	
	    	return false;
	    })
	}

	function CreateFormCategoria( id ){
		var formElement = $('#modal .modal-body form');
		formElement.attr('action','');
		formElement.removeClass('thre-columns');
		CallForm('forms/categoria.json', formElement, function(){

			if( id ){

				var categorias = new $PHP('categoriaController');
				categorias.loaded = function(){
					categorias.call('selectById',[id],function( ret ){
						if(ret.success){
							
							LoadDataForm(formElement,categorias.data)

						}
					})
				};

			}

		}, function(){

			var categorias = new $PHP('categoriaController');
			categorias.loaded = function(){
				categorias.call('save',[JSON.stringify( SerializeObject(formElement.serializeArray())  )],function( ret ){
					if(ret.success){
						LoadGridCategoria()
						$('.modal-close').click();
						AlertMessage( $('#datagrid').parent(), 'success', "Sucesso", "Categoria cadastrada com sucesso!", 3000 );

					}
				})
			};

		})
	}

</script>