SELECT raw_id, latitude, longitude, time_received, vehicle_code, ROUND(distance_along_trip,5) as dist_along_trip, inferred_direction_code AS direction, inferred_phase, inferred_route_code AS route_code, inferred_trip_code, ROUND(next_scheduled_stop_distance,5) AS nxt_sch_stop_dist, next_scheduled_stop_code
FROM raw_data raw1
WHERE
  raw_id = (SELECT min(raw2.next_scheduled_stop_distance) FROM raw_data raw2 WHERE inferred_route_code='MTABC_B100'
  AND vehicle_code=519
  AND inferred_direction_code = 0
  AND raw2.raw_id = raw1.raw_id
  ORDER BY time_received );

SELECT latitude, longitude, time_received, vehicle_code, ROUND(distance_along_trip,5) as dist_along_trip, inferred_direction_code AS direction, inferred_phase, inferred_route_code AS route_code, inferred_trip_code, ROUND(next_scheduled_stop_distance,5) AS nxt_sch_stop_dist, next_scheduled_stop_code FROM raw_data WHERE inferred_route_code='MTABC_B100' AND vehicle_code=519 AND inferred_direction_code = 0  GROUP BY next_scheduled_stop_code ORDER BY time_received;



SELECT raw_id, time_received, vehicle_code, ROUND(distance_along_trip,5) as dist_along_trip, inferred_direction_code AS direction, inferred_phase, inferred_route_code AS route_code, inferred_trip_code, ROUND(next_scheduled_stop_distance,5) AS nxt_sch_stop_dist, next_scheduled_stop_code, min(raw2.next_scheduled_stop_distance) AS min FROM raw_data raw2 WHERE inferred_route_code='MTABC_B100'   AND vehicle_code=519   AND inferred_direction_code = 0 AND time_received < '2014-08-01 19:17:35'  GROUP BY next_scheduled_stop_code ORDER BY time_received;



SELECT
  time_received,
  ROUND(distance_along_trip,5) AS dist_along_trip,
  ROUND(next_scheduled_stop_distance,5) AS nxt_sch_stop_dist,
  next_scheduled_stop_code,
  min(raw2.next_scheduled_stop_distance) AS min
FROM raw_data raw2
WHERE inferred_route_code='MTABC_B100'
  AND vehicle_code=519
  AND inferred_direction_code = 0
  AND time_received < '2014-08-01 19:17:35'
GROUP BY next_scheduled_stop_code
ORDER BY time_received;



SELECT
  concat(latitude, ', ', longitude) AS gps,
  -- time_received,
  -- ROUND(distance_along_trip,5) AS dist_along_trip,
  -- ROUND(next_scheduled_stop_distance,5) AS nxt_sch_stop_dist,
  -- next_scheduled_stop_code,
  min(raw2.next_scheduled_stop_distance) AS min
FROM raw_data raw2
WHERE inferred_route_code='MTABC_B100'
  AND vehicle_code=519
  AND inferred_direction_code = 0
  -- AND time_received < '2014-08-01 19:17:35'
GROUP BY next_scheduled_stop_code
ORDER BY time_received;
