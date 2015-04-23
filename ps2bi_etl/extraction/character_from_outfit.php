<?php  
//Database Connection
require_once('db_conn.php');

//set var
$work_count = 1;

while($work_count > 0){
	//get records to work
	$result = mysql_query("select count(character_id) from character_id;");
	$work_count = mysql_fetch_row($result);
	$work_count = $work_count[0];

	//Select records to work
	$work_list = '';
	$loop = 0;
	$result = mysql_query("select character_id from character_id limit 300;");
	while($row =  mysql_fetch_array($result)){
		$loop = $loop + 1;
		if($loop == 1){$work_list = $row[0];}
		else {$work_list = $work_list.",".$row[0];}
	}

	//Grab data from API and parse to array
	$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/character/?character_id='.$work_list.'&c:show=name.first,name.first_lower,battle_rank.value,character_id,faction_id,times.creation,times.last_login,times.last_save,times.login_count,times.minutes_played&c:join=characters_world^on:character_id^to:character_id^show:world_id^inject_at:world_id');
	$array = json_decode($json,true);
	
	//remove row with rowcount
	unset($array['returned']); 

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
				'".$row['world_id']['world_id']."');");
		}
	 }
	
	//remove records just worked
	mysql_query("delete from character_id where character_id in(".$work_list.");");
}

//close DB connection
mysql_close($link);

?>