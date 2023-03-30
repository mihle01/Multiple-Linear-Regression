libname HW5 "/home/u60739998/BS 805/Class 5";

filename one "/home/u60739998/BS 805/Class 5/dehydration_f22.xlsx";

proc import datafile=one
	out=temp_dehydration
	dbms=xlsx
	replace;
run;

/* visually check scatter */
proc sgplot data=temp_dehydration;
	scatter x=dose y=rehydration_score;
	title 'Scatterplot of Rehydration Score v. Dose';
run; title;
/* visually looks scatterd, no obvious problem points.
Run simple linear regression, and also plot residuals and predicted values from this regression. */

proc glm data=temp_dehydration;
	model rehydration_score=dose;
	output out=dehydration_resid p=rehydr_pred r=rehydr_resid student=rehydr_stand;
run;

/*plot residuals and predicted values to affirm presence of problem points.*/
proc sgplot data=dehydration_resid;
	scatter x=rehydr_pred y=rehydr_resid;
	title "Residuals v. Fitted Values";
run; title;

proc sgplot data=dehydration_resid;
	scatter x=rehydr_pred y=rehydr_stand;
	title "Standardized Residuals v. Fitted Values";
run; title;
/* seems like random scatter, no problem points. Keep all observations in. */
/* create permanent SAS dataset with all obs */
data HW5.dehydration;
	set temp_dehydration;
run;