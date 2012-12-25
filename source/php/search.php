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


        // everything from here...
        print "{";
        $i = 1;
        $len = count($rows);
        foreach ($rows as $id => $result) {
            print '"'.$id.'":{';

            $j = 1;
            foreach ($result as $field => $value) {
                print '"'.$field.'"'.':'.'"'.$value.'"';
                if ($j != count($result))
                    print ',';
                $j++;
            }

            print '}';
            if ($i != $len)
                print ',';
            $i ++;
        }
        print "}";

        // ...until here, could be replaced with a simple
        // print json_encode($rows);
        // if we can update the php version on the server!


    }
    else {
        echo "Error: failed or no result from query";
    }

    mysql_close($con);
?>
