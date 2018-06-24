LIBNAME hw2 'C:\Users\sxp177631\Desktop\Homeworks\Home work 2\HW 2 Data';
data lefties;
set hw2.lefties;
run;
ODS RTF FILE='Fourabc';
ODS GRAPHICS ON;
/* a) Chi squared test on Hand and Foot variables*/
proc freq data=lefties;
 tables Hand * Foot/ChiSq plots=(freqplot(twoway=groupvertical scale=percent));
 title 'Chi-Squared test between Hand and Foot';
run;
/* Result: Both Hand and Foot variables are Independent 
Failed to reject Null Hypothesis*/

/* b) Chi squared test on Hand and Mouse variables*/
proc freq data=lefties;
 tables Hand * Mouse/ChiSq plots=(freqplot(twoway=groupvertical scale=percent));
 title 'Chi-Squared test between Hand and Mouse';
run;
/* Result: Both Hand and Mouse variables are related, Null Hypothesis is rejected
When there is warning displayed we look at the Fisher's result, H0 is rejected.*/

/* c) Chi squared test on Hand and Gender variables*/
proc freq data=lefties;
 tables Hand * Gender/ChiSq plots=(freqplot(twoway=groupvertical scale=percent));
 title 'Chi-Squared test between Hand and Gender';
run;
ODS GRAPHICS OFF;
ODS RTF CLOSE;
/* Result: Both Hand and Gender variables are Independent 
Failed to reject Null Hypothesis*/
