LIBNAME hw2 'C:\Users\sxp177631\Desktop\Homeworks\Home work 2\HW 2 Data';
data earthquakes;
set hw2.earthquakes;
run;
proc sort data= earthquakes; 
 by Year;
run;
/* Creating a dataset with the means of magnitude for every year*/
proc means data= earthquakes mean maxdec= 2 noprint;
 by Year;
 var Magnitude;
 output out=yearmeans
  mean= Avgmagnitude;
run;
/* Combining two sets for overlaying plots */
proc sql ;
create table yearmag as 
select A.Year,A.Magnitude, 
B.Avgmagnitude as Avg from 
earthquakes A 
inner join  yearmeans B
on A.Year = B.Year;
run;
/* Scatter Plot and Series plot overlay*/
proc sgplot data = yearmag(where = (Year >= 2000)) ;
 scatter X=Year Y=Magnitude / name = "A"; 
 series x=Year y=Avg / name = "B" LEGENDLABEL = "Mean" LINEATTRS = (COLOR = red);
 keylegend "B" / noborder position = bottomright location = outside;
 refline 4 / label = "Light" LINEATTRS = (PATTERN = MediumDash) TRANSPARENCY = 0.5;
 refline 5 / label = "Moderate" LINEATTRS = (PATTERN = MediumDash) TRANSPARENCY = 0.5;
 refline 6 / label = "Strong" LINEATTRS = (PATTERN = MediumDash) TRANSPARENCY = 0.5;
 refline 7 / label = "Major" LINEATTRS = (PATTERN = MediumDash) TRANSPARENCY = 0.5;
 refline 8 / label = "Great" LINEATTRS = (PATTERN = MediumDash) TRANSPARENCY = 0.5;
 title 'Earthquakes Yearly Magnitude';
 label Magnitude= 'Magnitude' Year = 'Year'; 
 XAXIS VALUES = (2000 to 2011 by 1);
run;
