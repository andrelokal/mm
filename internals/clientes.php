<div class="row" style="height: 100%">
	<div class="col-md-12">
		<div class="row">

			<div class="col-md-6">
				<div class="btn-group" role="group" aria-label="">
				  <button class="btn btn-success" type="submit" modal='internals/form.php' callback='CreateFormCliente' data-modaltitle='Cadastro de Cliente'>Adicionar Cliente <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span></button>
				  <button type="button" class="btn btn-default excel" id='export'>Exportar Excel <span class="glyphicon glyphicon-save" aria-hidden="true"></span></button>
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
				LoadGridPessoas()
				return false;
			}
		})
		$('#btn-pesquisar').click(function(){
			LoadGridPessoas()
		})	
		$('.btn.excel').unbind('click').click(function(){
			ExportExcel( pessoas.data, "Clientes",["id","Nome","E-mail","Telefone","CPF"],["id","nome","email","telefone","cpf"]);
		})
		
	})

	var DataTablePessoa = null;
	var pessoas = new $PHP('fisicaController');
		pessoas.loaded = LoadGridPessoas;

	function LoadGridPessoas(){
		
		//if( DataTablePessoa ) DataTablePessoa.destroy()
		//pessoas.datable('selectAll',[0,100],'#datagrid');
		$('#datagrid').html( '' );
		pessoas.search = $('#pesquisar').val();
		pessoas.call('selectAll',[0,100],function( ret ){
			if( !ret.success ){
				//DataTablePessoa.destroy()
				$('#datagrid').html( ret.message );
			} else {
				//console.log( pessoas.data )
				DataTablePessoa = $('#datagrid').DataTable({
					"data" : pessoas.data,
					searching: false,
				    pageLength: 6,
				    lengthMenu : [5,10,20],
				    rowId: 'id',
			        columns: [
			            { data: "nome", title: "Nome" , width: "25%"},
			            { data: "email", title: "E-mail", width: "20%" },
			            { data: "telefone", title: "Telefone", width: "20%" },
			            { data: "cpf", title: "CPF", width: "15%" },
			            {
			                data : "id",
			                sortable: false,
			                "render": function ( data, type, full, meta ) {

			                	return "<div class='btn-group ' role='group' aria-label=''><button class='btn btn-default btn-xs edit' type='button'>Editar</button><button class='btn btn-default btn-xs delete' type='button'>Excluir</button></div>";
			                }
			            }
			        ],
	        		destroy: true
			    }).on( 'draw', function () {
				    initJs();
				    ActiveButtons()
				    
				});

				ActiveButtons()

			    
			}
		})
	}

	function ActiveButtons(){
		$('#datagrid .btn').unbind('click').click(function(){
    		var id = $(this).parents('tr:eq(0)').attr('id')

	    	if( $(this).hasClass('edit') ){
	    		Modal( "Editar Cliente", 'internals/form.php', function(){ CreateFormCliente( id ) } )	
	    	}

	    	if( $(this).hasClass('delete') ){
	    		if( confirm('Deseja realmente agapar registro ?') ){
	    			pessoas.call('delete',[id],function(){
	    				LoadGridPessoas()
	    			})
	    		}
	    	}
	    	
	    	return false;
	    })
	}

	function CreateFormCliente( id ){
		var formElement = $('#modal .modal-body form');
		formElement.attr('action','');
		CallForm('forms/cliente.json', formElement, function(){

			if( id ){

				var pessoas = new $PHP('fisicaController');
				pessoas.loaded = function(){
					pessoas.call('selectById',[id],function( ret ){
						if(ret.success){
								
							var id = pessoas.data.id;
							var data = pessoas.data;
							$.extend( data, data.pessoa );
							data.id = id;

							LoadDataForm(formElement,data)

						}
					})
				};

			}

			initJs();
		}, function( ret ){

				var pessoas = new $PHP('fisicaController');
				pessoas.loaded = function(){
					pessoas.call('save',[JSON.stringify( SerializeObject(formElement.serializeArray())  )],function( ret ){
						if(ret.success){

							LoadGridPessoas()
							$('.modal-close').click();
							AlertMessage( $('#datagrid').parent(), 'success', "Sucesso!", "Pessoa cadastrado com sucesso!", 3000 );

						} else {

							if( ret.data.status == 'IN' ){
								AlertMessage( formElement, 'warning', "Erro!", ret.message+"<BR> ..." );
							} else {
								AlertMessage( formElement, 'warning', "Erro!", ret.message, 3000 );
							}
							

						}
					})
				};

		})
	}
</script>