<?php  
//Clear old data
mysql_query("TRUNCATE TABLE `dgc_extract`.`item`");

//set extraction parameters
$fetch_qty = 5000;
$start_loc = 0;

//stop mysql autocommit
mysql_query("SET autocommit = 0;");

//First Run
//Grab data from API and parse to array
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/item/?c:limit='.$fetch_qty.'&c:start='.$start_loc);
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
			mysql_query("INSERT INTO `dgc_extract`.`item` (name_en, faction_id, is_default_attachment, is_vehicle_weapon, item_category_id, item_id, item_type_id, max_stack_size) 
			VALUES ('".$row['name']['en']."',
			'".$row['faction_id']."', 
			'".$row['is_default_attachment']."',
			'".$row['is_vehicle_weapon']."',
			'".$row['item_category_id']."',
			'".$row['item_id']."',
			'".$row['item_type_id']."',
			'".$row['max_stack_size']."');");
	}
 }
//commit transactions
mysql_query("COMMIT;");

//iterative runs
while($result_qty > 0){
	//Grab data from API and parse to array
	$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/item/?c:limit='.$fetch_qty.'&c:start='.$start_loc);
	$array = json_decode($json,true);

	//update loop variables
	$result_qty = $array['returned'];
	$start_loc = $start_loc + $result_qty;
	
	//remove row with rowcount
	unset($array['returned']); 

	//insert data into DB 
	foreach($array as $table) {
		foreach($table as $row){ 
				mysql_query("INSERT INTO `dgc_extract`.`item` (name_en, faction_id, is_default_attachment, is_vehicle_weapon, item_category_id, item_id, item_type_id, max_stack_size) 
				VALUES ('".$row['name']['en']."',
				'".$row['faction_id']."', 
				'".$row['is_default_attachment']."',
				'".$row['is_vehicle_weapon']."',
				'".$row['item_category_id']."',
				'".$row['item_id']."',
				'".$row['item_type_id']."',
				'".$row['max_stack_size']."');");
		}
	}
	//commit transactions
	mysql_query("COMMIT;");
}

//turn autocommit back on
mysql_query("SET autocommit = 1;");
?>