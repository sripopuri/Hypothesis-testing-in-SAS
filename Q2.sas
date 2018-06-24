LIBNAME hw2 'C:\Users\sxp177631\Desktop\Homeworks\Home work 2\HW 2 Data';
data studygpa;
set hw2.study_gpa;
run;
/* Box Plots */
proc sgplot data= studygpa;
 hbox AveTime / category= Section; 
 title 'Avg Times per Section';
 yaxis label = 'Section';
run;
/* Regression between AvgTime and GPA */
proc sgplot data=studygpa noautolegend;
   title "Regression between AvgTime and GPA";
   reg y=GPA x=AveTime / lineattrs=(color=red thickness=2);
run;
proc sgplot data=studygpa ;
   title "Regression between AvgTime and GPA";
   reg y=GPA x=AveTime / CLM CLMTRANSPARENCY = 0.75 group = Section lineattrs=(thickness=2);
   keylegend  / position = bottomright location = outside;
run;
proc sgpanel data=studygpa;
  panelby Section;
  reg x=Avetime y=GPA / CLM CLMTRANSPARENCY = 0.65 lineattrs=(color = red thickness=2);
  keylegend /position = bottom;
run;
/* From the boxplot it is evident that the Avergae time spent by the students 
in section 1 is more than that of the section 2.

But in section 1 there is negative relationship between Time spent and GPA
This is clearly seen in the regression plot for the section 1 students.

Where as in section 2, there is a postive relationship between Time spent 
and GPA. This is visible in the regression plot for the section 2 students.

When we observe the relation between Time spent and the GPA of the students 
for both the sections combined, then it seems like there is no relation between
the variables. Hence viewing the relationship at section level granularity will help. */
