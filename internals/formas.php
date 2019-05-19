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

	var DataTableFromas = null;
	var formas = new $PHP('forma_pagtoController');
		formas.sendException = ['data'];
		formas.loaded = LoadGridForma;

	function LoadGridForma(){
		
		if( DataTableFromas ) DataTableFromas.destroy()
		//produtos.datable('selectAll',[0,100],'#datagrid');

		formas.call('selectAll',[0,100],function( ret ){
			//console.log( produtos.data )
			DataTableFromas = $('#datagrid').DataTable({
				"data" : formas.data,
				searching: false,
				lengthChange : false,
				ajax: {
			        url: formas.url,
			        dataSrc: 'data',
			        data : ''
			    },
			    pageLength: 6,
			    lengthMenu : [5,10,20],
			    rowId: 'id',
		        columns: [
		            { data: "id", title: "ID" , width: "5%"},		            
		            { data: "nome", title: "Produto" , width: "85%"},
		            {
		                data : "active",
		                title : "Venda",
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

		                    return '<button type="button" class="btn btn-'+cls+' btn-xs venda"> <span class="glyphicon glyphicon '+icon+'" aria-hidden="true"></span> '+textActive+'</button>';
		                }
		            },
		            {
		                data : "active_c",
		                title : "Conta Cliente",
		                sortable: false,
		                "render": function ( data, type, full, meta ) {
		                    var textActive = "Desativar";
		                    var icon = "glyphicon-ban-circle";
		                    var cls = "danger unactive";
		                    if( full.active_c == 'n' ){
		                    	textActive = "Ativar";
		                    	cls = "success active";
		                    	icon = "glyphicon-ok-circle";
		                    }

		                    return '<button type="button" class="btn btn-'+cls+' btn-xs conta"> <span class="glyphicon glyphicon '+icon+'" aria-hidden="true"></span> '+textActive+'</button>';
		                }
		            }
		        ]
		    });

		    $('#datagrid .btn.venda').unbind('click').click(function(){

		    	var id = $(this).parents('tr:eq(0)').attr('id')

		    	if( $(this).hasClass('unactive') ){
	    			formas.call('save',[JSON.stringify({'active':'n','id':id})],function(){
	    				LoadGridForma()
	    			})
		    	}

		    	if( $(this).hasClass('active') ){
	    			formas.call('save',[JSON.stringify({'active':'y','id':id})],function(){
	    				LoadGridForma()
	    			})
		    	}		    	
		    	
		    	return false;
		    })

		    $('#datagrid .btn.conta').unbind('click').click(function(){

		    	var id = $(this).parents('tr:eq(0)').attr('id')

		    	if( $(this).hasClass('unactive') ){
	    			formas.call('save',[JSON.stringify({'active_c':'n','id':id})],function( ret ){
	    				LoadGridForma()
	    				
	    			})
		    	}

		    	if( $(this).hasClass('active') ){
	    			formas.call('save',[JSON.stringify({'active_c':'y','id':id})],function( ret ){
	    				if( ret.success ) {
	    					LoadGridForma()
	    				} else {
	    					AlertMessage( $('#datagrid').parent(), 'danger', "Erro!", ret.message, 3000 );
	    				}
	    			})
		    	}

		    	
		    	
		    	return false;
		    })
		    
		})
	}

	function CreateFormForma( id ){
		var formElement = $('#modal .modal-body form');
		formElement.attr('action','');
		formElement.removeClass('thre-columns');
		CallForm('forms/formapagto.json', formElement, function(){

			if( id ){

				var formas = new $PHP('forma_pagtoController');
				formas.loaded = function(){
					formas.call('selectById',[id],function( ret ){
						if(ret.success){
							
							LoadDataForm(formElement,formas.data)

						}
					})
				};

			}

		}, function(){

			var formas = new $PHP('forma_pagtoController');
			formas.loaded = function(){
				formas.call('save',[JSON.stringify( SerializeObject(formElement.serializeArray())  )],function( ret ){
					if(ret.success){
						LoadGridForma()
						$('.modal-close').click();
						AlertMessage( $('#datagrid').parent(), 'success', "Sucesso", "Categoria cadastrada com sucesso!", 3000 );

					}
				})
			};

		})
	}

</script>