<?php
     class VendaController{
        
        private $obj;
        public $data;
        public $msg;
        public $filter = array();
        
        public function __construct(){
            $this->obj = new Venda();
        }    
        
        public function selectAll($offset = "",$rows = ""){
            
            $normalize = new Normalize();

            $where = [];

            if( $this->filter ){
                $where = [];
                foreach ($this->filter as $key => $value) {

                    // confere se é data
                    if( preg_match( '/[0-9]{2}\/[0-9]{2}\/[0-9]{4}.*/', $value ) ){
                        $where[] = $key." >= '".  $normalize->date_mysql($value) ."' ";
                    } else if( strpos(' '.$value,'%') ){
                        $where[] = $key." LIKE '".$value."' ";    
                    } else {
                        $where[] = $key." = '".$value."' ";    
                    }                    
                }                
            }

            $where[] = " status != 'C' ";

            /*if( $this->search ){
                $where[] = " (  A.cpf LIKE '%".$this->search."%' OR 
                                A.nome LIKE '%".$this->search."%' OR 
                                B1.email LIKE '%".$this->search."%' ) ";
            }*/

            if( count( $where ) ) $where = implode(" AND ", $where );

            //$GLOBALS['break'] = 1;
            $response = $this->obj->selectAll($offset,$rows,$where);
        
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            } 
            
        }
        
        
        public function selectById($id){
        
            $response = $this->obj->selectById($id);
            
            $response->pessoa = $obj->pessoa->id;
       
        
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
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
            // pega request
            $arrayDados = json_decode($request, true);
            // normaliza request
            foreach($arrayDados as $key => $value){
                    $arrayDados[$key] = $value == "" ? "null" : $value;
            }
            
            // popula objeto
            $this->obj->populationClass($arrayDados);
            // seta propriedades
            $this->obj->total = 0;
            $this->obj->caixa_id = $caixa_id;
            $this->obj->data = date('d/m/Y H:i:s');
            // Instacia classes
            $Produto = new Produto();
            $objItem = new Itens_venda();
            $VendaPagto = new VendaPagto();

            $this->obj->Transaction('begin');            
            // Grava a venda
            $objVenda = $this->obj->save();            
            
            $idItem = array();
            // Se conseguiu gravar a venda
            if($objVenda->id){
                
                $return = true;
                $this->data = $objVenda->id;
                
                $total_venda = 0;

                // Varre itens para adicionar
                foreach($arrayDados['itens'] as $item){                    
                    
                    $item['venda_id'] = $objVenda->id;
                    // normaliza dados
                    foreach($item as $key => $value){
                        $item[$key] = $value == "" ? "null" : $value;  
                    }
                    // Seleciona o produto
                    $Produto->selectById($item['produto_id']);
                    // pega unidade de cobrança
                    $unidade_id = $Produto->unidade_id;
                    if( $unidade_id  == 2 ){
                        $valor = $item['valor_item'];
                    } else {
                        $valor = $Produto->valor * $item['quantidade'];
                    }

                    $total_venda += $valor;                        

                    $item['valor_unitario'] = $valor;
                    
                    $objItem->id = null;
                    $objItem->populationClass($item);
                    
                    if(!$objItem->save()){
                        $this->obj->Transaction('rollback');
                        $this->msg = 'Erro ao salvar item de venda';
                        return false;
                    } else{
                        $Produto->estoque -= $item['quantidade'];
                        
                        if(!$Produto->save()){
                            $this->obj->Transaction('rollback');
                            $this->msg = "erro ao salvar item de venda";
                            return false;     
                        } 
                    }                    
                }                   

                //$this->obj->Transaction('commit');
                //return true;

                $this->obj->data = '';
                $this->obj->cliente_id = NULL;
                $this->obj->total = $total_venda - $this->Discount( $total_venda, $arrayDados['desconto'] );

                // Confere troco fracioado
                if( array_key_exists('fracionado', $arrayDados) ){
                    $total_fracionado = array_sum( $arrayDados['fracionado'] );     
                    if( $total_fracionado > $this->obj->total ){
                        $troco = $total_fracionado - $this->obj->total;
                        if( $troco > $arrayDados['fracionado'][1]){
                            $this->msg = "Troco Fracionado não pode ser maior que a quantia em dinheiro";
                            return false;  
                        } else {
                            //Acerta troco fracionado
                            $arrayDados['fracionado'][1] -= $troco;
                        }
                    }
                } 

                if( $this->obj->save() ){

                    // Gravar Formas Pagamento
                    switch( $arrayDados['forma'] ){
                        case 5: // Fracionado

                            foreach ($arrayDados['fracionado'] as $key => $value) {
                                if( $value ){
                                    $VendaPagto->id = NULL;
                                    $VendaPagto->venda_id = $objVenda->id;
                                    $VendaPagto->forma_pagto_id = $key;
                                    $VendaPagto->valor = $value;
                                    $VendaPagto->fisica_conta_id = 'null';
                                    $VendaPagto->save();  

                                    if( $key == 4 ){
                                        $this->AddDebitoContaCliente( $arrayDados['fisica_id'], $value, $caixa_id, $objVenda->id );
                                    }
                                }                                
                            }                            

                            break;

                        case 4: // Jogar conta corrente cliente
                            //$GLOBALS['break'] = 1;
                            $this->AddDebitoContaCliente( $arrayDados['fisica_id'], $this->obj->total, $caixa_id, $objVenda->id );
                            // Sem break para cadastrar forma TB

                        default : 
                            //$GLOBALS['break'] = 1;
                            $VendaPagto->venda_id = $objVenda->id;
                            $VendaPagto->forma_pagto_id = $arrayDados['forma'];
                            $VendaPagto->valor = $this->obj->total;
                            $VendaPagto->fisica_conta_id = 'null';
                            $VendaPagto->save();

                            break;
                    }

                    // TRANSITION AQUI !!!!!!!!!!!!!!!!!!!!!!!!!!

                    $this->obj->Transaction('commit');
                    //$this->obj->Transaction('rollback');
                    return true; 
                }

            }else{
                $this->obj->Transaction('rollback');
                $this->msg = "erro ao salvar venda";
                return false;    
            }

        }

        private function AddDebitoContaCliente( $fisica_id, $vlr, $caixa_id, $venda_id ){
            //$GLOBALS['break'] = 1;
            $FisicaConta = new FisicaConta();

            $FisicaConta->fisica_id = $fisica_id;
            $FisicaConta->tipo = 'D';
            $FisicaConta->valor = $vlr;
            $FisicaConta->dt_cadastro = NULL;
            $FisicaConta->desconto = 0;
            $FisicaConta->caixa_id = $caixa_id;
            $FisicaConta->venda_id = $venda_id;

            $FisicaConta->save();

        }

        private function Discount( $vlr, $discount ){
            return ( $vlr * $discount ) / 100;
        }
        
        
        public function delete($request){
       
            $arrayDados = json_decode($request, true);
                
            $venda->populationClass($arrayDados);
            $return = $venda->delete();
            
            if($return){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }    

        public function cancel( $id, $pass ){
            //$GLOBALS['break'] = 1;
            // Validar Senha
            $Funcionario = new Funcionario();
            if( !$Funcionario->isAdm( $pass ) ){
                $this->msg = 'Senha inválida';
                return false;
            } 

            // Passou senha!!

            // Cancela Venda
            $this->obj->id = null;
            $this->obj->selectById($id);
            $this->obj->status = 'C';
            $return =$this->obj->save();
            if($return){
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        } 
            
            
     }       
 ?>