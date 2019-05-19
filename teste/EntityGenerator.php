<?php
class EntityGenerator extends DAO{
	
	public $path;
	
	public function __construct($path){
		$this->path = $path;
	}
	
	public function generateByTable($table){
		$newObj = new StdClass;
		$newObj->table = $table;
		parent::getProperties($newObj);

		$resultConstraint = $this->getConstraint($table);
		
		file_put_contents($this->path.'/'.ucfirst($table).".php","<?php \n class ".ucfirst($table)." extends DAO{ \n \n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'private $table = "'.$table.'";'."\n", FILE_APPEND);
		
		
		foreach($this->arrProperties as $atributo){
			if($atributo['Key'] == 'PRI'){
				file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'private $idName = "'.$atributo['Field'].'"; '."\n", FILE_APPEND);
				file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'private $id;'."\n", FILE_APPEND);
				
			}else{
				file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'private $'.$atributo['Field'].'; '."\n", FILE_APPEND);
			}
		}
		
		if($resultConstraint){
			if(is_array($resultConstraint)){
				foreach($resultConstraint as $value){
					file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'private $'.$value->REFTABELA.'; '."\n", FILE_APPEND);
				} 
			}else{
				file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'private $'.$resultConstraint->REFTABELA.'; '."\n", FILE_APPEND);
			}
		}

		file_put_contents($this->path.'/'.ucfirst($table).".php","\n \t".'public function __construct($id = ""){'."\n \n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'if($id)'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'return $this->selectById($id);'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'}'."\n \n", FILE_APPEND);
		
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'#setters, getters, isset, unset magicos'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function __set($pname, $pvalue) { $this->$pname = $pvalue; }'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function __get($pname) { return $this->$pname; }'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function __isset($pname) { return isset($this->$pname); }'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function __unset($pname) { unset($this->$pname); }'."\n \n \n", FILE_APPEND);
		
		//selectAll
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function selectAll($offset,$rows){'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'$this->id = "";'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'$collectionThis = parent::doFind($this, "limit ".$offset.",".$rows."");'."\n", FILE_APPEND);
		if($resultConstraint){
			file_put_contents($this->path.'/'.ucfirst($table).".php","\n", FILE_APPEND);
			if(is_array($resultConstraint)){
				foreach($resultConstraint as $value){
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'foreach ($collectionThis as $obj){'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj'.ucfirst($value->REFTABELA).' = new '.ucfirst($value->REFTABELA).'();'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj->'.$value->REFTABELA.' = $obj'.ucfirst($value->REFTABELA).'->selectById($obj->'.$value->COLUNA.');'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'}'."\n", FILE_APPEND);
				} 
			}else{
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'foreach ($collectionThis as $obj){'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj'.ucfirst($resultConstraint->REFTABELA).' = new '.ucfirst($resultConstraint->REFTABELA).'();'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj->'.$resultConstraint->REFTABELA.' = $obj'.ucfirst($resultConstraint->REFTABELA).'->selectById($obj->'.$resultConstraint->COLUNA.');'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'}'."\n", FILE_APPEND);
			}
		}
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'return $collectionThis;'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'}'."\n \n", FILE_APPEND);
		
		//select
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function select($where){'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'$collectionThis = parent::doFind($this,$where);'."\n", FILE_APPEND);
		if($resultConstraint){
			file_put_contents($this->path.'/'.ucfirst($table).".php","\n", FILE_APPEND);
			if(is_array($resultConstraint)){
				foreach($resultConstraint as $value){
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'foreach ($collectionThis as $obj){'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj'.ucfirst($value->REFTABELA).' = new '.ucfirst($value->REFTABELA).'();'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj->'.$value->REFTABELA.' = $obj'.ucfirst($value->REFTABELA).'->selectById($obj->'.$value->COLUNA.');'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'}'."\n", FILE_APPEND);
				} 
			}else{
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'foreach ($collectionThis as $obj){'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj'.ucfirst($resultConstraint->REFTABELA).' = new '.ucfirst($resultConstraint->REFTABELA).'();'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$obj->'.$resultConstraint->REFTABELA.' = $obj'.ucfirst($resultConstraint->REFTABELA).'->selectById($obj->'.$resultConstraint->COLUNA.');'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'}'."\n", FILE_APPEND);
			}
		}
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'return $collectionThis;'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'}'."\n \n", FILE_APPEND);
		
		//selectById
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function selectById($id){'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'$this->id = $id;'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'$objthis = parent::doFind($this);'."\n", FILE_APPEND);
		if($resultConstraint){
			file_put_contents($this->path.'/'.ucfirst($table).".php","\n", FILE_APPEND);
			if(is_array($resultConstraint)){
				foreach($resultConstraint as $value){
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t ".'$obj'.ucfirst($value->REFTABELA).' = new '.ucfirst($value->REFTABELA).'();'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t ".'$objthis->'.$value->REFTABELA.' = $obj'.ucfirst($value->REFTABELA).'->selectById($objthis->'.$value->COLUNA.');'."\n", FILE_APPEND);
				} 
			}else{
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t ".'$obj'.ucfirst($resultConstraint->REFTABELA).' = new '.ucfirst($resultConstraint->REFTABELA).'();'."\n", FILE_APPEND);
						file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t ".'$objthis->'.$resultConstraint->REFTABELA.' = $obj'.ucfirst($resultConstraint->REFTABELA).'->($objthis->'.$resultConstraint->COLUNA.');'."\n", FILE_APPEND);
			}
		}
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'return $objthis;'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'}'."\n \n", FILE_APPEND);
		
		//save
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function save(){'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'$result = parent::doSave($this);'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'return $this;'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'}'."\n \n", FILE_APPEND);
		
		//delete
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function delete(){'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'if($this->id > 0){'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'$result = parent::doDelete($this);'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'return $result;'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'}else{'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t \t".'return false;'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'}'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'}'."\n \n", FILE_APPEND);
		
		//populationClass
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'public function populationClass($arrDados){'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t \t".'parent::doPopulationClass($this,$arrDados);'."\n", FILE_APPEND);
		file_put_contents($this->path.'/'.ucfirst($table).".php","\t".'}'."\n \n", FILE_APPEND);
		
		file_put_contents($this->path.'/'.ucfirst($table).".php","\n".'}'."\n ?>", FILE_APPEND);
		
	}
	
	public function getTables(){
		return parent::doExecuteSelect('SHOW TABLES');
	}
	
	public function getConstraint($table){
		$query = "SELECT COLUMN_NAME AS COLUNA, 
					     REFERENCED_COLUMN_NAME AS REFCOLUNA, 
						 REFERENCED_TABLE_NAME AS REFTABELA 
					FROM information_schema.KEY_COLUMN_USAGE
				   WHERE TABLE_NAME = '{$table}' 
				     AND REFERENCED_TABLE_NAME IS NOT NULL";
		
		return parent::doExecuteSelect($query);
	}
	
}
?>