-- '''VALIDATING MY PROCESS'''
-- 1)
-- I started by picking an arbitrary route that might still be in service today. This is a bit of a gamble since in my experience riding public transit, some stops are added or removed from routes but the route name stay the same.


-- 2) Pick a Guinea Pig Route
-- I chose B100
SET @busRoute := 'MTABC_B100';


-- 3)
-- I then went looking for vehicles who have performed this route
SELECT distinct(vehicle_code), inferred_route_code
FROM raw_data
WHERE inferred_route_code = @busRoute
ORDER BY vehicle_code;


-- 4) Pick a Guinea Pig Bus
-- At random I picked number 519
SET @busId := '519';


-- 5) Data is Coming Together
-- Now comes the fun stuff. I started looking at the data for the given route and bus.
SELECT latitude, longitude, time_received, vehicle_code, ROUND(distance_along_trip,5) as dist_along_trip, inferred_direction_code AS direction, inferred_phase, inferred_route_code AS route_code, inferred_trip_code, ROUND(next_scheduled_stop_distance,5) AS nxt_sch_stop_dist, next_scheduled_stop_code
FROM raw_data
WHERE inferred_route_code = @busRoute
AND vehicle_code = @busId
ORDER BY time_received;

-- Observations
-- A) The same bus seems to travel the same route the whole day; when the bus gets to the end of the line it turns around and follows the same route back. One can assume that this won't always be the case.
-- B) When the bus reaches the end of the line, and takes the same route in reverse the direction bit is flipped: direction=0 -> direction=1
-- C) I have the data sorted by date_received which I am loosely associating it with a date_stamp of when the data point was gathered.
-- D) I see that I can more or less follow the route stop by looking at next_scheduled_stop_code.

-- 6) What is Need Now?
-- I need to start building the bus route and bus schedual data:
-- A) Where are the "benches" makeup the route
-- B) What times are the busses expected to be at any given bench
-- For now I am only going to focus on the direction = 0
-- Since there is no "I have arrived at a stop" signal in the data logging, I am going to look at the nxt_sch_stop_dist and find the shortest distance for each of the next_scheduled_stop_code.
-- I am going to use the data for the first trip of the day. If you look at the following, you will see where direcrion flips:

-- | latitude  | longitude  | time_received       | distAlngTrp | direction  | inferred_trip_code                   | nxt_sch_stop_dist | next_scheduled_stop_code |
-- +-----------+------------+---------------------+-------------+------------+--------------------------------------+-------------------+--------------------------+
-- | 40.608813 |  -73.91388 | 2014-08-01 19:16:00 |  7202.52215 |          0 | MTABC_6437370-SCPC4-SC_C4-Weekday-20 |         244.19515 | MTA_350019               |
-- | 40.608744 |  -73.91378 | 2014-08-01 19:16:31 |  7220.83679 |          0 | MTABC_6437370-SCPC4-SC_C4-Weekday-20 |           6.10488 | MTA_350019               |
-- | 40.608744 |  -73.91378 | 2014-08-01 19:17:03 |  7214.73191 |          0 | MTABC_6437370-SCPC4-SC_C4-Weekday-20 |          12.20976 | MTA_350019               | <--(look here)
-- | 40.607911 | -73.912865 | 2014-08-01 19:17:35 |   115.97416 |          1 | MTABC_6437492-SCPC4-SC_C4-Weekday-20 |           0.00000 | MTA_350017               |
-- | 40.606963 | -73.911814 | 2014-08-01 19:18:06 |   252.94330 |          1 | MTABC_6437492-SCPC4-SC_C4-Weekday-20 |         101.23806 | MTA_350018               |
-- | 40.606181 | -73.910759 | 2014-08-01 19:18:38 |   372.15727 |          1 | MTABC_6437492-SCPC4-SC_C4-Weekday-20 |         191.74312 | MTA_350090               |

-- I will use the date time stamp + 1 second to limit the results.


-- 7) Limit the date time
-- I picked 2014-08-01 19:17:04

SET @dateTimeLimit := '2014-08-01 19:17:03';

SELECT DISTINCT(next_scheduled_stop_code)
FROM raw_data
WHERE inferred_route_code = @busRoute
AND vehicle_code = @busId
AND time_received < @dateTimeLimit
ORDER BY time_received;
