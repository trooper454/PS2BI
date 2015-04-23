<?php  
//Clear old data
mysql_query("TRUNCATE TABLE `dgc_extract`.`character`");

//Set date to get values from
$timestamp = $timestamp_start;

//Grab data from API and parse to array
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/character/?times.last_save=]'.$timestamp.'&c:limit=200000&c:show=name.first,name.first_lower,battle_rank.value,character_id,faction_id,times.creation,times.last_login,times.last_save,times.login_count,times.minutes_played&c:join=characters_world^on:character_id^to:character_id^show:world_id^inject_at:world_id');
$array = json_decode($json,true);

//remove row with rowcount
unset($array['returned']); 

//stop mysql autocommit
mysql_query("SET autocommit = 0;");

//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `dgc_extract`.`character` (first, first_lower, battle_rank, character_id, faction_id, creation, last_login, last_save, login_count, minutes_played, world_id) 
			VALUES ('".$row['name']['first']."',
			'".$row['name']['first_lower']."', 
			'".$row['battle_rank']['value']."', 
			'".$row['character_id']."', 
			'".$row['faction_id']."', 
			'".$row['times']['creation']."', 
			'".$row['times']['last_login']."', 
			'".$row['times']['last_save']."', 
			'".$row['times']['login_count']."', 
			'".$row['times']['minutes_played']."',
			'".$row['world_id']['world_id']."')");
	}
 }
//commit transactions and turn autocommit back on
mysql_query("COMMIT;");
mysql_query("SET autocommit = 1;");

?>