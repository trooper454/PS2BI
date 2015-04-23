<?php  
//Database Connection
require_once('db_conn.php');

//set etl date
$etl_date = new datetime();
$etl_date = date_sub($etl_date, date_interval_create_from_date_string('1 day'));
$etl_date = date('y/m/d',date_timestamp_get($etl_date));

//set etl bounds
$date_qry = mysql_query("SELECT timestamp_start FROM ps2bi_dwh.dim_date WHERE date_field = '" . $etl_date . "';");
$timestamp_start = mysql_fetch_row($date_qry)[0];
$date_qry = mysql_query("SELECT timestamp_end FROM ps2bi_dwh.dim_date WHERE date_field = '" . $etl_date . "';");
$timestamp_end = mysql_fetch_row($date_qry)[0];

//verify
echo "date: ".$etl_date."
start: ".$timestamp_start."
end: ".$timestamp_end;

//insert ETL Header record and get run number
mysql_query("INSERT INTO ps2bi_etl.etl_header (etl_date,master_start) VALUES ('".$etl_date."','".date('y/m/d h:i:s')."');");
$run_id = mysql_query("SELECT max(run_id) FROM ps2bi_etl.etl_header WHERE etl_date = '" . $etl_date . "';");
$run_id = mysql_fetch_row($run_id)[0];
$detail_id = 0;

//Extraction
mysql_query("UPDATE ps2bi_etl.etl_header SET extract_start = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");
$stage_desc = 'Extraction';
require_once('etl_extract.php');
mysql_query("UPDATE ps2bi_etl.etl_header SET extract_end = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");

//STG Load
mysql_query("UPDATE ps2bi_etl.etl_header SET staging_start = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");
$stage_desc = 'Staging load';
require_once('etl_stage.php');
mysql_query("UPDATE ps2bi_etl.etl_header SET staging_end = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");

//DWH Load
mysql_query("UPDATE ps2bi_etl.etl_header SET dwh_load_start = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");
$stage_desc = 'DWH Load';
require_once('etl_load.php');
mysql_query("UPDATE ps2bi_etl.etl_header SET dwh_load_end = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");

//Aggregation
mysql_query("UPDATE ps2bi_etl.etl_header SET dwh_agg_start = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");
$stage_desc = 'DWH Agg';
require_once('etl_aggregate.php');
mysql_query("UPDATE ps2bi_etl.etl_header SET dwh_agg_end = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");

//Stop ETL Tasks
mysql_query("COMMIT;");
mysql_query("SET autocommit = 1;");
mysql_query("UPDATE ps2bi_etl.etl_header SET master_end = '".date('y/m/d h:i:s')."' WHERE run_id = ".$run_id.";");

//close DB connection
mysql_close($link);

?>