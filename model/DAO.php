<?php

class Database extends MySQLi {
    private static $instance = null ;

    public function __construct($host, $user, $password, $database){ 
        parent::__construct($host, $user, $password, $database);
    }

    public static function getInstance(){
        if (self::$instance == null){

            $conf = parse_ini_file(PATH_ROOT."util/config.ini");
        
            $host = $conf['host'];
            $user = $conf['user'];
            $password = $conf['pass'];
            $database   = $conf['db'];

            self::$instance = new self($host, $user, $password, $database);
        }
        return self::$instance ;
    }    

}

abstract class DAO {

    public    $conn;
    private   $host;
    private   $user;
    private   $pass;
    private   $db;
    private   $error         = "";
    private   $arrAttributes = array();
    public    $arrProperties = array();
    
    //Cria a conexao com o banco de dados
    protected function doConnect(){

        if(!isset( $this->conn )){
            try {

                $this->conn = Database::getInstance();
                //$this->conn = new conn($this->host, $this->user, $this->pass, $this->db);

                /*
                $mysql = new PDO("mysql:host=".$this->host, $this->user, $this->pass);
                
                $pstatement = $mysql->prepare("CREATE DATABASE IF NOT EXISTS ".$this->db);
                $pstatement->execute();
                unset( $mysql );

                $this->conn = new PDO("mysql:host=".$this->host.";dbname=".$this->db, $this->user, $this->pass);
                $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                 */
            } catch ( Exception $e ) {
                $this->error = $e->getMessage();
                return false;
            }
        }    
    }
    
    //Recupera erros de execucao dos metodos
    public function getError(){
        return $this->error;
    }
    
    //Recupera Attributes do objeto
    private function getAttributesClass($obj){
        $reflect = new ReflectionObject($obj);
        foreach ($reflect->getProperties(ReflectionProperty::IS_PUBLIC + ReflectionProperty::IS_PROTECTED + ReflectionProperty::IS_PRIVATE) as $prop) {
            array_push($this->arrAttributes, $prop->getName());
        }        
    }
    
    //Converter Data do Banco MySQL para formato PTbr Data
    public function dataConvert($propertyField, $obField){
        if(strtoupper($propertyField) == "TIMESTAMP" || strtoupper($propertyField) == "DATE" || strtoupper($propertyField) == "DATETIME"){
            $date = date_create($obField);
            return date_format($date, 'd/m/Y');
        }else{
            return utf8_encode( $obField );
        }
    }

    //Recupera Propriedades da Tabela
    protected function getProperties($obj){
        $this->doConnect();
        $st = $this->conn->query("show columns from ".$obj->table);
        $this->arrProperties = $st->fetch_all(MYSQLI_ASSOC);
    }
    
    //Recupera dados do banco e retorna um array de objetos ou um unico objeto pupulado
    protected function doFind($obj, $where = "",$self = ""){
        $this->doConnect();
        $this->getAttributesClass($obj);
        $this->getProperties($obj);
        $id = $obj->idName;
        $arrayObj = array();

        if($obj->$id <= 0 || $where != ""){
            $sql = "SELECT SQL_CALC_FOUND_ROWS * FROM ".$obj->table." ".$where;

            if( @$GLOBALS['break'] ){
                echo  $sql."\n";
                exit;    
            }

            $st = $this->conn->query($sql);
            $result = $st->fetch_all(MYSQLI_ASSOC);
            foreach($result as $key => $column){
                $className = get_class($obj);
                $newObj = new StdClass;
                foreach($this->arrProperties as $property ){
                    $field = $property["Field"];                    
                    $newObj->$field = $column[$field];
                    
                    //Funcao verifica se o campo e data, se for converte no formato correto
                    $newObj->$field = $this->dataConvert($property["Type"], $newObj->$field);    
                }                
                array_push($arrayObj,$newObj);    
            }
            return $arrayObj;
        }else{
            $sql = "SELECT * FROM ".$obj->table." WHERE ".$id." = ".$obj->$id;

            if( @$GLOBALS['break'] ){
                echo  $sql."\n";
                exit;    
            }
            $st = $this->conn->query($sql);
            $result = $st->fetch_all(MYSQLI_ASSOC);
            $newObj = new StdClass;
            //$newObj = $obj;
            foreach($result as $key => $column){
                foreach($this->arrProperties as $property ){
                    $field = $property["Field"];
                    $newObj->$field = $column[$field];
                    $obj->$field = $column[$field]; //aplica alteracoes no objeto passado
                    
                    //Funcao verifica se o campo data, se for converte no formato correto
                    $newObj->$field = $this->dataConvert($property["Type"], $newObj->$field);
                    //$obj->$field = $this->dataConvert($property["Type"], $newObj->$field); //aplica alteracoes no objeto passado
                }                                
            }
            return $newObj;
            
        }
    }
        
    //Metodo para salvar e atualizar objetos no banco de dados
    protected function doSave($obj){
        $this->doConnect();
        $this->getAttributesClass($obj);
        $this->getProperties($obj);
        $id = $obj->idName;
        $cont = 0;
        $fieldNames = "";
        $fieldValues = "";
        $setFields = "";

        $action = 'insert';
        if( $obj->$id && $obj->$id != 'null' ){
            $action = 'update';            
        }            

        foreach($this->arrProperties as $property ){
            $field = $property["Field"];
            $fld = $obj->$field;

            if( /*$action == 'update' &&*/ !$fld ) continue;

            if($obj->idName == $field) continue;
            //formata o campo para data
            if(strtoupper($property["Type"]) == "TIMESTAMP" || strtoupper($property["Type"]) == "DATE" || strtoupper($property["Type"]) == "DATETIME"){
                if( !empty( $fld ) ){
                    $fld = strtoupper($fld) != 'NULL' ? "STR_TO_DATE('".$fld."', '%d/%m/%Y %H:%i:%s')" : 'NULL'; 
                }
            }else{
                $fld = preg_replace( "/\'(.*)\'/", "$1", $fld );
                $fld = strtoupper($fld) != 'NULL' ? "'".$fld."'" : "NULL";    
            }

            $setFields[] = $field." = ".$fld;
        }

        $query = "INSERT INTO ";
        $where = "";

        if( $action == 'update' ){
            $query = "UPDATE ";
            $where = " WHERE ".$id." = ".$obj->$id;
        }

        $query .= $obj->table." SET ".implode( ',', $setFields ).$where;
        
        if( @$GLOBALS['break'] ){
            echo  $query."\n";
            exit;    
        }        

        try{
            
            $st = $this->conn->query($query);
                       
            //verifica se a atualizacao de um Insert ou Update para retornar o ID correto
            $obj->$id = $obj->$id <= 0 ? mysqli_insert_id($this->conn) : $obj->$id;
            
            $this->setLog($query);        

            return true;
                                    
        }catch (Exception $e) {
            $this->error = $e->getMessage();
            return false;
        }
    }
    
    // Metodo para deletar objetos no banco de dados
    protected function doDelete($obj){
        $id = $obj->idName;    
        if($obj->$id > 0){
            $this->doConnect();
            $query = "DELETE FROM ".$obj->table." WHERE ".$id." = ".$obj->$id;        
            try{                
                $st = $this->conn->query($query);
                return true;            
            }catch (Exception $e) {
                $this->error = $e->getMessage();
                return false;
            }        
        }else{
            $this->error = "Objeto Selecionado nao possui ID";
            return false;    
        }
    }
    
    //Método de Preenchimento da classe
    protected function doPopulationClass($obj,$array){
        $this->getAttributesClass($obj);
        foreach($this->arrAttributes as $field){
            if( array_key_exists($field, $array) ){
                $obj->$field = $array[$field];
            }
        }    
  
    }
    
    //Query com Retorno
    protected function doExecuteSelect($SQL){

        if( @$GLOBALS['break'] ){
            echo  $SQL."\n";
            exit;    
        }
        $this->doConnect();
        
        $arrayObj = array();
        
        try{
            $st = $this->conn->query($SQL);
            //$st->execute();
            $result = $st->fetch_all(MYSQLI_ASSOC);
            $count = count($result);
            
            $newObj = "";
            
            foreach($result as $row){
                $newObj = new StdClass;
                foreach($row as $key => $property ){
                    $newObj->$key = utf8_encode( $property );
                }
                array_push($arrayObj,$newObj);
            }
            
           return $arrayObj;
            
        }catch (Execption $e) {
            $this->error = $e->getMessage();
            return false;
        }
        
    }
    
    
    //Query sem retorno somente retorna true ou false
    public function doExecuteSQL($SQL){
        $this->doConnect();
        $st = $this->conn->query($SQL);
        if ($st){
            $this->setLog($SQL);
            return true;
        }else{
            return false;    
        }
    }
    
    //Retorna a Quantidade de registros da ultima query executada, sem limit ou offset
    public function getTotalRows(){
        $query = "SELECT FOUND_ROWS() as TOTAL";
        return $this->doExecuteSelect($query);
    }
    
    //Retornar todas tabelas do banco
    public function getTables(){
        return $this->doExecuteSelect('SHOW TABLES');
    }
    
    //Retornar relacionamento entre tabelas
    public function getConstraint($table){
        $query = "SELECT DISTINCT COLUMN_NAME AS COLUNA, 
                         REFERENCED_COLUMN_NAME AS REFCOLUNA, 
                         REFERENCED_TABLE_NAME AS REFTABELA 
                    FROM information_schema.KEY_COLUMN_USAGE
                   WHERE TABLE_NAME = '{$table}' 
                     AND REFERENCED_TABLE_NAME IS NOT NULL";
        
        return $this->doExecuteSelect($query);
    }

    
    public function Transaction( $t ){

        //$this->doConnect();        
        //$this->conn->autocommit(FALSE);
        $db = Database::getInstance();
        
        switch ( $t ) {
            case 'begin':
                $db->begin_transaction(); 
                break;

            case 'commit':
                $db->commit(); 
                break;
            
            case 'rollback':
                $db->rollback();
                break;
        }
        
    }
    
    
    public function setLog($query){
        $this->doConnect();
        $ip = $_SERVER['REMOTE_ADDR'];
        $user = @$_SESSION['USER'];
        $log = addslashes($query);
        $this->conn->query(sprintf("INSERT INTO log (user, log, ip) VALUES (%d, '%s', '%s')",$user,$log,$ip));       
    }
    
    
}
