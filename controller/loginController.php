<?php
    class loginController{
        
        public $msg = '';
        public $obj = '';
        public $data = '';
        
        public function __construct(){
            $this->obj = new Funcionario();
            
            if(@!isset($_SESSION['LOGIN'])){
                $_SESSION['LOGIN'] = false;    
            }
                    
        }
        
        public function login($user, $pass){

            $user = preg_replace('/[^0-9a-z_]/i', '',$user);
            $pass =  md5(trim($pass));
                       
            $usuario = $this->obj->select("where login = '{$user}' and senha = '{$pass}'");
            
            if(@$usuario[0]->id){

                $_SESSION['LOGIN'] = true;
                $_SESSION['USER'] = $usuario[0]->id;
                $_SESSION['TYPE'] = $usuario[0]->tipo_us;
                
                $this->data = array( 'id'       => $usuario[0]->id,
                                     'login'    => $usuario[0]->login );

                $this->msg = 'Login efetuado com sucesso! Redirencionando...';
                return true;
            }else{
                $this->msg = 'login ou senha inválidos';
                return false;
            }   
        }

        public function alterPassword($pass, $confirm, $token=NULL){

            if( !$pass ){

                $this->msg = 'Senha está vázia';
                return false;

            }

            if( $pass != $confirm ){
                $this->msg = 'Senhas não conferem';
                return false;
            }

            if( !$this->tokenValidation($token) && !$_SESSION['LOGIN'] ){
                $this->data = 'token';
                $this->obj->id = 1; 
                return false;
            } else {
                $this->obj->id = $_SESSION['USER']; 
            }            
                       
            $this->obj->senha = md5( $pass );
            $response = $this->obj->save();
            
            if($response){
                $this->data = $response;
                $this->msg = "Senha alterada com sucesso!";
                return true;
            }else{
                $this->msg = "Erro ao alterar senha";
                return false;
            }

            return true;

        }

        public function tokenValidation( $token ){
            if( ($this->createToken( CONF['client_id'] ) == $token) ){
                return true;
            } else {
                $this->msg = "Token Inválido!";
                return false;
            }
        }

        function createToken( $customer ){

            $number = date('ydmH');

            preg_match_all( '/[0-9]{2}/' , $number, $matches);

            $variador = floor(( $matches[0][3] * 2 ) / $customer);
            $password = '';
            foreach ( $matches[0] as $key => $value) {
                $password .= substr( md5($value), $variador , 1 );
            }

            $password .= substr( md5($customer), $variador ,2);

            return mb_strtoupper( $password );

        }

            
        public function logoff(){
            session_destroy();   
            return true;
        }
        
        public function validadeSession(){
            if($_SESSION['LOGIN'])
                return true;
            
            return false;
        }

    }
?>       