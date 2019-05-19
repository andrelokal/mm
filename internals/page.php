<?php  
include('../util/config.php') ;

$help = new Help();
$result = $help->getItem($_GET['id']);
$title = $result->title_item;
$content = $result->description_item;
$parent = $result->parent;

?>
<div class="panel panel-info">
  <div class="panel-heading"><?=$parent." / ".$title?></div>
  <div class="panel-body">
  <?=$content?>
  </div>
</div>