<?php

class Normalize{
    

    function date_br( $value, $row = NULL ){
        
        //([0-9]+)\-([0-9]+)\-([0-9]+)\s*((.*)+) ---  $3/$2/$1 $4 --- Ex: 2016-01-10 00:00:00
        $value = preg_replace( '/([0-9]+)\-([0-9]+)\-([0-9]+)\s*((.*)+)/' , "$3/$2/$1 $4", $value);
        return $value ;
        
    }


    function date_mysql( $value ){
        
        $value = preg_replace( '/([0-9]{2})\/([0-9]{2})\/([0-9]{4})/' , "$3-$2-$1", $value);
        return $value ;
        
    }
    
    
    
    
    
}
?>
