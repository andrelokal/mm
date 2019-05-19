var time = 0;
var focus_in_sec = 1;

function ZeraTempo(){
	if( uri && uri.indexOf('sell.php') != -1 && Keyboard_step == 'sell' ){
		if( !$(':focus').is('input,textarea,select') ){
			time = 0;
		}
	}
}

$(function(){

	setInterval(function(){ 
		if( uri && uri.indexOf('sell.php') != -1 && Keyboard_step == 'sell'){
			if( !$(':focus').is('input,textarea,select') ){
				time++;
				if(time >= focus_in_sec ){			
					$('#produto').focus();
				}
			} else {
				time = 0;
			}			
		}		

	}, 1000)

	$(document).mousemove(function(){
		ZeraTempo()		
	})

	$(document).mousedown(function(){
		ZeraTempo()		
	})
	// MODE KEYBOARD
	$(document).keydown(function( e ){

		if( confirming !== false){
			if( e.which == 13){
				if( typeof confirming == 'function' ) confirming();
				$('#modal-confirm').modal('hide')
				$('##modal-snh-adm').modal('hide')
				confirming = false;
			} 

			if( e.which == 27){
				$('#modal-confirm').modal('hide')
				confirming = false;
			} 

			return false;
		}

		if( uri && uri.indexOf('sell.php') != -1 ){

			var key = e.which;
			var focused = $(':focus');
			console.log( Keyboard_step+" = "+key + " - field: "+focused.attr('id') );

			switch( Keyboard_step ){
				case 'quantidade': // TELA VENDA
						switch( key ){
							case 13:
								AdicionaItemVenda();
								return false;
							break;
						}
						return true;

					break;
				case 'sell': // TELA VENDA
					switch( key ){
						case 112: // F1     >> Pagamento
						case 32: // SPACE	>> Pagamento 

							if( focused.attr('id') != 'pesquisar-produto' ){
								EfetuarPagamento();
								return false;	
							}
							
							break;

						case 114: // F3 	>> Fechamento de Caixa
							FechamentoCaixa();
							return false;
							break;

						case 115: // F4 	>> Limpar Venda
							if( confirm('Tem certeza que deseja continuar ?') ){
								LimparTelaVenda();	
							}							
							return false;
							break;

						case 117: // F6 	>> Pagar Conta Cliente
							EfetuarPagamentoConta();						
							return false;
							break;

						case 118: // F7 	>> Pesquisar Venda
							PesquisaVenda();						
							return false;
							break;


						case 13: // ENTER 	>> Procura Produto

								switch( focused.attr('id') ){
									case 'produto':
										ProdutoPorCodigo( $('#produto').val() );
										return false;
										break;
									case 'pesquisar-produto':

										PesquisaProduto();

										return false;
										break;
								}

								return true;
							
							break;

						// Para baixo
						case 40:

								$('#datagrid').click()
								
								return false;
							break;

						// Para direita
						case 39:

								$('#pesquisar-produto').focus()
								
								return false;
							break;

						// Para esquerda
						case 37:

								$('#produto').focus()
								
								return false;
							break;
					}

					return true;

					break;

				case 'payment': // TELA PAGAMENTO

					
					switch( Payment_step ){
						case 'pay_discount': // Desconto

								switch( key ){
									case 13: // ENTER
										
										PayGoStep('pay_start');										

										return false;
										break;
								}

							break;
						case 'pay_start': // Start
								switch( key ){
									case 13: // ENTER
										
										PayGoStep('pay_value');

										return false;
										break;

									case 49: case 97: chooseForma( 1 ); return false; break; // dinheiro
									case 50: case 98: chooseForma( 2 ); return false; break; // debito
									case 51: case 99: chooseForma( 3 ); return false; break; // credito
									case 52: case 100: chooseForma( 4 ); return false; break; // conta
									case 53: case 101: chooseForma( 5 ); return false; break; // francionado

									case 39: // Direita

										NextForma();
										return false;

										break;

									case 37: // Esquerda
										
										PrevForma();
										return false;

										break;

								}

							break;
						case 'pay_value': // Valor Pago

								switch( key ){
									case 13: // ENTER

										switch( dataSell.forma ){
											case 4 : // Conta cliente

												PayGoStep('pay_account');
												break;

											case 5: // fracionar

												// Confere se o campo conta cliente está preenchido
												NextFormaFrancionado();
												
												break;

											default :

												PayGoStep('pay_confirm');	
																								
												break;

										} 						

										return false;
										break;

									case 27: // ESC

										switch( dataSell.forma ){
											case 5:
													PrevFormaFrancionado()	
													
													return false;
													break;
												break;
											default :
												PayPrevStep();
												return false;
												break;	
										}
										
								}

							break;
						case 'pay_account':
								switch( key ){
									case 13: // ENTER

										switch( dataSell.forma ){
											
											case 5 : // Fracionado
												if( !$("[data-forma=4]").val() ) break;
											case 4 : // Conta cliente

												switch( key ){
													case 13: // ENTER
														
														NextInputContacliente()

														return false;
														break;
												}

												return true;
												break;

										} 						

										return false;
										break;

									case 27: // ESC

										switch( dataSell.forma ){
											case 5 : // Fracionado
												if( !$("[data-forma=4]").val() ) break;
											case 4 : // Conta cliente

												PrevInputContacliente()

												return false;
												break;
										}
										
								}
							break;
					
						case 'pay_confirm': // Confirma

								switch( key ){
									case 13: // ENTER
										
										PayGoStep('pay_end');										

										return false;
										break;

									case 27: // ESC

										if( dataSell.forma != 4 ){
											PayGoStep('pay_value');
											return false;
										}
										break;
								}

							break;
						case 'pay_end': // end



							break;
					}

					switch( key ){
						case 27: // ESC						

							PayPrevStep();

							return false;
							break;
						
					}

					break;

			}			
			
		}
		
	})

})


function chooseForma( n ){

	$('.choose').hide();
	$('.options-forma li').removeClass('active'); 
	$('.options-forma a[href='+n+']').parent().addClass('active');
	dataSell.forma = Number(n);

	switch( n ){
		case 5: // Fracionar
				$('.pagto-2').show();
			
			break;

		default: // Forma 1,2,3

				dataSell.vlr_pago = dataSell.total_venda;
				MostraDisplayValores()
				$('.pagto-1').show();

			break;
	}
	
}

function NextForma(){

	var n = Number(dataSell.forma) + 1 ;
	if( n > $('.options-forma li').length ) n = 1;
	chooseForma( n );

}

function PrevForma(){
	var n = Number(dataSell.forma) - 1 ;
	if( n < 1 ) n = $('.options-forma li').length;
	chooseForma( n );

}

function PayGoStep( step ){

	var tab = $("#TabPayment a[href='#"+step+"']")
	if( !tab.parent().hasClass('active') ){
		tab.click();	
	} 

	switch( step ){

		case 'pay_discount':
			$('#vlr_pago').val( dataSell.total_venda );
			//$('#desconto').focus();
			$('.twov.twov_field_1 input').focus();
			break;

		case 'pay_start':

			dataSell.vlr_pago = dataSell.total_venda;
			$('#vlr_pago').val( MoneyFormat( dataSell.vlr_pago , '', ".") )
			MostraDisplayValores()

			break;

		case 'pay_value':
			//console.log( dataSell )
			switch( dataSell.forma){

				case 1 : // Dinheiro
						$('#vlr_pago').removeAttr('disabled').focus();
					break;

				case 5: // Fracionado
						var fraActive = $('.fracionar-list input.active');
						if( !fraActive.val() ){
							fraActive.val( DiferencaValorFrancioado() ).focus();
						} else {
							fraActive.focus();
						}

						$('.fracionar-list input').unbind('keyup').keyup(function(){
							$('#vlr_pago').val( PegaValorFracionado() );
							MostraDisplayValores()
						})
					break;

				default :
					//PayNextStep();
					$('#vlr_pago').attr('disabled','disabled');

			}

			break;

		case 'pay_account':

			$('#cadastro-cliente input').unbind('focus').focus(function(){
				$('#cadastro-cliente input').removeClass('active')
				$(this).addClass('active');
			})	
			$('#vlr_pago').attr('disabled','disabled');
			//$('.loading').remove()
			$('#cpf').unbind('keyup').keyup(function( e ){

				if( e.which == 13 ) return false;

				if( $(this).val().length == 14 ){
					ConfereCPF( $(this).val(), function( ret, data_ ){
						if( ret.success ){

							var id = data_.id;
							var data = data_;
							$.extend( data, data_.pessoa );
							data.id = id;

							// Confere Limite
							ConfereLimite( data.limite_conta )

							LoadDataForm( $('#cadastro-cliente'), data, 'CadastroCliente' );

						} else {

							$('#nome,#email,#telefone,#id').val('');

							$('#cpf').parent().find('.help-block').remove()
							$('#cpf').after('<span class="help-block">Cliente inexistente</span>')
							$('#cpf').parents('.form-group:eq(0)').addClass('has-error');
							
							setTimeout(function(){
								$('#cpf').parents('.form-group:eq(0)').removeClass('has-error')
								$('#cpf').parent().find('.help-block').remove();
							},3000);


							//AlertMessage( $('.cadastro-cliente'), 'warning', "Aten?o!", "CPF n? existem em nossa base", 3000 ); 
						}
					});

					return false;
				} else {
					$('#cpf').parents('.form-group:eq(0)').removeClass('has-error')
					$('#cpf').parent().find('.help-block').remove()
				}
			}).focus();
			
			//$('#cadastro-cliente input:eq(0)').focus()

			break;

		case 'pay_end':
			
			SaveVenda()

			break;
	}

	Payment_step = step;
}

function PayPrevStep(){

	var liAtive = $( '#TabPayment li.active' );
	if( liAtive.hasClass('fisrt') ){
		FecahrFormPagamento()
	} else {
		liAtive.prev().find('a').click();	
		Payment_step = $( '#TabPayment li.active a').attr('href').replace('#','');
		PayGoStep( Payment_step )
	}
}

function PayNextStep(){
	var liAtive = $( '#TabPayment li.active' )
	if( !liAtive.hasClass('last') ){
		liAtive.next().find('a').click();	
		Payment_step = $( '#TabPayment li.active a').attr('href').replace('#','');
		PayGoStep( Payment_step )
	}
}

function FecahrFormPagamento(){
	$('#modal').modal('hide')
	payment = false;
	Keyboard_step = 'sell';
	Payment_step = 'pay_discount';
}

function NextFormaFrancionado(){

	$('.tab-content .alert').remove()
	var rest_valor_fra = DiferencaValorFrancioado()
	var ative = $('.fracionar-list input.active')

	if( ative.hasClass('last') ){
		var troco =  CalculteRest( dataSell.total_venda, PegaValorFracionado() ) 
		if( troco > Number($('.fracionar-list input:eq(0)').val()) ){

			AlertMessage( $('.tab-content'), 'danger', "Erro!", "Troco está maior que a quantia em dinheiro!" );

		} else {
			if( Number($("[data-forma=4]").val()) ){
				PayGoStep('pay_account');
			} else {
				PayGoStep('pay_confirm');	
			}
			
		}
		
		return false;
	}

	if( rest_valor_fra <= 0 ){
		//PayGoStep('pay_confirm');
		//return false;
		rest_valor_fra = 0;
	}

	ative
	.removeClass('active')
	.parent()
	.next()
	.find('input')
	.addClass('active')
	.val( rest_valor_fra )
	.focus();
}

function PrevFormaFrancionado(){
	$('.tab-content .alert').remove()
	var ative = $('.fracionar-list input.active')

	if( ative.hasClass('first') ){
		PayGoStep('pay_start');
		return false;
	}

	ative
	.removeClass('active')
	.parent()
	.prev()
	.find('input')
	.addClass('active')
	.focus();

	ative.val('')
}


function DiferencaValorFrancioado(){
	var vlr_total =  dataSell.total_venda;
	var vlr_pago = PegaValorFracionado();
	var calc = Number( vlr_total - vlr_pago );

	return calc.toFixed(2);	
}

function NextInputContacliente(){

	var ative = $('#cadastro-cliente input.active')

	if( ative.hasClass('last') ){

		var data_form = SerializeObject($('#cadastro-cliente').serializeArray());
		var action = "Cadastrado";
		save = false;

		// Gravar Cliente
		if( $('#cadastro-cliente #id').val() ){

			if( CheckFormDataChanged( data_form, 'CadastroCliente')){
				action = "Alterado";
				save = true;
			} else {
				PayGoStep('pay_confirm');	
			}

		} else {
			
			save = true;

		}

		if( save )  {
			// Gravar novo Cliente
			var pessoas = new $PHP('fisicaController');
			pessoas.loaded = function(){
				pessoas.call('save',[JSON.stringify( data_form )],function( ret ){
					if(ret.success){
						
						AlertMessage( $('#cadastro-cliente'), 'success', "Sucesso!", action+" com sucesso! Pressione <B>ENTER</B> para continuar!", 3000 );
						if( pessoas.data.id ){
							$('#cadastro-cliente #id').val( pessoas.data.id )
						}

						ReloadFormDataChanged( $('#cadastro-cliente'), 'CadastroCliente' );

					} else {

						var msg = ret.message;

						if( typeof ret.message === 'object' ){
							var msg_ar = [];
							for( var i in ret.message ){
								msg_ar.push( ret.message[i] );
							}
							msg = msg_ar.join('<BR>');
						} 
						
						AlertMessage( $('#cadastro-cliente'), 'warning', "Erro!", msg, 3000 );
						

					}
				})
			};
		}
		
		return false;
	}
	
	ative
	.removeClass('active')
	.parents('.parent:eq(0)')
	.next()
	.find('input')
	.addClass('active')
	.focus();

}

function PrevInputContacliente(){

	var ative = $('#cadastro-cliente input.active')

	if( ative.hasClass('first') ){
		PayGoStep('pay_value');
		return false;
	}

	ative
	.removeClass('active')
	.parents('.parent:eq(0)')
	.prev()
	.find('input')
	.addClass('active')
	.focus();
}