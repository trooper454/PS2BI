<?php
//Staging Master Load
/*
Requires the following variables to be passed:
$run_id
$detail_id
$stage_desc
*/

//dim_character
$step_desc = 'dim_character';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
mysql_query("CALL ps2bi_dwh.dim_character_load");
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//dim_outfit
$step_desc = 'dim_outfit';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
mysql_query("CALL ps2bi_dwh.dim_outfit_load");
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//dim_item
$step_desc = 'dim_item';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
mysql_query("CALL ps2bi_dwh.dim_item_load");
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//fct_playtime
$step_desc = 'fct_playtime';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/d h:i:s')."');");
mysql_query("CALL ps2bi_dwh.fct_playtime_load");
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

?>