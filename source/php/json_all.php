<?php
	class Filter
	{
		public $table_name;
		public $column_name;
		public $url_name;
		public $compare_type;

		public $or_cont;
		public $and_cont;

		public function __construct($table, $column, $urlname, $compare)
		{
			$this->table_name = $table;
			$this->column_name = $column;
			$this->url_name = $urlname;
			$this->compare_type = $compare;
		}

		public function toCondition($values)
		{
			$retstr = "";
			if($values[$this->url_name] != null) {
				$retstr .= "(";
				$retstr .= $this->table_name.".".$this->column_name.$this->compare_type.$values[$this->url_name];
			
				if($this->or_cont != null) {
					$retstr .= " or ";
					$retstr .= $this->or_cont->toCondition($values);
				}
				if($this->and_cont != null) {
					$retstr .= " and ";
					$retstr .= $this->and_cont->toCondition($values);
				}
				$retstr .= ")";
			}
			return $retstr;
		}
	}

    /*** HELPER FUNCTIONS ***/

	function jsonData($tag, $data)
    {
		echo "\"".$tag."\"";
		echo ":";
		echo "\"".$data."\"";
    }

	$column_list = array();
	$table_list = array();
	$condition_list = array();
	
	
	// Filters: table name, column name, url argument name, comparison operator (= for output selection)
	$filters = array(1 => new Filter("ipeds", "school", "schoolname", "="),
					 2 => new Filter("ipeds", "city", "city", "="),
					 3 => new Filter("ipeds", "state", "state", "="),
					 4 => new Filter("ipeds", "latitude", "lat", "="),
					 5 => new Filter("ipeds", "longitude", "lng", "="),
					 6 => new Filter("ipeds", "CZ", "climate", "="),
					 7 => new Filter("ipeds", "TOTAL_ENROLLMENT", "enrollment", "="),
					 8 => new Filter("ipeds", "TOTAL_ENROLLMENT", "hi_pop", "<"),
					 9 => new Filter("ipeds", "TOTAL_ENROLLMENT", "lo_pop", ">"),
					 10 => new Filter("ipeds","CONTROL", "control", "="), // Fix from number to description
					 11 => new Filter("ipeds","DEGREE_OFFERED", "degree", "="),// Fix from number to description
					 12 => new Filter("ipeds","DE","data","="),
					 13 => new Filter("ipeds","UNITID","unitid","="),
					 14 => new Filter("ipeds","LEVEL","level","="),
					 15 => new Filter("ipeds","COMMUNITY_SETTING","commset","="),
					 16 => new Filter("ipeds","RESIDENTIAL_STATUS","resstat","="),
           17 => new Filter("peers_endowments","endowment","endowment","=")
					);
	$limit_cond = "";
	$order_cond = "";
	/*** Add optional filters ***/
	
	foreach($_GET as $key => $value)
	{
		switch($key)
		{
			case "hi_endowment":
				array_push($filters, new Filter("peers_endowments", "endowment", "hi_endowment", "<="));
				break;
			case "lo_endowment":
				array_push($filters, new Filter("peers_endowments", "endowment", "lo_endowment", ">"));
				break;
			
			case "search_name":
				$search_filter = new Filter("peers_names", "name", "search_name", " like ");
				$search_filter->or_cont = new Filter("peers_names", "alias", "search_name", " like ");
				array_push($filters, $search_filter);
				if(substr($value,0,1)=="\"" && substr($value,-1)=="\"") {
					$_GET[$key] = substr($value, 1, -1);
				}
				$_GET[$key] = "\"%".$_GET[$key]."%\"";
				break;
			case "limit_results":
				$limit_cond = " limit 0,$value";
				break;
			case "order_asc":
				$order_cond = " order by $value asc";
				break;
			case "order_desc":
				$order_cond = " order by $value desc";
				break;
			default:
				break;
		}
	}

	foreach($columns_to_show as $col) {
		array_push($filters, new Filter($col[table],$col[column],$col[name], "="));
	}
	/*** Parse Filters ***/
	foreach($filters as $f)
	{
		$column = $f->table_name.".".$f->column_name;
		if(in_array($column, $column_list)){}
		else
		{
			array_push($column_list, $column);
		}

		if(in_array($f->table_name, $table_list)){}
		else
		{
			array_push($table_list, $f->table_name);
		}
	
		$c = $f->toCondition($_GET);
		if($c != "")	
			array_push($condition_list, $c);
	}
	
	/*** Build Query ***/
	$query = "";
	$query .= "select ";
	$i=1;
	foreach($column_list as $c)
	{
		$query .= $c;
		if(count($column_list) > $i)
		{
			$query .= ", ";
			$i++;
		}
	}
	$query .= " from ";
	$i=1;
	foreach($table_list as $t)
	{
		$query .= $t;
		if(count($table_list) > $i)
		{
			$query .= ", ";
			$i++;
		}
	}
	$query .= " where ";
	$i=1;
	foreach($table_list as $t)
	{
		$query .= $table_list[0].".UNITID=".$t.".UNITID";
		if(count($table_list) > $i)
		{
			$query .= " and ";
			$i++;
		}
	}
	foreach($condition_list as $cond)
	{
		$query .= " and ".$cond;
	}
	
    /*** Connection to MySQL Database ***/
    $con = mysql_connect("localhost", "eiolca", "xyzzy");
	
    if (!$con)
    {
		die('Could not connect to database: ' . mysql_error());
    }

    mysql_select_db("eiolca", $con);

	$query .= $order_cond.$limit_cond;
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
			foreach($filters as $f)
			{
				if($f->compare_type == "=") {
					if($i++ != 0)
						echo ",";
				
					if($row[$f->column_name] != null)
						jsonData($f->url_name, $row[$f->column_name]);
					else
						jsonData($f->url_name, "");
				}
			}
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
