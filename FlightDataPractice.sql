Use FlightDelays_DB

Select * From dimairlines
Select * from dimairports

Select count(Flight_Number) as totalnumberofFlights
from flightsTable
where DAY_OF_WEEK in ('4','5')
Having Count(DEPARTURE_DELAY)> 0 

Select 
	dimairlines.AIRLINE
	,Case When DAY_OF_WEEK = '4' then 'Thursday'
		When DAY_OF_WEEK = '5' then 'Friday'
		Else null End as 'DayofWeek'
	,count(FLIGHT_NUMBER) as FlightCount
	,Format(count(FLIGHT_NUMBER), '#,###,###') as FlightCountFormatted
from flightsTable
INNER JOIN dimairlines
	on dimairlines.IATA_CODE = flightsTable.AIRLINE
where DAY_OF_WEEK in ('4','5')
Group by dimairlines.AIRLINE, DAY_OF_WEEK
Having Count(DEPARTURE_DELAY)> 0
Order by DAY_OF_WEEK ASC, FlightCount DESC

Select 
	dimairlines.AIRLINE
	,count(FLIGHT_NUMBER) as FlightCount
	,Format(count(FLIGHT_NUMBER), '#,###,###') as FlightCountFormatted
from flightsTable
INNER JOIN dimairlines
	on dimairlines.IATA_CODE = flightsTable.AIRLINE
Group by dimairlines.AIRLINE
Having Count(DEPARTURE_DELAY)> 0
Order by FlightCount DESC

