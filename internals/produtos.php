<div class="row" style="height: 100%">
	<div class="col-md-12">
		<div class="row">

			<div class="col-md-6">
				<div class="btn-group" role="group" aria-label="">
				  <button class="btn btn-success" type="submit" modal='internals/form.php' callback='CreateFormProduct' data-modaltitle='Cadastro de Produto'>Adicionar Produto <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span></button>
				  <button type="button" class="btn btn-default excel">Exportar Excel <span class="glyphicon glyphicon-save" aria-hidden="true"></span></button>
				</div>		
			</div>
			<div class="col-md-6">
				<div class="input-group ">
			      	<input type="text" class="form-control" placeholder="Pesquisar..." id='pesquisar'>
		      		<span class="input-group-btn">
			        	<button class="btn btn-primary" type="button" id='btn-pesquisar'>Buscar</button>
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
		$('#pesquisar').keydown(function(e){
			if( e.which == 13 ){
				LoadGridProduto()
				return false;
			}
		})
		$('#btn-pesquisar').click(function(){
			LoadGridPesquisa()
		})	
		$('.excel').unbind('click').click(function(){
			ExportExcel( produtos.data, 
						"Produtos",
						["id","Codigo","Categoria","Produto","Valor","Est","Qnt"],
						["id","codigo","categoria","nome","valor","tem_estoque","estoque"]);
		})
	})

	var DataTableProduto = null;
	var produtos = new $PHP('ProdutoController');
		produtos.loaded = LoadGridProduto;

	function LoadGridProduto(){
		
		if( DataTableProduto ) DataTableProduto.destroy()
		//produtos.datable('selectAll',[0,100],'#datagrid');
		produtos.search = $('#pesquisar').val();
		produtos.call('selectAll',[0,100],function( ret ){
			//console.log( produtos.data )
			DataTableProduto = $('#datagrid').DataTable({
				"data" : produtos.data,
				searching: false,
			    pageLength: 6,
			    lengthMenu : [5,10,20],
			    rowId: 'id',
		        columns: [
		            { data: "id", title: "ID" , width: "10%"},
		            { data: "codigo", title: "Código" , width: "10%"},
		            { data: "categoria", title: "Categoria", width: "20%" },
		            { data: "nome", title: "Produto" , width: "15%"},
		            {
		                data : "valor",
		                sortable: false,
		                title: "Valor" , 
		                width: "10%",
		                "render": function ( data, type, full, meta ) {
		                	return "<span class='money'><b>"+MoneyFormat(full.valor)+"</b></span>" ;
		                }
		            },
		            { data: "tem_estoque", title: "Est." , width: "10%"},
		            {
		                data : "estoque",
		                sortable: false,
		                title: "Qnt." , 
		                width: "10%",
		                "render": function ( data, type, full, meta ) {

		                	var notify = '';
		                	var tooltip = '';
		                	if( full.notify == 'yes' && full.tem_estoque == 'Sim' ){
		                		notify = 'warning';
		                		tooltip = "title='Produto com estoque mínimo' data-toggle='tooltip' data-placement='top'";
		                	}

		                	return "<span class='"+notify+"' "+tooltip+" ><b>"+full.estoque+"</b></span>" ;
		                }
		            },
		            {
		                data : "id",
		                sortable: false,
		                "render": function ( data, type, full, meta ) {

		                	return "<div class='btn-group' role='group' aria-label=''><button class='btn btn-default btn-xs edit' type='button'>Editar</button><button class='btn btn-default btn-xs delete' type='button'>Excluir</button></div>";
		                }
		            }
		        ]
		    }).on( 'draw', function () {
		    	initJs();
		    	ActiveButtons()
			    
			});

			ActiveButtons()
		    //ComboCategorias( $('#busca_produtos #categoria') );
		    
		})
	}

	function ReloadGrid(){
		LoadGridProduto()
		
	}

	function ActiveButtons(){
		$('#datagrid .btn').unbind('click').click(function(){
	    	var id = $(this).parents('tr:eq(0)').attr('id')

	    	if( $(this).hasClass('edit') ){
	    		Modal( "Editar Produto", 'internals/form.php', function(){ CreateFormProduct( id ) } )	
	    	}

	    	if( $(this).hasClass('delete') ){
	    		if( confirm('Deseja realmente agapar registro ?') ){
	    			produtos.call('delete',[id],function(){
	    				LoadGridProduto()
	    			})
	    		}
	    	}
	    	
	    	return false;
	    })
	}

	
</script>