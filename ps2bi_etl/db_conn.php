<?php  
//Database Connection
   //ENTER YOUR DATABASE CONNECTION INFO BELOW:
	 $hostname="localhost";
	 $database="dgc_extract";
	 $username="sr-etlmaster";
	 $password="DI4OBEFIQimE6eXelOMo32SEk3Wa3u";

   //DO NOT EDIT BELOW THIS LINE
     $link = mysql_connect($hostname, $username, $password);
     mysql_select_db($database) or die('Could not select database');
?>