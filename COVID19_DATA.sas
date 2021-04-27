/*************************************************************************
*** Program Name : COVID19_DATA.sas
*** Author       : Fatima Rawoof
*** Date         : 26-Apr-2021
*** Purpose      : Analyze real COVID19 data extract from CDC website
***                Usage of Bar Chart, Pie Chart and Donut Chart to represent the data visually.
****************************************************************************/

libname new xlsx '/home/u55504607/fdata/covid19data.xlsx';



data aa (drop= eth race1);
    set new.covid19 (rename=(cdc_report_dt=date race_ethnicity_combined=race1 death_yn=deathcases)) ;
    length race $40;
    Ethnicity=scan(race1,-1,',');
    eth=find(race1,',',1);
    length ethnicity $40;
    if eth>0 then race=scan(race1,-2,',');
    else race='Unknown';
    format date date9.;
run;

proc print data=aa;
run;

Title 'No of Cases Reported Over Time';
proc gchart data=aa;
vbar date/discrete freq;
run;
quit;

Title 'Age Distribution';
proc gchart data=aa;
pie age_group/discrete value=inside ;
run;
quit;

Title 'Race Distribution';
proc gchart data=aa;
donut race;
run;
quit;


Title 'Age Category Vs Sex';
proc gchart data=aa;
vbar age_group/discrete subgroup=sex;
run;
quit;



proc format;
value $ fmt
'American Indian/Alaska Native'='American Indian'
'Multiple/Other'='Other'
'Native Hawaiian/Other Pacific Islander'='Hawaiian'
;
run;


Title 'DeathCases Vs. Race';

proc gchart data=aa;
vbar race/ subgroup=deathcases freq;
format race $fmt.;
run;
quit;


Title 'DeathCases Vs. Ethnicity';
proc gchart data=aa;
vbar ethnicity/subgroup=deathcases freq;
run;
quit;

