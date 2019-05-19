<div class="row" style="height: 100%">
	<div class="col-md-12">
		<div class="row">

			<div class="col-md-6">
				<div class="btn-group" role="group" aria-label="">
				  <button class="btn btn-success" type="submit" modal='internals/form.php' callback='CreateFormEstoque' data-modaltitle='Adicionar Produto no Estoque' modalsize='lg'>Lançamento Estoque <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span></button>
				  <button type="button" class="btn btn-default excel">Exportar Excel <span class="glyphicon glyphicon-save" aria-hidden="true"></span></button>
				</div>		
			</div>
			<div class="col-md-6">
				<div class="input-group ">
			      	<input type="text" class="form-control" placeholder="Pesquisar..." id='pesquisar'>
		      		<span class="input-group-btn">
			        	<button class="btn btn-primary" type="button" id='btn-pesquisar'>Buscar</button>
			      	</span>
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
	<!-- <div class="col-md-3">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h4>Filtrar Registros</h4>
			</div>
			<div class="panel-body">
			<form id='busca_produtos'>
			  <div class="form-group">
			    <label for="exampleInputEmail1">Categorias</label>
			    <select class="form-control" id="categoria" >
			    </select>
			  </div>
			  <button type="submit" class="btn btn-default">Filtrar</button>
			</form>
			  </div>
		</div>
  	</div> -->
</div>


<script>
	
	$(function(){
		$('.responsive-h').responsive({padding:[0,0,300,0]});
		$('#pesquisar').keydown(function(e){
			if( e.which == 13 ){
				LoadGridEstoque()
				return false;
			}
		})
		$('#btn-pesquisar').click(function(){
			LoadGridEstoque()
		})	

		$('.excel').unbind('click').click(function(){
			ExportExcel( 	estoque.data, 
							"Estoque",
							["Codigo","Produto","Valor","Dt-Compra","Estoque-min","Estoque"],
							["codigo","produto","valorProd","dt_compra","estoque_min","estoque"]);
		})
	})

	var DataTableEstoque = null;
	var estoque = new $PHP('entrada_produtoController');
		estoque.loaded = LoadGridEstoque;

	function LoadGridEstoque(){
		
		//if( DataTableEstoque ) DataTableEstoque.destroy()
		//estoque.datable('selectAll',[0,100],'#datagrid');
		$('#datagrid').html( '' );
		estoque.search = $('#pesquisar').val();
		estoque.call('selectAll',[0,100],function( ret ){
			if( !ret.success ){
				$('#datagrid').html( ret.message );
			} else {
				console.log( estoque.data )
				DataTableEstoque = $('#datagrid').DataTable({
					"data" : estoque.data,
					searching: false,
				    pageLength: 6,
				    lengthMenu : [5,10,20],
				    rowId: 'produto_id',
			        columns: [
			            { data: "codigo", title: "Código" , width: "5%"},
			            {
			                data : "produto",
			                title: "Produto",
			                sortable: true,
			                width: "30%",
			                "render": function ( data, type, full, meta ) {

			                	return "<a href='#' modal='internals/form.php' callback='CreateFormProduct' data-modaltitle='Editar Produto' modalsize='lg' id='"+full.produto_id+"' data-toggle='tooltip' data-placement='top' title='Editar Produto'>"+full.produto+"</a>";
			                }
			            },
			            {
			                data : "valorProd",
			                sortable: false,
			                title: "Valor" , 
			                width: "10%",
			                "render": function ( data, type, full, meta ) {
			                	return "<span class='money'><b>"+MoneyFormat(full.valorProd)+"</b></span>" ;
			                }
			            },
			            {
			                data : "dt_compra",
			                title: "Último Lançamento",
			                sortable: true,
			                width: "30%",
			                "render": function ( data, type, full, meta ) {
			                	return full.dt_compra;
			                	//return "<a href='#' modal='internals/form.php' callback='CreateFormProduct' data-modaltitle='Editar Produto' modalsize='lg' id='"+full.id+"' data-toggle='tooltip' data-placement='top' title='Ver relatório Lançamento'>"+full.dt_compra+"</a>";
			                }
			            },
			            { data: "estoque_min", title: "Mínimo" , width: "10%"},
			            {
			                data : "estoque",
			                sortable: false,
			                title: "Qnt." , 
			                width: "10%",
			                "render": function ( data, type, full, meta ) {

			                	var notify = '';
			                	var tooltip = '';
			                	if( full.notify == 'yes' ){
			                		notify = 'warning';
			                		tooltip = "title='Produto com estoque mínimo' data-toggle='tooltip' data-placement='top'";
			                	}

			                	return "<span class='"+notify+"' "+tooltip+" ><b>"+full.estoque+"</b></span>" ;
			                }
			            }

			        ],
	        		destroy: true
			    }).on( 'draw', function () {
				    initJs();
				});

			    initJs();
			    //ComboCategorias( $('#busca_produtos #categoria') );
			}

			
		    
		})
	}

	function CreateFormEstoque( id ){
		var formElement = $('#modal .modal-body form');
		formElement.attr('action','');
		//formElement.removeClass('thre-columns');

		CallForm('forms/estoque.json', formElement, function(){


			ComboProdutos( formElement.find('#produto_id') )
			ComboPessoasJuridica( formElement.find('#fornecedor_id') )


			/*if( id ){

				estoque.call('selectById',[id],function( ret ){
					if(ret.success){
						
						LoadDataForm(formElement,estoque.data)

					}
				})

			}*/

			$('#dt_compra').datetimepicker().on('dp.change', function(e) {
		        $('#dt_validade').datetimepicker('minDate',e.date)
		    });

		    $('#tipo').change(function(){
		    	if( $(this).val() == 'E' ){
		    		formElement.find('.entrada').parent().show();
		    		formElement.find('.saida').each(function(){
		    			
		    			if( $(this).attr('required') ){
		    				$(this).addClass('was-required');
		    				$(this).removeAttr('required');
		    			}

		    			$(this).parent().hide();
		    		})

		    		formElement.find('.entrada').each(function(){
		    			if( $(this).hasClass('was-required') ){
		    				$(this).removeClass('was-required');
		    				$(this).attr('required','required');
		    			}	
		    		})
		    		
		    	} else {
		    		
		    		formElement.find('.saida').parent().show();
		    		formElement.find('.entrada').each(function(){
		    			if( $(this).attr('required') ){
		    				$(this).addClass('was-required');
		    				$(this).removeAttr('required');
		    			} 
		    			$(this).parent().hide();
		    		})

		    		formElement.find('.saida').each(function(){
		    			if( $(this).hasClass('was-required') ){
		    				$(this).removeClass('was-required');
		    				$(this).attr('required','required');
		    			}	
		    		})
		    	}
		    })

		    $('#tipo').change();

			initJs();
		}, function(){

			estoque.call('save',[JSON.stringify( SerializeObject(formElement.serializeArray())  )],function( ret ){
			if(ret.success){

				ReloadGrid()
				$('.modal-close').click();
				AlertMessage( $('#datagrid').parent(), 'success', "Sucesso!", "Estoque cadastrado com sucesso!", 3000 );

			} else {

				AlertMessage( formElement, 'warning', "Erro!", ret.message, 3000 );				

			}
		})
						

		})
	}

	function ReloadGrid(){

		LoadGridEstoque()
		
	}
</script>