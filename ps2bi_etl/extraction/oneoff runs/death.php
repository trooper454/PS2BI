<?php  
//Database Connection
require_once('db_conn.php');

//Clear old data
//mysql_query("TRUNCATE TABLE `dgc_extract`.`death`");

//set extraction parameters
$timestamp_start = strtotime('2/27/2015');
$timestamp_end = $timestamp_start + 86400;
$fetch_qty = 10000;
$before_bound = $timestamp_end+1;
$after_bound = $timestamp_start-1;

//stop mysql autocommit
mysql_query("SET autocommit = 0;");

//First Run
//Grab data from API and parse to array
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/event/?type=DEATH&before='.$before_bound.'&after='.$after_bound.'&c:limit='.$fetch_qty.'');
$array = json_decode($json,true);

//update loop variables
$result_qty = $array['returned'];
$max_fetch = $result_qty;
$count = 0;

//remove row with rowcount
unset($array['returned']); 

//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `dgc_extract`.`death` (attacker_character_id, attacker_vehicle_id, attacker_weapon_id, character_id, is_critical, is_headshot, timestamp, world_id, zone_id) 
			VALUES ('".$row['attacker_character_id']."',
			'".$row['attacker_vehicle_id']."', 
			'".$row['attacker_weapon_id']."', 
			'".$row['character_id']."',  
			'".$row['is_critical']."', 
			'".$row['is_headshot']."',  
			'".$row['timestamp']."', 
			'".$row['world_id']."', 
			'".$row['zone_id']."');");
			$count = $count + 1;
	}
 }
//commit transactions
mysql_query("COMMIT;");

//get lowest timestamp from loaded records
$returned_bound = mysql_fetch_row(mysql_query("select min(timestamp) from dgc_extract.death"))[0];

//echo check
echo "From: ".$after_bound." | To: ".$before_bound." | Stopped: ".$returned_bound." | Rows: ".$count."\n";
$before_bound = $returned_bound + 1;

//iterative runs
while($after_bound < $before_bound - 2 and $count != 0){
	//Grab data from API and parse to array
	$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/event/?type=DEATH&before='.$before_bound.'&after='.$after_bound.'&c:limit='.$fetch_qty.'');
	$array = json_decode($json,true);

	//update loop variables
	$result_qty = $array['returned'];
	$max_fetch = $result_qty;
	$count = 0;

	//remove row with rowcount
	unset($array['returned']); 

	//insert data into DB 
	foreach($array as $table) {
		foreach($table as $row){ 
				mysql_query("INSERT INTO `dgc_extract`.`death` (attacker_character_id, attacker_vehicle_id, attacker_weapon_id, character_id, is_critical, is_headshot, timestamp, world_id, zone_id) 
				VALUES ('".$row['attacker_character_id']."',
				'".$row['attacker_vehicle_id']."', 
				'".$row['attacker_weapon_id']."', 
				'".$row['character_id']."',  
				'".$row['is_critical']."', 
				'".$row['is_headshot']."',  
				'".$row['timestamp']."', 
				'".$row['world_id']."', 
				'".$row['zone_id']."');");
				$count = $count + 1;
		}
	 }
	//commit transactions
	mysql_query("COMMIT;");

	//get lowest timestamp from loaded records
	$returned_bound = mysql_fetch_row(mysql_query("select min(timestamp) from dgc_extract.death"))[0];

	//echo check
	echo "From: ".$after_bound." | To: ".$before_bound." | Stopped: ".$returned_bound." | Rows: ".$count."\n";
	$before_bound = $returned_bound + 1;
}

//turn autocommit back on
mysql_query("SET autocommit = 1;");

//close DB connection
mysql_close($link);

?>