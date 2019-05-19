
<ul class="nav nav-tabs justify-content-center" id='TabPayment'>
	<li role="presentation" class="active fisrt"><a href="#pay_discount" class='ahref'>Desconto</a></li>
  	<li role="presentation"><a href="#pay_start" class='ahref'>Forma Pagamento</a></li>
  	<li role="presentation"><a href="#pay_value" class='ahref'>Valor Pago</a></li>  	
  	<li role="presentation"><a href="#pay_account" class='ahref'>Conta Cliente</a></li>
	<li role="presentation" class="last"><a href="#pay_confirm" class='ahref'>Confirmar Venda</a></li>
</ul>
<div class="tab-content">
	 <div role="tabpanel" class="tab-pane active" id="pay_discount">

    	<div class="container-fluid">
			<div class="row" style="margin-right: auto; margin-left: auto; max-width: 350px">
				<div class="col-xs-12 ">
					<div class="clearfix">&nbsp;</div>
					<div class="container-fluid ">
					 	<div >
					 		<label for="desconto">Desconto</label>
					 		<input class="form-control input-lg focus-select-range" type="text" placeholder="Desconto" data-type="number" id='desconto' autocomplete="off">
				 		</div>
					</div>

				</div>
			</div>	
		</div>

    </div>
	<div role="tabpanel" class="tab-pane" id="pay_start">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 ">
					<div class="clearfix">&nbsp;</div>
					<div class="container-fluid ">
					 	<p class="text-center body"></p>
					</div>

				</div>
			</div>	
		</div>

	</div>
    <div role="tabpanel" class="tab-pane" id="pay_value">

    	<div class="container-fluid">
			<div class="row pagto-1 choose" style="margin-right: auto; margin-left: auto; max-width: 350px">
				<div class="col-xs-12 ">
					<div class="clearfix">&nbsp;</div>
					<div class="container-fluid ">
					 	<div class=''  >
					    	<label for="vlr_pago">Valor Pago</label>
				 			<input class="form-control input-lg focus-select-range" type="text" placeholder="Valor Pago" data-type="money" id='vlr_pago' autocomplete="off">
					  	</div>
					</div>

				</div>
			</div>	
			<div class="row pagto-2 choose" style="display: none" >
				<div class="col-xs-12 ">
					<div class="clearfix">&nbsp;</div>
					<div class="container-fluid ">
					  	<div class='body'  >
					    	
					  	</div>
					</div>

				</div>
			</div>	
		</div>

    </div>   
    <div role="tabpanel" class="tab-pane" id="pay_account">

    	<div class="container-fluid">
			<div class="row " >
				<div class="clearfix">&nbsp;</div>
				<div class="col-xs-12">					
					<div class="container-fluid ">
				    	<div class='row' >
				    		<form id='cadastro-cliente'>
				    			<input type="hidden" name='id' id='id' autocomplete="off">
					    		<div class="col-sm-3 parent" >
						    		<div class="form-group">
									    <label for="" class="col-sm-12 control-label">CPF</label>
									    <div class="col-sm-12 col-xs-12">
									    	<input class="form-control input-sm focus-select-range active first" type="text" placeholder="CPF Cliente" name='cpf' id='cpf' data-type="cpf" autocomplete="off">
									    </div>
									</div>
								</div>
					    		<div class="col-sm-3 parent" >
					    			<div class="form-group">
									    <label for="" class="col-sm-12 control-label">Nome</label>
									    <div class="col-sm-12 col-xs-12">
									    	<input class="form-control input-sm focus-select-range" type="text" placeholder="Nome" name='nome' id='nome' autocomplete="off">
									    </div>
									</div>
					    		</div>
					    		<div class="col-sm-3 parent" >
					    			<div class="form-group">
									    <label for="" class="col-sm-12 control-label">Telefone</label>
									    <div class="col-sm-12 col-xs-12">
									    	<input class="form-control input-sm focus-select-range" type="text" placeholder="Telefone" name='telefone' id='telefone' autocomplete="off" data-type="telefone" >
									    </div>
									</div>
					    		</div>
					    		<div class="col-sm-3 parent" >
					    			<div class="form-group">
									    <label for="" class="col-sm-12 control-label">E-mail</label>
									    <div class="col-sm-12 col-xs-12">
									    	<input class="form-control input-sm focus-select-range last" type="text" placeholder="E-mail" name='email' id='email' autocomplete="off">
									    </div>
									</div>
					    		</div>
				    		</form>
				    	</div>
					</div>
				</div>				
			</div>

		</div>

    </div>
    <div role="tabpanel" class="tab-pane" id="pay_confirm">
    	
    	<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 ">
					<div class="clearfix">&nbsp;</div>
					<div class="container-fluid ">
					 	<p class="text-center body">
					 		<p class="text-center">
					 			Confirma a Venda ?<BR><br>
					 			Pressione <kbd>ENTER</kbd> para confirmar e <kbd>ESC</kbd> para cancelar<Br><br>	
					 		</p>
					 	</p>
					</div>

				</div>
			</div>	
		</div>    	
    </div>
</div>

<div class="container-fluid">
	<div class="clearfix">&nbsp;</div>
	<div class="row">
		<div class="col-xs-3 ">
			<h5>Total</h5>
			<div class="free total"></div>

		</div>
		<div class="col-xs-3 ">
			
			<h5>Pago</h5>
			<div class="free pago"></div>

		</div>
		<div class="col-xs-3 ">
			
			<h5>Troco</h5>
			<div class="free troco"></div>

		</div>
		<div class="col-xs-3 ">
			
			<h5>Economize</h5>
			<div class="free off"></div>

		</div>
	</div>	
	<div class="clearfix">&nbsp;</div>
</div>


<div id="navbarForm" class="navbar-collapse collapse">
	<ul class="nav navbar-nav navbar-right help">
	  <li >
	      <kbd>Enter</kbd> Avançar / Confirmar
	  </li>
	  <li >
	      <kbd>Esc</kbd> Voltar / Fechar Janela
	  </li>
	</ul>
</div><!--/.nav-collapse -->

<script>
	
	$('[data-type=cpf]').mask( '000.000.000-00' );

	$('#TabPayment a').click(function (e) {

		e.preventDefault()

		var href = $(this).attr('href').replace('#','');
		Payment_step = href

	  	$(this).tab('show')
	})

	var total_venda = MoneyFormat( TotalVenda() , '', ".");

	var dataSell = {
						forma : 1,
						vlr_pago : total_venda,
						discount : "0",
						total_venda_sd : total_venda,
						total_venda : total_venda,
						off : '0'
					}

	$('#vlr_pago').val( total_venda );

	$('.free.total').html( MoneyFormat( TotalVenda() ) );
	MostraDisplayValores();

	$('#desconto').val( dataSell.discount );
	/*setTimeout(function(){
		$('#desconto').focus();
	},500)*/

	ComboPessoasFisica( $('#cliente') );

	var pessoaPF = new $PHP('fisicaController');
	var formas = new $PHP('forma_pagtoController');
	formas.loaded = function(){
		formas.call('selectAll',[0,4,'v'],function( ret ){

			$('#pay_start .body').html('')
			var html = '';
			var inputs = [];
			var fracionar = [];
			var len = formas.data.length;
			var pos = '';
			var active = 'active';
			var ind = "first";

			formas.data.push({ nome : 'Fracionar', id : 5 })

			for( var i in formas.data ){
				pos = '';	
				if( dataSell.forma == formas.data[i].id ){
					pos = 'active'
				}

				html = '<li role="presentation" class="'+pos+'"><a href="'+formas.data[i].id+'" class="unlink"><h5> <kbd>'+formas.data[i].id+'</kbd> '+formas.data[i].nome+' </h5></a></li>'
				inputs.push( html )				

				if( i == (formas.data.length - 2) ) ind = 'last';
				if( formas.data[i].id != 5 ){
					html_ = "<div class='col-lg-3 col-xs-2'>";
						html_ += "<label>"+formas.data[i].nome+"</label>";
						html_ += "<input class='form-control input-md focus-select-range "+active+" "+ind+" ' type='text' placeholder='' data-type='money' data-forma='"+formas.data[i].id+"' >";
					html_ += "</div>";
					fracionar.push( html_ )	;	
				}
						
				active = '';
				ind = '';

			}

			$('#pay_start .body').html( "<ul class='nav nav-pills nav-justified navbar-left options-forma'>" + inputs.join('') +"</ul>" );
			$('#pay_value .pagto-2 .body').html( "<div class='row text-center fracionar-list'>" + fracionar.join('') +"</div>" )

			initJs();
		})
	}

	function MostraDisplayValores(){

		var vlr_total = dataSell.total_venda
		var vlr_pago = $('#vlr_pago').val();
		dataSell.vlr_pago = vlr_pago
		var rest = CalculteRest( vlr_total, vlr_pago );
		if( rest < 0 ) rest = 0;

		$('.free.total').html( MoneyFormat(vlr_total) )
		$('.free.pago').html( MoneyFormat( vlr_pago ) )	
		$('.free.troco').html( MoneyFormat( rest ) )	
		$('.free.off').html( MoneyFormat(dataSell.off) )		
	}

	$('#vlr_pago').keyup(function(){
		dataSell.vlr_pago = $(this).val();
		MostraDisplayValores()		
	})

	/*$('#desconto').keyup(function(){

		var desconto = ConvertMoneytoFloat( $(this).val() );
		vlr_desconto = CalculoDesconto( total_venda, desconto );
		$('#vlr_pago').val(total_venda - vlr_desconto)
		vlr_total = total_venda - vlr_desconto;	
		dataSell.total_venda = vlr_total
		dataSell.off = vlr_desconto;

		MostraDisplayValores();
	})*/

	function AplicaDesconto(){
		var desconto = $('#desconto').val();
		vlr_desconto = CalculoDesconto( dataSell.total_venda_sd , desconto );
		$('#vlr_pago').val(dataSell.total_venda_sd - vlr_desconto)
		vlr_total = dataSell.total_venda_sd - vlr_desconto;	
		dataSell.total_venda = vlr_total
		dataSell.off = vlr_desconto;

		return { vlr_desconto : vlr_desconto }
	}

	$('#desconto').twovalues({
		input_1 : { symbol: '%', 
					label: 'Porcentagem', 
					class : 'input-lg focus-select-range',  
					keydown: function( e ){
						if( e.which == 32 ){													

							$(this).parents('.twov:eq(0)')
							.hide()
							.removeClass('active')
							.next()
							.addClass('active')
							.show()
							.find('input')
							.focus()

							return false;
						}
					},
					keyup: function( e ){


						$('#desconto').val( $(this).val() )
						var res = AplicaDesconto();

						MostraDisplayValores();

						$(this).parents('.twov:eq(0)')
						.next()
						.find('input')
						.val( MoneyFormat( res.vlr_desconto , '', ".") )

						$(this).parents('.twov:eq(0)')
						.parent()
						.find('.help-block')
						.html( "Desconto de "+MoneyFormat( vlr_desconto ) )
						

					}, 
					active : 'active',
					type : "" },
		input_2 : { symbol: '$', 
					label: 'Monetário', 
					class : 'input-lg focus-select-range', 
					keydown: function( e ){
						if( e.which == 32 ){														
								
							$(this).parents('.twov:eq(0)')
							.hide()
							.removeClass('active')
							.prev()
							.addClass('active')
							.show()
							.find('input')
							.focus()

							return false;
						}
					},
					keyup: function( e ){

						var perc = ConvertValorEmPerc( Number($(this).val()), dataSell.total_venda_sd );
						$('#desconto').val( perc )
						var res = AplicaDesconto();
						MostraDisplayValores();

						$(this).parents('.twov:eq(0)')
						.prev()
						.find('input')
						.val( perc )

						$(this).parents('.twov:eq(0)')
						.parent()
						.find('.help-block')
						.html( "Desconto de "+Number(perc)+" %" )

					},
					type : "money" }
	})

	setTimeout(function(){
		$('.twov_field_1 input').focus();
	},500)	


	function SaveVenda(){		
		if( ItensVenda.length ){

			var itens = [];

			for( var i in ItensVenda ){
				itens.push({	"produto_id"	 : ItensVenda[i][0] ,
								"quantidade"	 : ItensVenda[i][3] ,
								"valor_item" 	 : ItensVenda[i][4] 
							})
			}

			var fracionado = new Object();
			if( dataSell.forma == 5 ){
				$('.fracionar-list input').each(function(){
					fracionado[ $(this).data('forma') ] = Number($(this).val())
				})

				console.log( fracionado )
			}

			var request = {	"cliente_id"	: null ,
							"desconto"		: $('#desconto').val(),
							"valor"			: null,
							"status"		: "F",
							"itens"			: itens,
							"forma"			: dataSell.forma,
							"vlr_pago"		: dataSell.vlr_pago,
							"fracionado"	: fracionado,
							"fisica_id"		: $('#cadastro-cliente #id').val()
						  }

			switch( ConfereValorVenda() ){
				case 2:
						// Foca no valor do pagamento
						//$('#vlr_pago').focus();
						return false;

					break;
				case 3:
						
						// Acrescenta forma de pagamento
						//AdcionarFormaPagto();
						return true;

					break;
				case 1:

					venda.call('save',[JSON.stringify( request )],function( ret ){

						if(ret.success){
							FecahrFormPagamento()
							AlertMessage( $('#page-content'), 'success', "Sucesso", "Venda concluída com sucesso!", 3000 );
							LimparTelaVenda()

						} else {
							AlertMessage( formElement, 'warning', "Atenção", ret.message, 3000 );
						}

					});
					
					break;
			} 

		} else {

			AlertMessage( $('#datagrid').parent(), 'warning', "Atenção", "Nenhum item na venda!", 3000 );

		}

		return true;
	}

	function ConfereCPF( cpf, callback ){

		//pessoaPF.filter = {'CPF':cpf};
		pessoaPF.call('selectByCPF',[cpf],function( ret ){
			if(callback) callback(ret, pessoaPF.data )
		})

	}

	function ConfereCadastroCliente(){
		return false;
	}

	function ConfereLimite( limite ){
		
		$('#cadastro-cliente .alert ').remove()
		if( dataSell.total_venda > Number(limite) ){
			AlertMessage( $('#cadastro-cliente'), 'warning', "Atenção", "O valor da compra excede o limite do cliente! Limite de <B>"+MoneyFormat(limite)+"</B>" );
		}

	}

</script>