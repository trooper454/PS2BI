<?php
//Extraction Master
/*
Requires the following variables to be passed:
$timestamp_start
$timestamp_end
$run_id
$detail_id
$stage_desc
*/

//character
$step_desc = 'character';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\character.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//outfit
$step_desc = 'outfit';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\outfit.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//outfit_member
$step_desc = 'outfit_member';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\outfit_member.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//item
$step_desc = 'item';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\item.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//item_category
$step_desc = 'item_category';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\item_category.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//item_type
$step_desc = 'item_type';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\item_type.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//world
$step_desc = 'world';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\world.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//faction
$step_desc = 'faction';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
require_once('\extraction\faction.php');
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

?>