<?php
	include('../util/config.php');
	$caixa = new CaixaController;	
	if ( !$caixa->check_caixa_aberto() ){
		header("Location: abrir_caixa.php");
	}
?>

<div class="row">
	<div class="col-md-9">
		<div class="input-group input-group-lg">
	      	<input type="text" class="form-control active" placeholder="Digite o código ou Cod. Barra" id='produto'>
      		<span class="input-group-btn">
	        	<button class="btn btn-success add" type="button">Adicionar</button>	        	
	        	<button class="btn btn-default help" type="button" data-help="10" placement="bottom"><span class="glyphicon glyphicon-question-sign"></span></button>
	      	</span>	      	
	   	</div>

	</div>
	<div class="col-md-3">
		<div class="input-group input-group-lg">
	      	<input type="text" class="form-control" id='pesquisar-produto' placeholder="Pesquisar...">
      		<span class="input-group-btn">
	        	<button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-search"></span></button>
	        	<button class="btn btn-default help" type="button" data-help="15" placement="left"><span class="glyphicon glyphicon-question-sign"></span></button>
	      	</span>
	   	</div><!-- /input-group -->		
	</div>
</div>
<div class="clearfix">&nbsp;</div>
<div class="row" id='content'>
	<div class="col-md-9">
 		<table class="table table-hover table-bordered display" id='datagrid' >
				  						 		
		</table>
  	</div>
  	<div class="col-md-3">
  		<ul class="list-group ">
			<li href="#" class="list-group-item list-group-item-warning">
			    <p class="text-center">
					<h1 id='totalitens' class="text-center">R$ 0,00</h1>
				</p>
		  	</li>
		  	<!-- <li class="list-group-item">
		  		<label for="exampleInputEmail1">Valor Pago</label>
				<input class="form-control" id="vlr_pago" name='vlr_pago' data-type='money' />
		  	</li>
		  	<li class="list-group-item">Troco: <strong id='troco'>R$ 0,00</strong></li>  -->
		  	<li class="list-group-item">
		  		<p class="text-center">
		  			<button type="button" class="btn btn-success  pagamento">Pagar Agora</button>
				</p>		  		
		  	</li>
		  	<!-- 
		  	
		  	-->
		</ul>
  	</div>
</div>


<script type="text/javascript">
var payment = false;
var produtos = null;
var venda = null;

	$(function(){

		$('.btn.add').click(function(){
			ProdutoPorCodigo( $('#produto').val() )
		})

		InitTelaVenda();

		salling = true;
		$('.btn.pagamento').click(function(){
			EfetuarPagamento()
		})

		$('.btn.fiado').click(function(){
			EfetuarPagamento()
		})

		// confere se tem caixa aberto
		produtos = new $PHP('ProdutoController');
		venda = new $PHP('vendaController');
		fisicaConta = new $PHP('fisicaContaController');

		Keyboard_step = 'sell';
		Payment_step = 'pay_discount';

	})

	// Depois que carerga a tela de Venda
	function InitTelaVenda(){

		LoadItensVenda( true );
		
		$('#produto').focus(function(){
			$(this).addClass('active')
		}).focus();

		$('#produto').blur(function(){
			$(this).removeClass('active')
		});
	}

	// Procura Produto por Codigo
	function ProdutoPorCodigo( vlr ){

		if( vlr ){
				
			produtos.call('selectBycode',[vlr],function( ret ){

				if( ret.success ){
					
					Keyboard_step = 'quantidade';

					$('#produto').val('');
					var data = produtos.data
					var unidade_id = data.unidade_id;
					var estoque_min = Number(data.estoque_min);
					var estoque = Number(data.estoque);
					if( estoque <= estoque_min ){
						Notify( "Produto com pouco estoque!!", "warning" )
					}

					Modal( 'Quantidade', 'internals/form.php', function(){					

						var formElement = $('#modal .modal-body form');

						CallForm('forms/quantidade.json', formElement, function(){

							initJs();

							formElement.removeClass('thre-columns').addClass('two-columns');

							LoadDataForm(formElement,data)

							// define campo valor do item igual o valor unitario do produto
							formElement.find('#valoritem').val( formElement.find('#valor').val() )
							formElement.find('#quantidade').prop('autocomplete','off');

							switch( Number(unidade_id) ){
								case 1: // Unidade
										// Focu da quantidade
										setTimeout(function(){
											// Seleciona o campo quantidade
											formElement.find('#quantidade').selectRange(0,10);
											// ao sair do campo...
											formElement.find('#quantidade').unbind('blur').blur( function(){
												// Seleciona o campo quantidade
												formElement.find('#quantidade').selectRange(0,10);
											}).blur();

										},500)
										
										// Ao presscionar algum valor no campo quantidade
										formElement.find('#quantidade').keypress(function( e ){
											
											switch( e.which ){
												// ENTER
												case 13:
														AdicionaItemVenda();
														return false;
													break;

												// MAIS
												case 43:
														
														$(this).val( Number( $(this).val() ) + 1 )
														return false;

													break;									

												// MENOS
												case 45:
														
														$(this).val( Number( $(this).val() ) - 1 )
														return false;

													break;

											}

										}).keyup(function(){

											// Ao soltar a tecla
											// Se o campo for 0 deixa 1
											if( $(this).val() == 0 ) $(this).val(1);

											clearInterval(interval);
											interval = setInterval(function(){
												
												// Calcula o valor da quantidade x o valor
												CalculateAmountItem()
												// Seleciona o campo quantidade
												formElement.find('#quantidade').selectRange(0,10);

											},500);
										})
									break;

								case 2: // Livre

										formElement.find('#quantidade').attr('disabled','disabled');
										formElement.find('#valoritem').removeAttr('disabled').removeAttr('readonly').val('');
										setTimeout(function(){
											formElement.find('#valoritem').focus();
										},500)

									break;

								default: // Kg, Ml, Mt

										formElement.find('#quantidade').twovalues({
										input_1 : { symbol: 'Kg', 
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
														formElement.find('#quantidade').val( $(this).val() )
														CalculateAmountItem()

														$(this).parents('.twov:eq(0)')
														.next()
														.find('input')
														.val( formElement.find('#valoritem').val() )
														
														$(this).parents('.form-group:eq(0)')
														.find('.help-block')
														.html( MoneyFormat( formElement.find('#valoritem').val() ) )

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
														formElement.find('#quantidade').val( ConvertValorParaPeso( $(this).val() ) )

														$(this).parents('.form-group:eq(0)')
														.find('.help-block')
														.html( Number(formElement.find('#quantidade').val()).toFixed(3)+" Kg"  );

														$(this).parents('.twov:eq(0)')
														.prev()
														.find('input')
														.val( Number(formElement.find('#quantidade').val()).toFixed(3) )

														CalculateAmountItem()

													},
													type : "money" }
									})

									InitInputs()

									setTimeout(function(){
										formElement.find('.form-group.quantidade .twov_field_1 input').decimal(3)
										formElement.find('.form-group.quantidade .twov_field_1 input').focus();									
									},500);

									break;
							}
						

						}, function(){
							AdicionaItemVenda();
						});
					}, 'md')	
				} else {
					AlertMessage( $('#datagrid').parent(), 'warning', 'Desculpe!', ret.message, 3000 )
					//alert( ret.message )
				}			
			})
		}	
	}

	function LoadItensVenda( keyEvent ){

		if( ItensVenda ){

			// Carrega itens do pedido
			DataTable = $('#datagrid').DataTable({
		        scroller: true,
	        	paging:  false,
	        	searching: false,
				data: ItensVenda ,
				rowId: '0',
		        columns: [
		            { title: "ID", width: "10%" },
		            { title: "Produto", width: "30%" },
		            {
		                title : "Valor",
		                width: "20%",
		                "render": function ( data, type, full, meta ) {

		                	return MoneyFormat(full[2].toFixed(2));
		                }
		            },
		            { title: "Qnt.", width: "20%" },
		            {
		                title : "Valor Item",
		                width: "20%",
		                "render": function ( data, type, full, meta ) {

		                	return "<b>"+MoneyFormat(full[4].toFixed(2))+"</b>";
		                }
		            }
		        ],
		        destroy: true
		    });

			
		} 

		TotalItens();
	}

	function TotalItens(){

		$('#totalitens').html( MoneyFormat( TotalVenda() ) )	
		
	}

	function TotalVenda(){

		var total = 0;	
		if( ItensVenda && ItensVenda.length ){
			for( var i in ItensVenda ){
				total += Number( ItensVenda[i][4] );
			}	
		}

		return total.toFixed(2);

		
	}

	// Calculos

	function CalculateAmountItem(){

		// Calcula a quantidade x valor para item
		var formElement = $('#modal .modal-body form');
		var valor = Number(formElement.find('#valor').val())
		var quantidade = Number(formElement.find('#quantidade').val())
		formElement.find('#valoritem').val( MoneyFormat( CalculateAmount( quantidade, valor ) , '', ".")  );
		clearInterval(interval);

	}

	function CalculateAmount( qnt, vlr ){
		return qnt * vlr;
	}

	// Adiciona item na tela de venda para envio posterior 
	function AdicionaItemVenda(){
		
		// identifica form Element
		var formElement = $('#modal .modal-body form');

		var id = formElement.find('#id').val();		
		var nome = formElement.find('#nome').val();
		var valor = Number(formElement.find('#valor').val());
		var unidade = formElement.find('#unidade_id').val();
		var valoritem = Number(formElement.find('#valoritem').val());
		var qnt = formElement.find('#quantidade').val();
		if( Number(unidade) > 2 ) qnt = Number(qnt).toFixed(3)

		var newLine = true;
		if( unidade == '1' ){
			newLine = AdicionaRemoveItem( id, qnt);
		}

		if( unidade == '2' ){
			valor = valoritem;
		}

		// Nova linha
		if( newLine ){
			// Nova linha Pedido
			var newline = [	id ,
							nome,
							valor,					
							qnt,
							CalculateAmount( qnt , valor ),
							unidade ];

			// Adiciona nova linha
			ItensVenda.push( newline );	
			// Adiciona nova linha ao datatable
			DataTable.row.add( newline ).draw( false );

		} 

		// Adiciona nova linha ao storage
		localStorage.setItem( 'ItensVenda', JSON.stringify(ItensVenda) );

		// Recarrega o tabela
		LoadItensVenda()
		
		// fecha o modal
		$('.modal-close').click();
	}

	function AdicionaRemoveItem( id, qnt ){

		var newLine = true;
		// procura se o produto j?est?adicionados aos itens

		var q = 0;
		// Varre os itens
		for( var i in ItensVenda ){
			if( ItensVenda[i][0] == id ){
				q = Number( ItensVenda[i][3] );
				ItensVenda[i][3] = q + Number(qnt) ;

				if( Number(ItensVenda[i][3]) <= 0 ){

					ItensVenda.splice(i, 1);

				} else{

					// Calcula Item por quantidade
					ItensVenda[i][4] = CalculateAmount( Number( ItensVenda[i][2] ), Number( ItensVenda[i][3]) );

				}			

				newLine = false;
				break;
			} 
		}

		if( !newLine ){
			// Adiciona nova linha ao storage
			localStorage.setItem( 'ItensVenda', JSON.stringify(ItensVenda) );
		}
		
		return newLine;

	}

	var mode = 'forma1';

	function CalculteRest( vlr_total, vlr_pago ){
		var troco = '';
		troco = Number(vlr_pago) - Number(vlr_total)
		//console.log( vlr_pago + " - " + vlr_total + " = "+ troco)
		return troco;
	}

	function CalculoDesconto( vlr, desconto ){
		return ( ( desconto * vlr ) / 100 );
	}

	function EfetuarPagamento(){

		if( ItensVenda.length ){

			$('#modal').data('keyboard',false);
			//Modal( "Efetuar Pagamento", 'internals/form.php', function(){ CreateFormPgto() } , 'lg')
			Modal( "Efetuar Pagamento", 'internals/form_pagamento.php', function(){ 
				Keyboard_step = 'payment';
				Payment_step = 'pay_discount';
				CreateFormPgto() 
			} , 'lg', null, null);

		} else {

			AlertMessage( $('#datagrid').parent(), 'warning', "Atenção", "Nenhum item na venda!", 3000 );

		}

	}

	function EfetuarPagamentoConta(){

		//$('#modal').data('keyboard',false);
		Modal( "Pagar Conta Cliente", 'internals/pagar_conta.php', function(){ 
			var formElement = $('#modal .modal-body form');
			formElement.attr('action','');
			CallForm('forms/pagar_conta.json', formElement, function(){

				ComboPessoasFisica( formElement.find('#fisica_id') )
				ComboFormas( formElement.find('#forma_pagto_id'), null, 'c' );
				
				var formas = new $PHP('forma_pagtoController');
				formas.loaded = function(){
					formas.call('selectAll',[0,4,'c'],function( ret ){

						$('.form-group.fracionado').html('')
						var html = '';
						var fracionar = [];
						var len = formas.data.length;
						var pos = '';
						var active = 'active';
						var ind = "first";

						for( var i in formas.data ){
							pos = '';	
							if( i == (formas.data.length - 1) ) ind = 'last';
							html_ = "<div class='col-sm-12 parent'>";
								html_ += "<label class='col-sm-6 control-label'>"+formas.data[i].nome+"</label>";
								html_ += "<div class='col-sm-6'><input class='form-control input-sm focus-select-range "+active+" "+ind+" ' type='text' placeholder='' data-type='money' data-forma='"+formas.data[i].id+"' ></div>";
							html_ += "<div class='clearfix'>&nbsp;</div></div>";
							fracionar.push( html_ )	;	
							active = '';
							ind = '';

						}
						$('.form-group.fracionado').html( "<div class='row fracionar-list form-horizontal'>" + fracionar.join('') +"</div>" )
						
						$('.fracionar-list input').unbind('keydown').keydown(function( e ){

							if( e.which == 13 ){

								if( $(this).hasClass('last') ){

									LancaCredito()

								} else {

									var next = $(this).parents('.parent:eq(0)').next().find('input')

									if( PegaValorFracionado() && !next.val() ){
										next.val( DiferencaValorFrancioado_() )	
									}
									
									next.focus();		

								}
								

								return false;
							}

							if( e.which == 27 ){

								if( $(this).hasClass('first') ){
									$('#forma_pagto_id').focus()
								} else {
									$(this).val('0.00');
									$(this).parents('.parent:eq(0)').prev().find('input').focus();	
								}								

								return false;
							}

						}).unbind('keyup').keyup(function(){
							formElement.find('#valor').val( MoneyFormat( PegaValorFracionado() , '', ".") );
							MostraDisplayPC(formElement)
						})

						InitInputs()

					})
				}

				initJs();

				InitFormPagamentoConta(formElement)

			}, function( ret ){

					

			})
		}, 'lg', null, null);

	}

	function FechamentoCaixa(){

		if( !ItensVenda.length ){

			Modal( "Fechamento de Caixa", 'internals/fechar_caixa.php', function(){
				
				setTimeout(function(){$('#valor_fechamento').focus()},500);
				
			} , 'md');

		} else {

			AlertMessage( $('#datagrid').parent(), 'warning', "Atenção", "Existe uma venda aberta. Feche ou conclua!", 3000 );

		}

	}



	function LimparTelaVenda(){

		ItensVenda.length = 0;
		localStorage.setItem('ItensVenda','');
		LoadItensVenda();

	}

	function ConfereValorVenda(){

		var vlr_total = ConvertMoneytoFloat( $('#total').text() );
		var vlr_pago = dataSell.vlr_pago;

		if( !vlr_pago ){  
			return 2;
		}

		if( vlr_pago < vlr_total ){
			return 3;
		}

		return 1;

	}

	function DiferencaValor(){
		var vlr_total =  ConvertMoneytoFloat( $('#total').text() );
		var vlr_pago = PegaValorPago();
		
		return Number( (vlr_total - vlr_pago) );	
	}


	function CreateFormPgto(){

		

	}

	var dataPC = 	{	
						saldo : 0,
						desconto : 0,
						vlr_pago : 0
					}
	function InitFormPagamentoConta( formElement ){

		Keyboard_step = 'pagar_conta';
		formElement.find('#desconto,#forma_pagto_id,#valor').attr('disabled','disabled');
		$('.form-group.fracionado').hide();

		/*
		formElement.find('#desconto').unbind('keyup').keyup(function(){
			MostraDisplayPC(formElement);
		})
		*/

		formElement.find('#desconto').twovalues({
		loaded: function(){
			$('.twov input').attr('disabled','disabled').css('width','80%');
			$('.twov:eq(0) input').decimal(2);

		},
		input_1 : { symbol: '%', 
					label: 'Porcentagem', 
					class : 'focus-select-range',  
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

						if( e.which == 13 ){

							$(this).parents('.form-group:eq(0)').next().find('input,select').focus();	

							return false;
						}
					},
					keyup: function( e ){

						formElement.find('#desconto').val( $(this).val() )
						//var res = AplicaDesconto();
						MostraDisplayPC(formElement);

						/*
						$(this).parents('.twov:eq(0)')
						.next()
						.find('input')
						.val( MoneyFormat( res.vlr_desconto , '', ".") )
						*/

						/*
						$(this).parents('.twov:eq(0)')
						.parent()
						.find('.help-block')
						.html( "Desconto de "+MoneyFormat( vlr_desconto ) )
						*/
						

					}, 
					active : 'active',
					type : "" },
		input_2 : { symbol: '$', 
					label: 'Monetário', 
					class : 'focus-select-range', 
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

						if( e.which == 13 ){

							$(this).parents('.form-group:eq(0)').next().find('input,select').focus();	

							return false;
						}
					},
					keyup: function( e ){

						var perc = ConvertValorEmPerc( Number($(this).val()), dataPC.saldo);
						formElement.find('#desconto').val( perc )
						//var res = AplicaDesconto();
						MostraDisplayPC(formElement);

						/*$(this).parents('.twov:eq(0)')
						.prev()
						.find('input')
						.val( perc )

						$(this).parents('.twov:eq(0)')
						.parent()
						.find('.help-block')
						.html( "Desconto de "+Number(perc)+" %" )*/

					},
					type : "money" }
		})


		formElement.find('#valor').unbind('keyup').keyup(function(){
			MostraDisplayPC(formElement);			
		})

		formElement.find('#valor,#forma_pagto_id').unbind('keydown').keydown(function( e ){

			if( e.which == 13 ){

				if( $(this).hasClass('last') ){
					LancaCredito()
				} else {
					$(this).parents('.form-group:eq(0)').next().find('input,select').focus();	
				}
				

				return false;
			}

			if( e.which == 27 ){

				$(this).parents('.form-group:eq(0)').prev().find('input,select').focus();

				return false;
			}

		})

		$('#forma_pagto_id').unbind('keydown').keydown(function( e ){
			switch( e.which ){
				case 13:
					$(this).parents('.form-group:eq(0)').next().find('input,select').focus();
					break;
				case 27: $(this).parents('.form-group:eq(0)').prev().find('input,select').focus(); return false; break;
				case 49: case 97: $(this).val(1); break;
				case 50: case 98: $(this).val(2); break;
				case 51: case 99: $(this).val(3); break;				
				case 52: case 100: $(this).val(5); break;
			}

			$(this).change()

			return false;
		}).unbind('change').change(function(){
			if( $(this).val() == 5 ){
				$('.form-group.valor').hide();
				$('.form-group.fracionado').show();
				$('.fracionar-list input:eq(0)').focus();
			} else {
				$('.form-group.fracionado').hide();
				$('.form-group.valor').show();
			}
		})


		setTimeout(function(){ formElement.find('.form-group.fisica_id button:eq(0)').focus() }, 500 );
		$('#fisica_id').on('change', function(){
		   	formElement.find('.alert').remove();
		   	formElement.find('#desconto,#forma_pagto_id,#valor').attr('disabled','disabled');
		   	$('.twov input').attr('disabled','disabled');
			$('.form-group.fracionado').hide();

		   	var id = $('.selectpicker option:selected').val();

			if( id ){
				var pessoas = new $PHP('fisicaController');
			   	pessoas.loaded = function(){
					pessoas.call('selectById',[id],function( ret ){

						if(ret.success){
							dataPC.saldo = Math.abs(pessoas.data.saldo);

							if( pessoas.data.saldo != '0'){
								formElement.find('#desconto,#forma_pagto_id,#valor').removeAttr('disabled');	
								$('.twov input').removeAttr('disabled')							
								MostraDisplayPC( formElement )
								//$('#desconto').focus();								
								$('.twov:eq(0) input').focus();

							} else {

								AlertMessage( formElement, 'warning', "Atenção!", "Cliente sem débitos!" );

							}

							
						}
					})
				};
			}		   	

		});
	}

	function MostraDisplayPC( formElement ){
		$('.resumo-conta-cliente').show();
		var vlr_total = dataPC.saldo;
		var desconto = Number( formElement.find('#desconto').val() );

		var vlr_desconto = CalculoDesconto( vlr_total, desconto );
		vlr_total -= vlr_desconto;

		var valor = Number( formElement.find('#valor').val() );
		var rest = CalculteRest( vlr_total, valor );
		if( rest < 0 ) rest = 0;

		$('.resumo-conta-cliente .total').html( "<kbd>Débido</kbd> "+MoneyFormat( vlr_total ) );
		$('.resumo-conta-cliente .pago').html( "<kbd>Pago</kbd> "+MoneyFormat( valor ) );
		$('.resumo-conta-cliente .troco').html( "<kbd>Troco</kbd> "+MoneyFormat( rest ) );
		$('.resumo-conta-cliente .off').html( "<kbd>Econ.</kbd> "+MoneyFormat( vlr_desconto ) );
	}

	function PegaValorFracionado(){

		var vlr_pago = 0;
		$('.fracionar-list input').each(function(){
			vlr_pago += Number($(this).val())
		})
		
		return vlr_pago;
	}

	function DiferencaValorFrancioado_(){
		var vlr_total =  dataPC.saldo;
		var vlr_pago = PegaValorFracionado();
		var calc = Number( vlr_total - vlr_pago );

		return calc.toFixed(2);	
	}

	function LancaCredito( confirm ){
		var formElement = $('#modal .modal-body form');
		formElement.find('.alert').remove()

		if( confirm ){

			var dataSend = SerializeObject(formElement.serializeArray());
			var fracionado = new Object();
			if( $('#forma_pagto_id').val() == 5 ){
				$('.fracionar-list input').each(function(){
					fracionado[ $(this).data('forma') ] = Number($(this).val())
				})

				dataSend.fracionado = fracionado;			
			}

			// Envia as informações ...
			fisicaConta.call('save',[JSON.stringify( dataSend )],function( ret ){
				if(ret.success){

					$('.modal-close').click();
					AlertMessage( $('#datagrid').parent(), 'success', "Sucesso!", "Pagamento efetuado com sucesso!", 3000 );

				} else {

					var msg = ret.message;

					if( typeof ret.message === 'object' ){
						var msg_ar = [];
						for( var i in ret.message ){
							msg_ar.push( ret.message[i] );
						}
						msg = msg_ar.join('<BR>');
					} 
					
					AlertMessage( formElement, 'warning', "Erro!", msg );
					

				}
			})	
		} else {

			ModalConfirm( 	'Confirmar Pagamento', 
							'Pressione ENTER para Confirmar e ESC para Cancelar', 
							function(){
								LancaCredito( true )
							},
							function(){

								formElement.find('#valor').focus()

							} )

		}		

	}

	function ConvertValorParaPeso( vlr ){
		var formElement = $('#modal .modal-body form');
		var vlr_produto = formElement.find('#valor').val();
		var calc = Number(vlr / vlr_produto);
		var rd = Math.ceil(calc)

		return  calc;	
	}

	function ConvertValorEmPerc( vlr, total ){
		var total_venda = Number(total) ;
		var calc = Number((vlr / total_venda)*100);
		//var rd = Math.ceil(calc)

		return  calc.toFixed(2);	
	}

	function PesquisaProduto(){
		Modal( 'Pesquisar Produtos', 'internals/pesquisa.php', function(){					

			
		}, 'lg')
	}

	function PesquisaVenda(){
		Modal( 'Pesquisar Venda', 'internals/pesquisa_vendas.php', function(){					

			
		}, 'lg')
	}

</script>
