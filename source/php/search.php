<?php

    include("headers.php");
    mysql_select_db("eiolca", $con);

    $query = "SELECT * FROM  `school` WHERE  `SCHOOL` LIKE  '%min%' LIMIT 0 , 50";
	//send query
    $result = mysql_query($query);
	#parse result to JSON
    /*** Print output ***/

    if($result)
    {
    	echo "[";
		//get row
		$j=0;
		while ($row = mysql_fetch_array($result))
		{
			if($j++ != 0)
				echo ",";

			echo "{";
			$i=0;

            echo "value: \"";
            echo $row[1];
            echo "\", ";
            echo "label: \"";
            echo $row[0];

			echo "\"}";
		}
    	echo "]";
	}
	else
	{
		echo "Error: failed or no result from query";
	}

    mysql_close($con);
?>
