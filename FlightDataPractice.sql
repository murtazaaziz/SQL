Use FlightDelays_DB

/* Total number of flights */

SELECT 
	COUNT(Flight_Number) AS FlightCount
FROM flightsTable

/* Number of flights delayed */

SELECT 
	COUNT(Flight_Number) AS FlightsDelayed
FROM flightsTable
WHERE DEPARTURE_DELAY > 0 

/* Number of flights on time*/

SELECT 
	COUNT(Flight_Number) AS FlightsOnTime
FROM flightsTable
WHERE DEPARTURE_DELAY = 0

/* Using a CTE and JOIN to query the airline with the most delays and percentage of total delay count */
WITH delay_total AS(
	SELECT 
		dimairlines.AIRLINE as airline
		,Flight_Number
	FROM flightsTable
		INNER JOIN dimairlines on dimairlines.IATA_CODE = flightsTable.AIRLINE
	WHERE DEPARTURE_DELAY > 0 )

SELECT 
	airline
	,COUNT(FLIGHT_NUMBER) AS DelayFlightCount
	,FORMAT(COUNT(FLIGHT_NUMBER), '#,###,###') AS DelayFlightCountFormatted
	,FORMAT((COUNT(FLIGHT_NUMBER)/2125618.0), 'P2') AS PercentTotalDelaysByAirline
FROM delay_total
GROUP BY airline
ORDER BY DelayFlightCount DESC

/* Flight delays grouped by day of week where 1 = Monday and 7 = Sunday */

WITH day_total AS(
	SELECT 
		FLIGHT_NUMBER
		,DAY_OF_WEEK
	FROM flightsTable
	WHERE DEPARTURE_DELAY > 0 )

SELECT 
	CASE WHEN DAY_OF_WEEK = '1' then 'Monday'
		WHEN DAY_OF_WEEK = '2' then 'Tuesday'
		WHEN DAY_OF_WEEK = '3' then 'Wednesday'
		WHEN DAY_OF_WEEK = '4' then 'Thursday'
		WHEN DAY_OF_WEEK = '5' then 'Friday'
		WHEN DAY_OF_WEEK = '6' then 'Saturday'
		WHEN DAY_OF_WEEK = '7' then 'Sunday'
		Else null End AS 'DayofWeek'
	,FORMAT(COUNT(FLIGHT_NUMBER), '#,###,###') AS DelayFlightCountFormatted
	,FORMAT((COUNT(FLIGHT_NUMBER)/2125618.0), 'P2') AS PercentTotalDelaysByWeekday
FROM day_total
GROUP BY DAY_OF_WEEK 
ORDER BY 2 DESC
