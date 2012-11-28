<?php

    include("headers.php");
    mysql_select_db("eiolca", $con);
    $search_term = $_GET['term'];

    $query = "SELECT * FROM  `school` WHERE  `SCHOOL` LIKE  '%".$search_term."%' LIMIT 0 , 50";

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

            echo "\"value\": \"".$row[1]."\", "."\"label\": \"".$row[0]."\"";

			echo "}";
		}
    	echo "]";
	}
	else
	{
		echo "Error: failed or no result from query";
	}

    mysql_close($con);
?>
