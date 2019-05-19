<?php
/**
* Validation
* VALIDAÇÕES DE DADOS
* @author      André Martos
* @version     1.0
* @date        27/12/2016
*/
class Validation{
    
    public $pathValidator = "";
    public $msg = "";
    public $error_request = "";

    /**
    * caminho do arquivo validador
    * @param mixed $pathValidator caminho do arquivo validador
    */
    public function __construct($pathValidator){
        
        $this->pathValidator = $pathValidator;
        
    }  

    /**
    * O arquivo validador sempre deve retornar um array com o success (true/false) e o msg(com a mensagem de erro)
    * Se não encontrar o arquivo retorna false
    * Se não encontrar a função retorna true
    * @param mixed $dados (dados para validação)
    * @param mixed $funcao (nome da função que irá validar)
    * @return true/false
    */
    public function validarDados($dados,$funcao){

        if(file_exists($this->pathValidator)){

            include_once($this->pathValidator);
            
            if(function_exists($funcao)){
                $result = $funcao($dados);
                if(is_array($result)){
                    $this->msg = $result["msg"]; 
                    return $result["success"];
                }else{
                    $this->msg = "tipo de retorno do validador inesperado";
                    return false;
                }     
            }else{
                return true;    
            }

        }else{
            $this->msg = "nao encontrei o arquivo validador";
            return false;
        
        }
            
    }

    public function ValidateRequest( $request = NULL, $data, $parent = NULL ){

        $success = true;
        $errors = array();
        $or_succes = false;
        $danger = false;

        foreach ($request as $key => $value) {
            
            $success = true;
            
            if( is_array( $value ) ){
                $ret = $this->ValidateRequest( $value, $data[$key], $key );
                if( !$ret->success ){
                    $success = $ret->success;
                    $this->error_request = array(  'success'   => $success,
                                                   'errors'    => array($key => $ret->errors)
                                                   );    
                    return false;
                } else {
                    continue;
                }
            }

            preg_match_all('/(required)|(number|string|array|date|email|cpf)|(or)|((max)\:([0-9]+))/', $value, $slipt);
            $rules = $slipt[0];

            $required = false;
            if( in_array( 'required' , $rules) ){
                $required = true;
            }

            if( $required ){
                if( !array_key_exists( $key , $data ) ){
                    $errors[$key] = utf8_encode( "Campo obrigatório" );
                    $success = false;
                    if( !in_array( 'or' , $rules) )  break;
                }
            }

            if( in_array( 'number' , $rules) ){
                if( array_key_exists( $key , $data ) &&
                    !is_numeric( $data[$key] ) ){
                    $errors[$key] = "Campo numérico";
                    $danger = true;
                    $success = false;
                    if( !in_array( 'or' , $rules))  break;
                } else {

                    $values_ = implode('|',$rules);
                    if( preg_match( '/((max)\:([0-9]+))/' , $values_, $matches) ){
                        $max = $matches[3];
                        if( $data[$key] > $max ){
                            $errors[$key] = "Valor máximo : " . $max ;
                            $success = false;
                            $danger = true;
                            if( !in_array( 'or' , $rules))  break;
                        }  else {
                            $success = true;
                        }
                    }
                    
                }


            }

            if( in_array( 'date' , $rules) ){
                if( array_key_exists( $key , $data ) &&
                    !preg_match('/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/', $data[$key]) ){
                    $errors[$key] = "Data inválida: DD/MM/YYYY" ;
                    $danger = true;
                    $success = false;
                    if( !in_array( 'or' , $rules))  break;
                } 
            }

            if( in_array( 'array' , $rules) ){
                if( array_key_exists( $key , $data ) &&
                    !is_array( $data[$key] ) ){
                    $errors[$key] =  "Campo deve ser um array";
                    $success = false;
                    $danger = true;
                    if( !in_array( 'or' , $rules))  break;
                } 
            }

            if( in_array( 'email' , $rules) ){
                if( array_key_exists( $key , $data ) &&
                    !$this->validarDados($data[$key],$key ) ){
                    $errors[$key] = $this->msg;
                    $success = false;
                    $danger = true;
                    if( !in_array( 'or' , $rules))  break;
                } 
            }

            if( in_array( 'cpf' , $rules) ){
                if( array_key_exists( $key , $data ) &&
                    !$this->validarDados($data[$key],$key ) ){

                    $errors[$key] = $this->msg;
                    $success = false;
                    $danger = true;    
                } 
            }

            if( in_array( 'or' , $rules) ){
                $or[] = $key;
                if( $success ) $or_succes = true;   
            } 

        }

        if( !empty($or) ){
            if( $or_succes && !$danger){
            
                $success = true;
                
            } else {

                $success = false;
                $errors[ implode(',',$or) ] = "Preecha um dos campos obrigatórios";

            }
        }

        if( $parent ){
            return (object) array( 'success' => $success, 'errors' => $errors );
        } else {
            $this->error_request = $errors;    
        }
        
        return $success;
        //return false;

    }
    
    
    
    
    
}
?>
