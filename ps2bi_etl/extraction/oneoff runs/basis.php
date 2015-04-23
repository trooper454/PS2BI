<div>
<?php  
//Database Connection
   //ENTER YOUR DATABASE CONNECTION INFO BELOW:
	 $hostname="localhost";
	 $database="test";
	 $username="sr-wordpress";
	 $password="wpSRpass";

   //DO NOT EDIT BELOW THIS LINE
     $link = mysql_connect($hostname, $username, $password);
     mysql_select_db($database) or die('Could not select database');

//Clear old data
mysql_query("TRUNCATE TABLE `test`.`outfit_member_list`");

//Grab data from API
$json = file_get_contents('http://census.soe.com/s:tdavis25/get/ps2:v2/outfit_member/?c:resolve=online_status&c:resolve=character_name&outfit_id=37514290234416173&c:limit=500');
$array = json_decode($json,true);
array_pop($array); //removes last row with rowcount

//insert data into DB 
foreach($array as $table) {
	foreach($table as $row){ 
			mysql_query("INSERT INTO `test`.`outfit_member_list` (character_id, member_since, member_since_date, outfit_id, rank, rank_ordinal, online_status, char_name) 
			VALUES ('".$row['character_id']."',
			'".$row['member_since']."', 
			'".$row['member_since_date']."', 
			'".$row['outfit_id']."', 
			'".$row['rank']."', 
			'".$row['rank_ordinal']."', 
			'".$row['online_status']."', 
			'".$row['character']['name']['first']."')");
	}
 }
 
mysql_close($link);

?>