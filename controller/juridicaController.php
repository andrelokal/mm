<?php
     class JuridicaController{
        
        private $obj;
        public $data;
        public $msg;
        public $search;
        
        public function __construct(){
            $this->obj = new Juridica();
        }    
        
        public function selectAll($offset = "",$rows = ""){
            
            $where = "";
            if( $this->search ){
                $where .= " (   A.cnpj LIKE '%".$this->search."%' OR 
                                A.razao_social LIKE '%".$this->search."%' OR 
                                A.nome_fantasia LIKE '%".$this->search."%' OR 
                                B1.email LIKE '%".$this->search."%' ) ";
            }

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

            /*Confere de CNPJ já existe*/
            $res = $this->obj->select(" WHERE   cnpj = '".$arrayDados['cnpj']."' AND
                                                juridica.id != '".$arrayDados['id']."' 
                                        LIMIT 1 ");

            if( $res ){

                if( array_key_exists('confirm', $arrayDados) &&
                    $arrayDados['confirm'] == '1' ){

                    /*
                    print_r( $res );
                    exit;
                    */

                    $arrayDados['id'] = $res[0]->id;
                    $arrayDados['status'] = 'AT';

                } else {
                    $this->msg = "Já existe um registro com esse CNPJ.";    
                    $this->data['status'] = $res[0]->pessoa->status;

                    return false;    
                }                

            }

            /*Grava Pessoa*/            
            $pessoa = new Pessoa();
            $pessoa->populationClass($arrayDados);
            $pessoa->id = $arrayDados['pessoa_id'];
            $pessoa->dt_atualizacao = NULL;
            $pessoa->dt_cadastro = NULL;    
            $pessoa->status = 'AT';
           
            $pessoa->save();

            $this->obj->populationClass($arrayDados);
            $this->obj->pessoa_id = $pessoa->id;
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

            $pessoa = new Pessoa();
            $pessoa->id = $this->obj->pessoa_id;
            $pessoa->status = 'IN';           
            $return = $pessoa->save();

            //$return = $this->obj->delete();
            
            if($return){
                //$this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }    
            
            
     }       
 ?>