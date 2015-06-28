<?php
$openFile = '/Users/nazario/Desktop/BusCapper/DATA/2014-08-01/MTA-Bus-Time_.2014-08-01.txt';
$writeFile = '/Users/nazario/Desktop/BusCapper/DATA/2014-08-01/MTA-Bus-Time_.2014-08-01_processesd.sql';

$inFile = fopen($openFile, 'r');
$outFile = fopen($writeFile, 'w');

if($inFile){
  while( ($line = fgets($inFile)) !== false) {
    $line = trim($line);
    /*
    $newLine = preg_replace('/,([0-9]{1,})\/([0-9]{1,})\/([0-9]{1,}) ([0-9]{1,}:[0-9]{1,}),/', ',20${3}-${1}-${2} ${4},', $line);

    $query_string = 'insert into raw_data (vehicle_id,time_stamp,latitude,longitude,phase,trip_id,direction_id,trip_headsign,shape_dist_traveled,stop_id,stop_sequence,dist_from_stop,extra_1,extra_2,extra_3) values("'.preg_replace('/,/', '","', $newLine).'");';
    */


    //latitude	longitude	time_received	vehicle_id	distance_along_trip	inferred_direction_id	inferred_phase	inferred_route_id	inferred_trip_id	next_scheduled_stop_distance	next_scheduled_stop_id
    $query_string = 'insert into raw_data(raw_file_name, latitude, longitude, time_received, vehicle_id, distance_along_trip, inferred_direction_id, inferred_phase, inferred_route_id, inferred_trip_id, next_scheduled_stop_distance, next_scheduled_stop_id) values("MTA-Bus-Time_.2014-08-01.txt.xz","'.preg_replace('/\t/', '","', $line).'");
    ';


    $result = preg_replace('/,"NULL"/', ',NULL', $query_string); // replace empty quotes with NULL


    // echo($quoted_string);
    fwrite($outFile, $result);

  }
  fclose($inFile);
  fclose($outFile);
  echo('done!');
}else{
  echo 'bad things happened';
}
