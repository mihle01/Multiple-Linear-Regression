libname HW5 "/home/u60739998/BS 805/Class 5";

data temp_dehydration2;
	set HW5.dehydration;
run;

/*first, check whether all associations we are finding corr for are generally linear*/
proc sgplot data=temp_dehydration2;
	scatter x=dose y=rehydration_score;
	title 'Scatterplot of Rehydration Score v. Dose';
run; title;
proc sgplot data=temp_dehydration2;
	scatter x=age y=rehydration_score;
	title 'Scatterplot of Rehydration Score v. Age';
run; title;
proc sgplot data=temp_dehydration2;
	scatter x=weight y=rehydration_score;
	title 'Scatterplot of Rehydration Score v. Weight';
run; title;
proc sgplot data=temp_dehydration2;
	scatter x=age y=weight;
	title 'Scatterplot of Weight v. Age';
run; title;
proc sgplot data=temp_dehydration2;
	scatter x=dose y=weight;
	title 'Scatterplot of Dose v. Weight';
run; title;
proc sgplot data=temp_dehydration2;
	scatter x=age y=dose;
	title 'Scatterplot of Age v. Dose';
run; title;

/* correlations between all 4 variables */
proc corr data=temp_dehydration2;
	var dose age weight;
	with rehydration_score;
run;

proc corr data=temp_dehydration2;
	var dose age;
	with weight;
run;

proc corr data=temp_dehydration2;
	var dose;
	with age;
run;

/* simple linear regression */
proc reg data=temp_dehydration2;
	model rehydration_score=dose / clb;
run;

/* mulitiple linear regression */
proc reg data=temp_dehydration2;
	model rehydration_score=dose age weight / clb stb scorr2;
run;
*stb=standardized slopes, scorr2=squared semipartial (aka standardized) correlation;

/* looking for significant interaction */
proc glm data=temp_dehydration2;
	model rehydration_score=dose age dose*age;
run;

proc glm data=temp_dehydration2;
	model rehydration_score=dose weight dose*weight;
run;