<?php  
//Database Connection
require_once('db_conn.php');

//Clear old data
mysql_query("TRUNCATE TABLE `dgc_extract`.`outfit`");

//set extraction parameters
$fetch_qty = 100000;
$start_loc = 0;

//stop mysql autocommit
mysql_query("SET autocommit = 0;");

//First Run
//Grab data from API and parse to array
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/outfit/?c:limit='.$fetch_qty.'&c:start='.$start_loc.'&c:join=characters_world^on:leader_character_id^to:character_id^show:world_id^inject_at:world_id,character^on:leader_character_id^to:character_id^show:faction_id^inject_at:faction_id');
$array = json_decode($json,true);

//update loop variables
$result_qty = $array['returned'];
$max_fetch = $result_qty;
$start_loc = $start_loc + $result_qty;
echo "Result: ".$result_qty.", Start: ".$start_loc."\n";

//remove row with rowcount
unset($array['returned']); 

//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `dgc_extract`.`outfit` (name, alias, leader_character_id, member_count, outfit_id, time_created, faction_id, world_id) 
			VALUES ('".$row['name']."',
			'".$row['alias']."', 
			'".$row['leader_character_id']."', 
			'".$row['member_count']."', 
			'".$row['outfit_id']."', 
			'".$row['time_created']."',
			'".$row['faction_id']['faction_id']."',
			'".$row['world_id']['world_id']."')");
	}
 }
//commit transactions
mysql_query("COMMIT;");

//iterative runs
while($result_qty > 0){
	//Grab data from API and parse to array
	$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/outfit/?c:limit='.$max_fetch.'&c:start='.$start_loc.'&c:join=characters_world^on:leader_character_id^to:character_id^show:world_id^inject_at:world_id,character^on:leader_character_id^to:character_id^show:faction_id^inject_at:faction_id');
	$array = json_decode($json,true);

	//update loop variables
	$result_qty = $array['returned'];
	$start_loc = $start_loc + $result_qty;
	echo "Result: ".$result_qty.", Start: ".$start_loc."\n";
	
	//remove row with rowcount
	unset($array['returned']); 

	//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `dgc_extract`.`outfit` (name, alias, leader_character_id, member_count, outfit_id, time_created, faction_id, world_id) 
			VALUES ('".$row['name']."',
			'".$row['alias']."', 
			'".$row['leader_character_id']."', 
			'".$row['member_count']."', 
			'".$row['outfit_id']."', 
			'".$row['time_created']."',
			'".$row['faction_id']['faction_id']."',
			'".$row['world_id']['world_id']."')");
		}
	 }
	//commit transactions
	mysql_query("COMMIT;");
}

//turn autocommit back on
mysql_query("SET autocommit = 1;");

//close DB connection
mysql_close($link);

?>