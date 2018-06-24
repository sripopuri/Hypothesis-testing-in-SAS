proc sql;

select count(*) from vite
where Strata =2 and Plaque < 0.60;
run;
select max(ID) from vite;
select count(*) from vite
group by Treatment;

select count(*) from vite;

select min(ID),max(ID),count(*),Strata, Treatment from vite
where Visit = 2
group by Strata, Treatment;

proc sql;
select sum(stratabefore - strataafter),
sum(treabefore - treaafter)
from combo;
run;
proc sql;
select count(*) from (
select stratabefore - strataafter as diff1,
treabefore - treaafter as diff2
from combo)
where diff1 <0 or diff2 <0;
run;
