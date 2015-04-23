<?php  
//Clear old data
mysql_query("TRUNCATE TABLE `dgc_extract`.`item_type`");

//Grab data from API and parse to array
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/item_type/?c:limit=1000');
$array = json_decode($json,true);

//remove row with rowcount
unset($array['returned']); 

//stop mysql autocommit
mysql_query("SET autocommit = 0;");

//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `dgc_extract`.`item_type` (name, code, item_type_id) 
			VALUES ('".$row['name']."',
			'".$row['code']."',
			'".$row['item_type_id']."')");
	}
 }
//commit transactions and turn autocommit back on
mysql_query("COMMIT;");
mysql_query("SET autocommit = 1;");
?>