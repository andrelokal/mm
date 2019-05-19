<form id='fechamento-caixa' >
	<div class="row">
		<div class="col-md-6">
			<div class="form-group " >
		    	<label for="valor_inicial">Valor em Dinheiro do Caixa</label>
		    	<input type="valor_inicial" class="form-control input-lg " name='valor_fechamento' id="valor_fechamento" placeholder="Valor Fechamento" data-type='money'>
		  	</div>
		</div>
		<div class="col-md-6">
			<div class="form-group " >
		    	<label for="valor_inicial">Total em Dinheiro</label>
		  		<div class="free total din">
		  			
		  		</div>
		  	</div>
		</div>
	</div>
	
</form>
<div id="navbarForm" class="navbar-collapse collapse">
	<ul class="nav navbar-nav navbar-right help">
	  <li >
	      <kbd>Esc</kbd> Fechar Janela
	  </li>
	</ul>
</div><!--/.nav-collapse -->
<script>
	$(function(){
		
		var caixa = new $PHP('CaixaController');              

        caixa.loaded = function(){

        	var formElement = $('#fechamento-caixa');
			CallForm( null , formElement, function(){

				caixa.call('valorEmCaixa',[],function( ret ){
		            if(ret.success){
		            	
		            	var soma_din = Number(caixa.data.soma[0].soma) + Number(caixa.data.init);
		            	$('.free.total.din').html( MoneyFormat( soma_din ) );

		            }
		        })

			}, function(){

				caixa.call('save',[JSON.stringify( SerializeObject(formElement.serializeArray()))],function( ret ){
		            if(ret.success){
		            	
		            	$('.modal-close').click();
		            	$('.link_menu_1').click();

		            } else {	             

		              	AlertMessage( formElement, 'danger', 'Atenção!', ret.message, 3000 )
		              

		            }
		        })

			})
        }

		
	})
</script>