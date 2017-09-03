### Question 1 How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?
Select count(*) from planes where speed is not NULL union Select count(*) from planes;

## Question 2 What is the total distance flown by all of the planes in January 2013? What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?
Select sum(distance) from flights where year = 2013 and month = 1;
select sum(distance) from flights where year = 2013 and month = 1 and tailnum is null;

#### Question 3 What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?
Select p.manufacturer as 'Manufacturer', sum(f.distance) as 'Distance Sum' from flights as f 
inner join planes as p 
on f.tailnum=p.tailnum
where f.month = 7 and day = 5
group by p.manufacturer 
order by p.manufacturer;

Select p.manufacturer as 'Manufacturer', sum(f.distance) as 'Distance Sum' from flights as f 
left outer join planes as p 
on f.tailnum=p.tailnum
where f.month = 7 and day = 5
group by p.manufacturer 
order by p.manufacturer;


### Question 4
## In Jan 2013, how many flights has been taken off group by Airport.
Select count(f.flight) as 'No of Flights', ap.faa as 'Airport', ap.name as 'Airtport Name' from flights as f 
inner join airlines as a 
on f.carrier=a.carrier 
inner join airports as ap on f.origin= ap.faa
where a.carrier="UA" group by ap.faa;

# Answer  Here sum of flight comes from flight table and sort only United Airlines flight using carrier table and group by airport using airport table.
 
## PART 2 Create View to export data to use for tableau
CREATE VIEW `tableau_data` AS Select 
f.year as 'Year', 
f.month as 'Month', 
f.day as 'Day', 
f.dep_time as 'dep_time', 
f.dep_delay as 'dep_delay', 
f.arr_time as 'arr_time', 
f.arr_delay as 'arr_delay', 
f.carrier as 'carrier', 
f.tailnum as 'tailnum', 
f.origin as 'origin', 
f.dest as 'dest', 
f.air_time as 'air_time', 
f.distance as 'distance', 
f.hour as 'hour', 
f.minute as 'minute', 
a.name as 'Airline Names', 
ap.lat as 'lat', 
ap.lon as 'lon', 
ap.alt as 'alt', 
ap.tz as 'time zone' 
from flights as f 
inner join airlines as a 
on f.carrier=a.carrier 
inner join airports as ap on f.origin= ap.faa;

Select * from tableau_data 
into outfile 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/tableau_data.csv'
fields terminated by ',' 
optionally enclosed by '"'
escaped by '\\'
lines terminated by '\n';
