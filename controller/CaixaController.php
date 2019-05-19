<?php
    
     class CaixaController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            $this->obj = new Caixa();
        }    
        
        public function selectAll($offset = "",$rows = ""){

            $response = $this->obj->selectAll($offset,$rows);       
        
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
            
            $arrayDados = json_decode($request, true);            
            foreach($arrayDados as $key => $value){
                $arrayDados[$key] = $value == "" ? "null" : $value;
            }

            if( !$arrayDados['dt_abertura']){
                $arrayDados['dt_abertura'] = "null";
            }

            if( array_key_exists('valor_fechamento', $arrayDados) ){

                if( !$arrayDados['valor_fechamento']){
                    $arrayDados['valor_fechamento'] = NULL;
                } else {
                    $this->check_caixa_aberto();
                    $this->obj->id = $this->data->id;
                    $arrayDados['dt_fechamento'] = date('d/m/Y H:i:s');  
                }
            } else {

                if( $this->check_caixa_aberto() ){
                    $this->msg = "Já existe um caixa aberto!";
                    return false;
                }

                $arrayDados['valor_fechamento'] = NULL;  
            }                      
            
            //$GLOBALS['break'] = true;

            $this->obj->populationClass($arrayDados);
            $this->obj->funcionario_id = $_SESSION['USER'];
            $response = $this->obj->save();
            
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }

        }
        
        
        public function delete($id){
       
            $this->obj->selectById($id);   
            $return = $this->obj->delete();
            
            if($return){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }  

        public function check_caixa_aberto(){

            $response = $this->obj->select(" WHERE funcionario_id = '".$_SESSION['USER']."' AND 
                                                   dt_fechamento IS NULL 
                                                   LIMIT 1 ");

            if($response){
                
                $this->data = $response[0];
                $this->msg = "Sucesso";
                return true;

            }else{
                
                $this->msg = "Sem Resultados";
                return false;

            }

        }

        public function valorEmCaixa(){
            
            $ret = $this->check_caixa_aberto();

            $this->obj->id = $this->data->id;
            $vlr_inicial = $this->data->valor_inicial;

            $response = $this->obj->valorEmCaixa();

            if($response){
                
                $this->data->soma = $response; 
                $this->data->init = $vlr_inicial; 

                $this->msg = "Sucesso";
                return true;

            }else{
                
                $this->msg = "Sem Resultados";
                return false;

            }

        }


            
            
     }       
 ?>