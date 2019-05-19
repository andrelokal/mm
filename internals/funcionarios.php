<div class="row" style="height: 100%">
	<div class="col-md-12">
		<div class="row">

			<div class="col-md-6">
				<div class="btn-group" role="group" aria-label="">
				  <button class="btn btn-success" type="submit" modal='internals/form.php' callback='CreateFormFuncionario' data-modaltitle='Cadastro de Funcionário'>Adicionar Funcionário <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span></button>
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
				LoadGridFuncionarios()
				return false;
			}
		})
		$('#btn-pesquisar').click(function(){
			LoadGridFuncionarios()
		})	
		$('.excel').unbind('click').click(function(){
			ExportExcel( funcionario.data, "Funcionarios",["id","Nome","E-mail"],["id","nome","email"]);
		})
	})

	var DataTableFuncionario = null;
	var funcionario = new $PHP('funcionarioController');
		funcionario.loaded = LoadGridFuncionarios;

	function LoadGridFuncionarios(){
		
		//if( DataTableFuncionario ) DataTableFuncionario.destroy()
		//funcionario.datable('selectAll',[0,100],'#datagrid');
		$('#datagrid').html( '' );
		funcionario.search = $('#pesquisar').val();
		funcionario.call('selectAll',[0,100],function( ret ){
			if( !ret.success ){
				//DataTableFuncionario.destroy()
				$('#datagrid').html( ret.message );
			} else {
				//console.log( funcionario.data )
				DataTableFuncionario = $('#datagrid').DataTable({
					"data" : funcionario.data,
					searching: false,
				    pageLength: 6,
				    lengthMenu : [5,10,20],
				    rowId: 'id',
			        columns: [
			            { data: "nome", title: "Nome" , width: "40%"},
			            { data: "email", title: "E-mail", width: "30%" },
			            //{ data: "telefone", title: "Telefone", width: "20%" },
			            //{ data: "cpf", title: "CPF", width: "15%" },
			            {
			                data : "id",
			                sortable: false,
			                "render": function ( data, type, full, meta ) {

			                	html = "<div class='btn-group ' role='group' aria-label=''>"
			                	html += "<button class='btn btn-default btn-xs edit' type='button'>Editar</button>";
			                	//html += "<button class='btn btn-default btn-xs delete' type='button'>Excluir</button>";
			                	html += "<button class='btn btn-default btn-xs senha' type='button'>Alterar Senha</button>";
			                	html += "</div>";

			                	return html;
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
	    		Modal( "Editar Funcionário", 'internals/form.php', function(){ CreateFormFuncionario( id ) } )	
	    	}

	    	if( $(this).hasClass('delete') ){
	    		if( confirm('Deseja realmente agapar registro ?') ){
	    			funcionario.call('delete',[id],function(){
	    				LoadGridFuncionarios()
	    			})
	    		}
	    	}

	    	if( $(this).hasClass('senha') ){
	    		Modal( "Alterar Senha Funcionário", 'internals/form.php', function(){ CreateFormSenhaFuncionario( id ) }, 'sm' )	
	    	}
	    	
	    	return false;
	    })
	}



	function CreateFormFuncionario( id ){
		var formElement = $('#modal .modal-body form');
		formElement.attr('action','');
		CallForm('forms/funcionario.json', formElement, function(){

			if( id ){

				var funcionario = new $PHP('funcionarioController');
				funcionario.loaded = function(){
					funcionario.call('selectById',[id],function( ret ){
						if(ret.success){
								
							var id = funcionario.data.id;
							var data = funcionario.data;
							$.extend( data, data.pessoa );
							data.id = id;

							LoadDataForm(formElement,data)

						}
					})
				};

			}

			initJs();
		}, function( ret ){

				var funcionario = new $PHP('funcionarioController');
				funcionario.loaded = function(){
					funcionario.call('save',[JSON.stringify( SerializeObject(formElement.serializeArray())  )],function( ret ){
						if(ret.success){

							LoadGridFuncionarios()
							$('.modal-close').click();
							AlertMessage( $('#datagrid').parent(), 'success', "Sucesso!", "Funcionário cadastrado com sucesso!", 3000 );

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


	function CreateFormSenhaFuncionario( id ){
		var formElement = $('#modal .modal-body form');
		formElement.removeClass('thre-columns');
		formElement.attr('autocomplete','off')
		formElement.attr('action','');
		CallForm('forms/funcionario_senha.json', formElement, function(){

			formElement.find('#senha').attr('autocomplete','off')
			if( id ){
				formElement.find('#id').val( id )
			}

		}, function( ret ){
				var funcionario = new $PHP('funcionarioController');
				funcionario.loaded = function(){

					funcionario.call('changePassword',[formElement.find('#id').val(), formElement.find('#senha').val() ],function( ret ){
						if(ret.success){

							$('.modal-close').click();
							AlertMessage( $('#datagrid').parent(), 'success', "Sucesso!", "Senha alterada com sucesso!", 3000 );

						} else {
							AlertMessage( formElement, 'warning', "Erro!", ret.message, 3000 );		

						}
					})
				};
		})

		
	}
</script>