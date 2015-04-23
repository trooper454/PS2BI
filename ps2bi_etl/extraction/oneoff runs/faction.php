<?php  
//Database Connection
require_once('db_conn.php');

//Clear old data
mysql_query("TRUNCATE TABLE `dgc_extract`.`faction`");

//Grab data from API and parse to array
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/faction/?c:limit=100');
$array = json_decode($json,true);

//remove row with rowcount
unset($array['returned']); 

//stop mysql autocommit
mysql_query("SET autocommit = 0;");

//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `dgc_extract`.`faction` (name_en, code_tag, faction_id) 
			VALUES ('".$row['name']['en']."',
			'".$row['code_tag']."', 
			'".$row['faction_id']."')");
	}
 }
//commit transactions and turn autocommit back on
mysql_query("COMMIT;");
mysql_query("SET autocommit = 1;");

//close DB connection
mysql_close($link);

?>