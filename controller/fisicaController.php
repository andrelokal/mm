<?php
     class FisicaController{
        
        private $obj;
        public $data;
        public $msg;
        public $filter = array();
        protected $validation;
        public $search;
        
        public function __construct(){
            $this->validation = new Validation(PATH_ROOT.'util/validators.php');
            $this->obj = new Fisica();
        }    
        
        public function selectAll($offset = "",$rows = "",$active=""){
            
            //$GLOBALS['break'] = 1;

            $where = [];

            if( $this->filter ){
                $where = [];
                foreach ($this->filter as $key => $value) {
                    $where[] = $key." = '".$value."' ";
                }
                
            }

            if( $active ){
                $where[] = " tem_conta='".$active."' ";
            }

            if( $this->search ){
                $where[] = " (  A.cpf LIKE '%".$this->search."%' OR 
                                A.nome LIKE '%".$this->search."%' OR 
                                B1.email LIKE '%".$this->search."%' ) ";
            }

            if( count( $where ) ) $where = implode(" AND ", $where );

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
        
        public function selectByCPF($cpf){
            
            $response = $this->obj->select(" WHERE  cpf = '".$cpf."' AND
                                                    tem_conta = 'y' LIMIT 1 ");
            
            if($response){

                $this->data = $response[0];

                $this->dadosConta();

                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Não existe ou não tem estoque!";
                return false;
            }
        
        }
        
        public function selectById($id){
            
            //$GLOBALS['break'] = '1';

            $response = $this->obj->selectById($id);
            
            if($response){

                $this->data = $response;
                
                if( $this->data->tem_conta == 'y' ) $this->dadosConta();

                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }

        private function dadosConta(){

            $FisicaConta = new FisicaConta();
            $FisicaConta->fisica_id = $this->data->id;
            $res = $FisicaConta->saldo();

            $this->data->saldo = $res->total;
            $this->data->creditos = $res->creditos;
            $this->data->debitos = $res->debitos;
            $this->data->limite_conta = $this->data->saldo + $this->data->limite_conta;

        }


        public function save($request){
            
            $arrayDados = json_decode($request, true);     

            // Valida Request
            if  ( !$this->validation->ValidateRequest( array( 'cpf'         => 'required|cpf',
                                                              'email'       => 'required|email',
                                                              'telefone'    => 'required',
                                                              'nome'        => 'required'), $arrayDados ) ){
                $this->msg = $this->validation->error_request;
                return false;
            }

            if( @!$arrayDados['dia_mes_pagto']){
                unset( $arrayDados['dia_mes_pagto'] );
            }

            $cpf = $arrayDados['cpf'];
            $id = @$arrayDados['id']; 

            if( @!$arrayDados['id']){
                unset( $arrayDados['id'] );
            }

            foreach($arrayDados as $key => $value){
                    $arrayDados[$key] = $value == "" ? "null" : $value;
            }
                
            /*Confere de CNPJ já existe*/
            $res = $this->obj->select(" WHERE   cpf = '".$cpf."' AND 
                                                id != '".$id."' 
                                        LIMIT 1 ");

            if( $res ){

                $this->msg = "Já existe um registro com esse CPF";
                $this->data['status'] = $res[0]->pessoa->status;

                return false;

            }


            if( @$arrayDados['id'] ){
                $this->obj->selectById($arrayDados['id']);
            }

            $this->obj->populationClass($arrayDados);
            if( array_key_exists('pessoa_id', $arrayDados) ) $this->obj->pessoa_id = $arrayDados['pessoa_id'];

            //if( array_key_exists('pessoa_id', $arrayDados) ){
                /*Grava Pessoa*/            
                $pessoa = new Pessoa();
                $pessoa->populationClass($arrayDados);
                $pessoa->id = $this->obj->pessoa_id;
                $pessoa->dt_atualizacao = NULL;
                $pessoa->dt_cadastro = NULL;    
                $pessoa->status = 'AT';

                $pessoa->save();

                $this->obj->pessoa_id = $pessoa->id;
            //}            
            
            //$this->obj->id = $arrayDados['id'];
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
        
        
        public function delete($request){
       
            $arrayDados = json_decode($request, true);
                
            $fisica->populationClass($arrayDados);
            $return = $fisica->delete();
            
            if($return){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }    
            
            
     }       
 ?>