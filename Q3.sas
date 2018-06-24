LIBNAME hw2 'C:\Users\sxp177631\Desktop\Homeworks\Home work 2\HW 2 Data';
data vite;
set hw2.vite;
run;
/* a) */
ODS RTF FILE='Threea)';
ODS GRAPHICS ON;
proc sort data=vite; 
by Strata;
run;
proc ttest data=vite(where = (Visit = 0)) H0=140;
 var SBP;
 by Strata;
 title 'T test results on Systolic blood pressure by Strata';
run;
ODS GRAPHICS OFF;
ODS RTF CLOSE;

/* For the paired Ttest to be done, there should be before and after
variables in the dataset to syntactically let SAS know that it is a
Paired T test, but here in our dataset we want to perform the paired 
T test on a variable called plaque measurement of differrent visits
which are recorded as observations, but not variables. Hence we need
to transform these observations as variables before we perform a paired
T test on before and after Plaque measurements*/

data  baseline;
set vite (where = (Visit = 0) keep = ID Visit Strata Treatment Plaque);
run;
data  secondyear;
set vite (where = (Visit = 2) keep = ID Visit Strata Treatment Plaque);
run;
proc sql;
create table combo as
select A.ID,A.Plaque as before,
B.Plaque as after,
A.Strata as stratabefore, B.Strata as strataafter,
A.Treatment as treabefore, B.Treatment as treaafter
from baseline A
inner join secondyear B
on A.ID = B.ID;
run;
proc sort data=combo; 
by treabefore stratabefore;
run;
ODS RTF FILE='Threec)';
ODS GRAPHICS ON;
proc ttest data=combo;
 paired before*after;
 by treabefore stratabefore;
 title 'Paired wise T test';
run;
ODS GRAPHICS OFF;
ODS RTF CLOSE;
/* Results: There are four parts in this analysis, considering the combinations of Treatment and Strata
1)	In the first part of the results, the p-value is less than 0.05 and 0 is not in the confidence interval. Hence for the Placebo group and Strata 1 category, the Null hypothesis is rejected, hence the mean difference between before and after 2 years Plaque levels is not 0.
2)	In the second part of the results, the p-value is greater than 0.05 and 0 is in the confidence interval. Hence for the Placebo group and Strata 2 category, the Null hypothesis is not rejected, hence the mean difference between before and after 2 years Plaque levels is 0.
3)	In the third part of the results, the p-value is less than 0.05 and 0 is not in the confidence interval. Hence for the Vitamin E group and Strata 1 category, the Null hypothesis is rejected, hence the mean difference between before and after 2 years Plaque levels is not 0.
4)	In the fourth part of the results, the p-value is greater than 0.05 and 0 is in the confidence interval. Hence for the Vitamin E group and Strata 2 category, the Null hypothesis is not rejected, hence the mean difference between before and after 2 years Plaque levels is 0.
 */
data combo;
set combo;
difference = after - before;
run;
proc sort data=combo; 
by stratabefore treabefore ;
run;
ODS RTF FILE='Threed)';
ODS GRAPHICS ON;
proc ttest data=combo;
 class treabefore;
 var difference;
 by stratabefore;
 title 'Independent sample T test';
run;
ODS GRAPHICS OFF;
ODS RTF CLOSE;
/* The results are documented in the file called ‘Threed)’. It has two parts in it.
1)	In 1st part, the test is done on the Strata 1 and in this case the test results are seen in the Statterthwaite row. This is because, in the F test we found that the two population will be having Unequal variances. Hence now, the p-value in statterthwaite is less than 0.05 which indicates that we can reject the Null Hypothesis and thus we can say that the change in mean of the Plaque levels after two years is different for Treatment and Placebo group in Strata 1.
2)	In 2nd part, the test is done on the Strata 2 and in this case the test results are seen in the Pooled row. This is because, in the F test we found that the two population will be having Equal variances. Hence now, the p-value in Pooled is greater than 0.05 which indicates that we fail to reject the Null Hypothesis and thus we can say that the change in mean of the Plaque levels after two years is same for Treatment and Placebo group in Strata 2.
 */


/* OPTIONAL */
proc univariate data = combo;
class treabefore; 
var difference;
QQPLOT difference /NORMAL(MU=EST SIGMA=EST COLOR=RED L=1); 
run;
