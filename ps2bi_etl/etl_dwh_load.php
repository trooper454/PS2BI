<?php
//Staging Master Load
/*
Requires the following variables to be passed:
$run_id
$detail_id
$stage_desc
*/

//stg_dim_character
$etl_step = 'stg_dim_character';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/s h:m:s')."');");
mysql_query("CALL ps2bi_stg.stg_dim_character_load");
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/s h:m:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//stg_dim_outfit
$etl_step = 'stg_dim_outfit';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/s h:m:s')."');");
mysql_query("CALL ps2bi_stg.stg_dim_outfit_load");
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/s h:m:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

//stg_dim_item
$etl_step = 'stg_dim_item';
$detail_id = $detail_id + 1;
mysql_query("INSERT INTO ps2bi_etl.etl_detail (run_id,detail_id,stage_desc,step_desc,start_time) VALUES ('".$run_id."','".$detail_id."','".$stage_desc."','".$step_desc."','".date('y/m/s h:m:s')."');");
mysql_query("CALL ps2bi_stg.stg_dim_item_load");
mysql_query("UPDATE ps2bi_etl.etl_detail SET end_time = '".date('y/m/s h:m:s')."' WHERE run_id = ".$run_id." and detail_id = ".$detail_id.";");

?>