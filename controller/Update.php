<?php 
 class Update extends DAO{ 

 	private $obj;
    public $data;
    public $msg;
    public $dir = '';
    public $log = '';
    public $db = '';
 
	public function __construct(){
 		
 		$conf = parse_ini_file(PATH_ROOT."util/config.ini");

 		$this->dir = PATH_ROOT.$conf['dir'];
 		$this->log = PATH_ROOT.$conf['log'];
 		$this->db = PATH_ROOT.$conf['db'];

		// confere se pasta de update existe
		if( !file_exists( $this->dir ) ){
			mkdir($this->dir);
		}
	 	
	}
 
	#setters, getters, isset, unset magicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
 
 	
 	function read(){

 		$updates = [];
 		$log_ar = [];
 		$list = glob($this->dir.'/*.sql');

		if( file_exists( $this->log ) ){
			$log_ar = explode( chr(13), file_get_contents( $this->log ) );
		} 

		foreach ($list as $key => $value) {
			if( !in_array( $value , $log_ar) ){
				$updates[] = $value;
			}
		}

		foreach ($updates as $key => $value) {
			
			$content = file_get_contents( $value );

			$lines = explode( "\n", $content );
			$new_lines = [];
			foreach ($lines as $l) {
				if( strpos(' '.trim($l),'--') == 1 or strpos(' '.trim($l),'/*') == 1 ) continue;
				$new_lines[] = $l;
			}

			$content = implode( chr(13), $new_lines );
			$content = preg_replace('/[\n\r]+/', ' ' , $content);
			$content = preg_replace('/\`/', "" , $content);

			$sql = explode(";",$content);

			$sql = array_filter($sql);
			foreach( $sql as $s ){
				if( ltrim(trim($s)) ){
					//echo utf8_encode( $s )."<BR><BR>";
					parent::doExecuteSQL( $s );
					//exit;	
				}			
				
			}
		}

		$r = '';
		if( file_exists( $this->log ) ) $r = chr(13);
		file_put_contents($this->log, $r.implode( chr(13) ,$updates));
 		return true;
 	}
	
 

}
 ?>