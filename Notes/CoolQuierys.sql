-- https://www.google.com/maps/place/40%C2%B039'58.5%22N+73%C2%B059'19.5%22W/@40.6661846,-73.988637,21z/data=!4m2!3m1!1s0x0:0x0!5m1!1e2

-- This selects the vehicle_code(s) given inferred_route_code
--
SELECT distinct(vehicle_code), inferred_route_code
FROM raw_data
WHERE inferred_route_code like '%B100'
ORDER BY vehicle_code;


-- This represents the day in the life of a a single vehicle_code
-- For a given inferred_route_code
SELECT latitude, longitude, time_received, vehicle_code, distance_along_trip, inferred_direction_code AS direction, inferred_phase, inferred_route_code AS route_code, inferred_trip_code, next_scheduled_stop_distance, next_scheduled_stop_code
FROM raw_data
WHERE inferred_route_code='MTABC_B100'
AND vehicle_code=519
ORDER BY time_received;


-- This returns next_scheduled_stop_code in stopping order for the given inferred_route_code
-- for a given vehicle_code
-- before the vehicle goes on it's return trip
SELECT DISTINCT(next_scheduled_stop_code)
FROM raw_data
WHERE inferred_route_code='MTABC_B100'
AND vehicle_code = 519
AND time_received < '2014-08-01 19:17:35'
ORDER BY time_received;


--
SELECT latitude, longitude, time_received, vehicle_code, ROUND(distance_along_trip,5) as dist_along_trip, inferred_direction_code AS direction, inferred_phase, inferred_route_code AS route_code, inferred_trip_code, ROUND(next_scheduled_stop_distance,5) AS nxt_sch_stop_dist, next_scheduled_stop_code
FROM raw_data
WHERE inferred_route_code='MTABC_B100'
AND vehicle_code=519
AND inferred_direction_code = 0
ORDER BY time_received;


-- good example, select from one table insert into another
INSERT INTO bench (bench_code)
SELECT DISTINCT(next_scheduled_stop_code)
FROM raw_data;
