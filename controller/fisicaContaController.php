<?php
     class fisicaContaController{
        
        private $obj;
        public $data;
        public $msg;
        private $validation;
        
        public function __construct(){
        	$this->validation = new Validation(PATH_ROOT.'util/validators.php');
            $this->obj = new FisicaConta();
        }    
       
        public function save($request){

            // Verifica caixa aberto
            $caixa = new CaixaController();
            if( !$caixa->check_caixa_aberto() ){
                $this->msg = 'Nenhum caixa aberto!';
                return false;
            } else {
                // seta id caixa
                $caixa_id = $caixa->data->id;
            }
            
            $arrayDados = json_decode($request, true);   

            // Valida Request
            if  ( !$this->validation->ValidateRequest( array( 'fisica_id'   => 'required|number',
                                                              'forma_pagto_id'  => 'required|number',
                                                              'valor'        => 'required'), $arrayDados ) ) {
                $this->msg = $this->validation->error_request;
                return false;
            }
	        
            if( !$arrayDados['desconto'] ) $arrayDados['desconto'] = '0';

            foreach($arrayDados as $key => $value){
                $arrayDados[$key] = $value == "" ? "null" : $value;
            }
                        
			// Confere lançamento
            $this->obj->fisica_id = $arrayDados['fisica_id'];
            $res = $this->obj->saldo();
            $pago = $arrayDados['valor'];
            $saldo_atual = $res->total + $pago;
            $troco = $pago + $res->total;

            if( $saldo_atual > 0 ){ // Saldo positivo

                if( $arrayDados['forma_pagto_id'] != 1 ){

                    // Fracionado
                    if( $arrayDados['forma_pagto_id'] == 5 ){

                        // tem parte em dinheiro ?
                        if( $arrayDados['fracionado'][1] ){
                            
                            // Se o saldo for maior que a parte em dinheiro
                            if( $saldo_atual > $arrayDados['fracionado'][1] ){
                                $this->msg = 'O troco ( R$ <b>'.number_format($troco,2,',','.').'</b> ) não pode ser maior que quantia em dinheiro ( R$ <b>'.number_format($arrayDados['fracionado'][1],2,',','.').'</b> )! ';
                                return false;     
                            } else {
                                // acerta o troco
                                $arrayDados['fracionado'][1] -= $troco;
                            }                          
                            
                        } else {
                            $this->msg = "Pagamento com <b>cartão</b> não pode haver troco!";
                            return false; 
                        }                       

                          

                    } else {
                        $this->msg = "Pagamento com <b>cartão</b> não pode haver troco!";
                        return false;    
                    }
                    
                }             
            } 

            // acerta o troco
            if( $troco > 0 ) $arrayDados['valor'] -= $troco;

            
            $this->obj->populationClass($arrayDados);           
            $this->obj->tipo = 'C';    
            $this->obj->caixa_id = $caixa_id;
            $response = $this->obj->save();
            
            if($response){
                $VendaPagto = new VendaPagto();
                // Gravar formas de pagamento
                switch( $arrayDados['forma_pagto_id'] ){
                    case 5: // Fracionado

                        foreach ($arrayDados['fracionado'] as $key => $value) {
                            if( $value ){
                                $VendaPagto->id = NULL;
                                $VendaPagto->fisica_conta_id = $this->obj->id;
                                $VendaPagto->forma_pagto_id = $key;
                                $VendaPagto->valor = $value;
                                $VendaPagto->venda_id = 'null';
                                $VendaPagto->save();  
                            }                                
                        }                            

                        break;

                    default : 

                        $VendaPagto->venda_id = 'null';
                        $VendaPagto->forma_pagto_id = $arrayDados['forma_pagto_id'];
                        $VendaPagto->valor = $arrayDados['valor'];
                        $VendaPagto->fisica_conta_id = $this->obj->id;
                        $VendaPagto->save();

                        break;
                }


                $this->data = $this->obj->selectById($response->id);
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }

        }    
            
     }       
 ?>