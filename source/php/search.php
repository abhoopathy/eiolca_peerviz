<?php

    include("headers.php");
    mysql_select_db("eiolca", $con);
    $search_term = $_GET['term'];

    $query = "SELECT school.unitid, school.school, peers_privates.is_private, peers_cities.city, peers_cities.state, peers_cities.state, peers_cities.zip, peers_climates.climate, peers_endowments.endowment, peers_enrollments.enrollment, peers_locations.lat, peers_locations.lng FROM `school`, `peers_cities`, peers_climates, peers_degrees, peers_endowments, peers_enrollments, peers_locations, peers_privates WHERE `SCHOOL` LIKE  '%".$search_term."%' AND school.unitid = peers_cities.unitid AND school.unitid = peers_climates.unitid AND school.unitid = peers_degrees.unitid AND school.unitid = peers_enrollments.unitid AND school.unitid = peers_locations.unitid AND school.unitid = peers_privates.unitid AND school.unitid = peers_endowments.unitid AND school.unitid = peers_privates.unitid LIMIT 0,50";


    $result = mysql_query($query);

    if($result) {
        $rows = array();
		while ($r = mysql_fetch_assoc($result)) {
            $rows[$r['unitid']] = $r;
		}
        print json_encode($rows);
	}
	else {
		echo "Error: failed or no result from query";
	}

    mysql_close($con);
?>
