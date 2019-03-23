data dummyset;
input null;
cards;
;
run;

%macro header;
%let fullname = Kamal BabaeiSonbolabadi;
%let firstname = %scan(&fullname, 1);
%let lastname = %scan(&fullname, 2);
title1 "This Assignment was Completed by &firstname &lastname on &sysday, &sysdate at &systime";
run;
options nonumber nodate;
run;
proc print data = dummyset noobs;
run;
%mend;
%header
proc sql;
create table Lines as
select count(year) as Lines from 'C:\Users\Kamal\Desktop\AAASchool\475- SAS\Final\snowstationsdata.sas7bdat';
quit;
title2 ' ';
title3 'The Number of Lines Contained in the File';
proc print data = Lines noobs;
   run;
proc contents data = tmp1.snowstationsdata;
run;
proc sql;
create table stats as
select count(distinct STATIONID) as Stations
from 'C:\Users\Kamal\Desktop\AAASchool\475- SAS\Final\snowstationsdata.sas7bdat';
quit;
title4 "The Number of Different Snow Stations";
proc print data = stats noobs;
proc sql;
create table nyears as
select distinct STATIONNAME, (YEARRECORDENDS - YEARRECORDBEGAN) as Years
from 'C:\Users\Kamal\Desktop\AAASchool\475- SAS\Final\snowstationsdata.sas7bdat';
group by STATIONNAME;
quit;
title5 "The Number of Years per Station";
proc print data = nyears noobs;
run;     
proc sql;
create table ayears as
select distinct YEAR, count(distinct STATIONNAME) as Stations
from tmp1.snowstationsdata
group by YEAR;
quit;
title6 "Number Stations With Measurements Sorted by Year";
proc print data = ayears noobs;
run;

proc sql;
create table maxSWE as
select distinct STATIONNAME, max(MaxSWEinches) as Max_SWE
from tmp1.snowstationsdata
group by STATIONNAME;
quit;
title7 "The Highest SWE in Inches per Station";
proc print data = maxSWE noobs;
run;

proc sql;
update tmp1.snowstationsdata
set STATIONNAME = 'ADIN MOUNTAIN'
where STATIONNAME = 'ADIN MOUTAIN';
select *
from 'C:\Users\Kamal\Desktop\AAASchool\475- SAS\Final\snowstationsdata.sas7bdat'
quit;

proc sql;
create table regions as
select count(distinct REGION) as Regions
from tmp1.snowstationsdata
quit;
title8 "Number of Regions";
proc print data = regions noobs;
run;

proc sql;
create table rstations as
select distinct REGION, count(distinct STATIONNAME) as Stations_Per_Region
from tmp1.snowstationsdata
group by REGION;
quit;
title9 "Number of Stations per Region";
proc print data = rstations noobs;
run;
proc sql;
create table recent as
select STATIONID as STATION_ID, STATIONNAME as STATION_NAME, REGION, ELEVATIONINFEET as ELEVATION,
LATITUDE, LONGITUDE, max(MaxSWEinches) as TOTAL_MAX_SWE
from tmp1.snowstationsdata
where YEAR > 1962
group by YEAR;
quit;
title10 "Station Data for the Past 50 Years";
proc print data = recent noobs;
run;


