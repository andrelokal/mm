<?php
     class FuncionarioController{
        
        private $obj;
        public $data;
        public $msg;
        public $filter = array();
        protected $validation;
        public $search;

        public function __construct(){
            $this->validation = new Validation(PATH_ROOT.'util/validators.php');
            $this->obj = new Funcionario();
        }    
        
        public function selectAll($offset = "",$rows = "",$active=""){
            //$GLOBALS['break'] = 1;
            $where = [];

            if( $this->filter ){
                foreach ($this->filter as $key => $value) {
                    $where[] = " ".$key." = '".$value."' ";
                }                
            }

            $where[] = " A.id != 1 ";

            if( $this->search ){
                $where[] = " (  A.nome LIKE '%".$this->search."%' OR
                                A.login LIKE '%".$this->search."%' OR
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

            // Valida Request
            if  ( !$this->validation->ValidateRequest( array( 'tipo_us'     => 'required',
                                                              'nome'        => 'required',
                                                              'login'       => 'required',
                                                              /*'senha'       => 'required',*/
                                                              'email'       => 'required|email'), $arrayDados ) ){
                $this->msg = $this->validation->error_request;
                return false;
            }

            $id = @$arrayDados['id']; 
            $new = false;

            if( @!$arrayDados['id']){
                $new = true;
                unset($arrayDados['id']);
            }

            foreach($arrayDados as $key => $value){
                    $arrayDados[$key] = $value == "" ? "null" : $value;
            }
                
            /*Confere de CNPJ jс existe*/
            $res = $this->obj->doExecuteSelect(" SELECT 1 FROM pessoa
                                                 WHERE  email = '".$arrayDados['email']."' AND 
                                                        id != '".$arrayDados['pessoa_id']."' 
                                                 LIMIT 1 ");

            if( $res ){

                $this->msg = "Jс existe um registro com esse E-mail";

                return false;
            }

            $resLogin = $this->obj->select(" WHERE   login = '".$arrayDados['login']."' AND 
                                                id != '".$id."' 
                                        LIMIT 1 ");

            if( $resLogin ){

                $this->msg = "Jс existe um registro com esse Login";
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

                //Grava permissуo bсsica de Funcionсrio
                // se for novo 
                if( $new ){
                    //$GLOBALS['break'] = 1;
                    $acesso = new Acesso();
                    $acesso->GravaAcessoBasicoFuncionario( $response->id );
                }

                $this->data = $this->obj->selectById($response->id);
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }

        }
        
        
        public function delete($request){
       
            $arrayDados = json_decode($request, true);
                
            $funcionario->populationClass($arrayDados);
            $return = $funcionario->delete();
            
            if($return){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }  

        function changePassword( $id, $senha ){

            if( $id == '1' ){
                $this->msg = "Aчуo nуo permitida!";
                return false;
            }

            $this->obj->id = $id;
            $this->obj->senha = md5( $senha );

            $response = $this->obj->save();
            
            if($response){
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Erro ao alterar senha";
                return false;
            }

        }  
            
            
     }       
 ?>