<?php  
//Clear old data
mysql_query("TRUNCATE TABLE `dgc_extract`.`outfit_member`");

//set extraction parameters
$fetch_qty = 100000;
$start_loc = 0;

//stop mysql autocommit
mysql_query("SET autocommit = 0;");

//First Run
//Grab data from API and parse to array
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/outfit_member/?c:limit='.$fetch_qty.'&c:start='.$start_loc.'');
$array = json_decode($json,true);

//update loop variables
$result_qty = $array['returned'];
$max_fetch = $result_qty;
$start_loc = $start_loc + $result_qty;

//remove row with rowcount
unset($array['returned']); 

//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `dgc_extract`.`outfit_member` (character_id, member_since, outfit_id, rank, rank_ordinal) 
			VALUES ('".$row['character_id']."',
			'".$row['member_since']."',  
			'".$row['outfit_id']."', 
			'".$row['rank']."', 
			'".$row['rank_ordinal']."')");
	}
 }
//commit transactions
mysql_query("COMMIT;");

//iterative runs
while($result_qty > 0){
	//Grab data from API and parse to array
	$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/outfit_member/?c:limit='.$max_fetch.'&c:start='.$start_loc.'');
	$array = json_decode($json,true);

	//update loop variables
	$result_qty = $array['returned'];
	$start_loc = $start_loc + $result_qty;
	
	//remove row with rowcount
	unset($array['returned']); 

	//insert data into DB 
	foreach($array as $table) {
		foreach($table as $row){ 
				mysql_query("INSERT INTO `dgc_extract`.`outfit_member` (character_id, member_since, outfit_id, rank, rank_ordinal) 
				VALUES ('".$row['character_id']."',
				'".$row['member_since']."',  
				'".$row['outfit_id']."', 
				'".$row['rank']."', 
				'".$row['rank_ordinal']."')");
		}
	 }
	//commit transactions
	mysql_query("COMMIT;");
}

//turn autocommit back on
mysql_query("SET autocommit = 1;");
?>