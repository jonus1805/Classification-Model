/******** Importig Data *********/

filename tobac "G:\@ Stevens\@ BIA 652- Multivariate\Project\2014\Code for 2014.csv";

data tobacco;
infile tobac delimiter=',' DSD;
input year
SchoolID $
StudntID
psu
psu2
stratum $
stratum2
wt
qn1
qn2
qn3
qn4a
qn4b
qn4c
qn4d
qn4e
qn5a
qn5b
qn5c
qn5d
qn5e
qn6
qn7
qn8
qn9
qn10
qn11
qn12
qn13
qn14
qn15
qn16
qn17
qn18
qn19
qn20
qn21
qn22
qn23
qn24
qn25
qn26
qn27
qn28
qn29
qn30
qn31
qn32
qn33
qn34
qn35
qn36a
qn36b
qn36c
qn36d
qn36e
qn36f
qn37a
qn37b
qn37c
qn37d
qn37e
qn37f
qn38a
qn38b
qn38c
qn38d
qn38e
qn38f
qn38g
qn38h
qn39
qn40a
qn40b
qn40c
qn40d
qn40e
qn40f
qn40g
qn40h
qn41a
qn41b
qn41c
qn41d
qn41e
qn41f
qn41g
qn41h
qn42
qn43
qn44
qn45
qn46
qn47
qn48
qn49
qn50
qn51
qn52
qn53
qn54
qn55
qn56
qn57
qn58
qn59
qn60
qn61
qn62
qn63
qn64
qn65
qn66
qn67
qn68
qn69
qn70
qn71
qn72
qn73
qn74
qn75
qn76
qn77
qn78
qn79
qn80a
qn80b
qn80c
qn80d
qn80e
qn80f
qn80g
qn80h
qn80i
qn80j
qn81
race_m
race_s
ecigt_r
ecigar_r
eslt_r
epipe_r
ebidis_r
ehookah_r
esnus_r
edissolv_r
eelcigt_r
ccigt_r
ccigar_r
cslt_r
cpipe_r
cbidis_r
chookah_r
csnus_r
cdissolv_r
celcigt_r;
run;

/************************Cleaning variable 4***********************************/
data toba2;
set tobacco;
qn4=sum(qn4a,qn4b,qn4c,qn4d,qn4e);
proc sort data=toba2;
by descending qn4 ;
run;

/*Seems like people have entered yes for all 5 also, so eliminating 2,3,4,5 which are duplicates*/
data toba2;
set toba2;
if qn4 >1 then delete;
run;

data tobacco1; set toba2;
if qn4b=1 then qn4=2;
else if qn4a=1 then qn4=1; 
else if qn4c=1 then qn4=3;
else if qn4d=1 then qn4=4;
else if qn4e=1 then qn4=5;
run;

data tobacco1 (DROP = qn4a qn4b qn4c qn4d qn4e);
set tobacco1;
run;

/************************Cleaning variable 5**********************************/
data toba3;
set tobacco1;
qn5=sum(qn5a,qn5b,qn5c,qn5d,qn5e);
run;

proc sort data=toba4;
by descending qn5 ;
run;

/*People have entered yes for all 5 also, so eliminating 2,3,4,5 which are duplicates*/
data toba3;
set toba3;
if qn5 >1 then delete;
run;

data tobacco2; set toba3;
if qn5b=1 then qn5=2;
else if qn5a=1 then qn5=1; 
else if qn5c=1 then qn5=3;
else if qn5d=1 then qn5=4;
else if qn5e=1 then qn5=5;
run;

data tobacco2 (DROP = qn5a qn5b qn5c qn5d qn5e);
set tobacco2;
run;

/*********************Cleaning 37,38,40,41 as these are not needed variables************************/

data tobacco3 (drop= qn37a
qn37b
qn37c
qn37d
qn37e
qn37f
qn38a
qn38b
qn38c
qn38d
qn38e
qn38f
qn38g
qn38h
qn40a
qn40b
qn40c
qn40d
qn40e
qn40f
qn40g
qn40h
qn41a
qn41b
qn41c
qn41d
qn41e
qn41f
qn41g
qn41h);
set tobacco2;run;


/************************Cleaning 36 from 6 variables to 1 ***************************/

data toba4;
set tobacco3;
qn36=sum(qn36a,qn36b,qn36c,qn36d,qn36e,qn36f);
proc sort data=toba4;
by descending qn36;
run;

data toba4;
set toba4;
if (qn36>1 and qn36f=1) then delete;
else if qn36f=1 then qn36=1; *No tobacco used;
else if qn36=1 then qn36=2; *Used one tobacco product;
else if qn36>1 then qn36=3; *Used more than one;
run;

data toba4 (drop=qn36a qn36b qn36c qn36d qn36e qn36f);
set toba4;
run;

/************************Cleaning 80 from 10 variables to one varibale with 2 levels***************************/
data toba5;
set toba4;
qn80=sum(qn80a,qn80b,qn80c,qn80d,qn80e,qn80f,qn80g,qn80h,qn80i,qn80j);
proc sort data=toba5;
by descending qn80;
run;

data toba5;
set toba5;
if (qn80>1 and qn80j=1) then delete;
else if qn80j=1 then qn80=1;
else if qn80>1 then qn80=2;
run;


/***************Cleaning RECODE and 80 as Recode is not needed for our objective*************/

DATA TOBARECODE(drop =year qn80a qn80b qn80c qn80d qn80e qn80f qn80g qn80h qn80i qn80j
SchoolID StudntID psu psu2 stratum  stratum2 wt race_m race_s ecigt_r ecigar_r eslt_r epipe_r ebidis_r ehookah_r esnus_r
edissolv_r eelcigt_r ccigt_r ccigar_r cslt_r  cpipe_r cbidis_r chookah_r csnus_r cdissolv_r celcigt_r); 
SET toba5;
run;

/**********************************  Deleting Missing value with high number  *********************************************/

proc means data=tobacco4 nmiss n;
run;

data tobacco4;
set tobarecode;
if (qn80="."  or qn5=".") then delete;
run;

/*********************** Cleaning qn6 which is our objective variable **************/
*Created a duplicate column for QN6 as backup and we are deleting it again;
data tobacco4;
set tobacco4;
qn6a=qn6;
run;

data tobacco5;
set tobacco4;
if qn6=4 then qn6=0;
else qn6=1;run;

/************* We are deleting null values as either giving mode or mean in those variables will deviate our aim*******/
data tobacco5;
set tobacco5;
if qn6a="." then delete;
run;

proc sort data=tobacco5;
by descending qn6a;
run;

data tobacco5 (drop=qn6a);
set tobacco5; run;


/*************************   Dividing it into Training and Test   ***********************************/

data temp;
set tobacco5;
n=ranuni(8);
proc sort data=temp;
  by n;
  data training testing;
   set temp nobs=nobs;
   if _n_<=.7*nobs then output training;
    else output testing;
   run;



/***************************************************************************
***************************************************************************
************************          MODELLING PART       ********************
***************************************************************************
****************************************************************************/


/*************************   VIF   ***********************************/

proc reg data =training;
model qn6= qn1	qn2	qn3		qn7	qn8	qn9	qn10	qn11	qn12	qn13	qn14	qn15	qn16	
qn17	qn18	qn19	qn20	qn21	qn22	qn23	qn24	qn25	qn26	qn27	qn28	
qn29	qn30	qn31	qn32	qn33	qn34	qn35	qn39	qn42	qn43	qn44	qn45	
qn46	qn47	qn48	qn49	qn50	qn51	qn52	qn53	qn54	qn55	qn56	qn57	
qn58	qn59	qn60	qn61	qn62	qn63	qn64	qn65	qn66	qn67	qn68	qn69	
qn70	qn71	qn72	qn73	qn74	qn75	qn76	qn77	qn78	qn79	qn81	qn4	qn5	
qn36	qn80/vif;run;



/*************************   Logistic STEP-WISE  with the values with VIF < 6 ***********************************/


proc logistic data =training;
class 	qn2	qn6 qn8	qn9	qn10	qn11	qn12		
qn20	qn26	qn30	qn32	qn33	qn39	qn43					
qn46	qn47	qn48	qn49	qn50	qn51 qn52	qn53	qn54	qn55	qn56		
qn58	qn59	qn60	qn61	qn62	qn63 qn64	qn65	qn66	qn67	qn68	qn69	
qn70	qn71	qn72	qn73	qn74	qn75 qn76	qn77	qn78	qn79	qn81	qn4	qn5
qn36	qn80;
model qn6= 	qn2	 qn8	qn9	qn10	qn11	qn12		
qn20	qn26	qn30	qn32	qn33	qn39	qn43					
qn46	qn47	qn48	qn49	qn50	qn51 qn52	qn53	qn54	qn55	qn56		
qn58	qn59	qn60	qn61	qn62	qn63 qn64	qn65	qn66	qn67	qn68	qn69	
qn70	qn71	qn72	qn73	qn74	qn75 qn76	qn77	qn78	qn79	qn81	qn4	qn5
qn36	qn80/selection=stepwise slentry=0.05 slstay=0.05 ;

/************************* New table with significant variables ***********************************/

data s_Train(drop = qn1 	qn2	qn3	qn7	qn8	qn9	qn10	qn11	qn12	qn15		
qn20	qn26	qn27	qn28  qn30	qn31	qn32	qn33	qn34 	qn39	qn43					
qn46	qn47	qn48	qn49	qn50	qn51  qn52	qn53	qn54	qn55	qn56		
qn58	qn59	qn60	qn61	qn62	qn63  qn64	qn65	qn66	qn67	qn68	qn69	
qn70	qn71	qn72	qn73	qn74	qn75  qn76	qn77	qn78	qn79	qn81	qn4	qn5
qn36	qn80);
set training;
if qn39= 1 then qn39_1 = 1; else qn39_1 = 0;
if qn22= 2 then qn22_2 = 1; else qn22_2 = 0;
if qn10= 2 then qn10_2 = 1; else qn10_2 = 0;
if qn19= 1 then qn19_1 = 1; else qn19_1 = 0;
if qn19= 2 then qn19_2 = 1; else qn19_2 = 0;
if qn30= 1 then qn30_1 = 1; else qn30_1 = 0;
if qn30= 2 then qn30_2 = 1; else qn30_2 = 0;
if qn39= 2 then qn39_2 = 1; else qn39_2 = 0;
if qn59= 3 then qn59_3 = 1; else qn59_3 = 0;
if qn32= 2 then qn32_2 = 1; else qn32_2 = 0;
if qn35= 4 then qn35_4 = 1; else qn35_4 = 0;
if qn72= 3 then qn72_3 = 1; else qn72_3 = 0;
if qn54= 1 then qn54_1 = 1; else qn54_1 = 0;
if qn22= 1 then qn22_1 = 1; else qn22_1 = 0;
if qn72= 2 then qn72_2 = 1; else qn72_2 = 0;
if qn2= 1 then qn2_1 = 1; else qn2_1 = 0;
if qn9= 2 then qn9_2 = 1; else qn9_2 = 0;
if qn39= 4 then qn39_4 = 1; else qn39_4 = 0;
if qn5= 3 then qn5_3 = 1; else qn5_3 = 0;
if qn74= 3 then qn74_3 = 1; else qn74_3 = 0;
if qn5= 2 then qn5_2 = 1; else qn5_2 = 0;
if qn81= 3 then qn81_3 = 1; else qn81_3 = 0;
if qn46= 3 then qn46_3 = 1; else qn46_3 = 0;run;


/******************************STEPWISE after creating Dummy Variables with ROC plot ***************************/

ods graphics on;
proc logistic data=s_train descending plots=roc;
class qn6 qn39_1 (ref='0') qn10_2 (ref='0') qn19_1 (ref='0') qn19_2 (ref='0') qn30_1 (ref='0') qn30_2 (ref='0')
qn39_2 (ref='0') qn59_3 (ref='0') qn32_2 (ref='0') qn35_4 (ref='0') qn72_3 (ref='0')
qn72_2 (ref='0') qn2_1 (ref='0') qn9_2 (ref='0') qn5_3 (ref='0') qn74_3 (ref='0') qn5_2 (ref='0') 
qn81_3 (ref='0')/param=ref;
model qn6=qn39_1 qn22_2 qn10_2 qn19_1 qn19_2 qn30_1 qn30_2 qn39_2 qn59_3 qn32_2 qn35_4 qn72_3  
qn72_2 qn2_1 qn9_2
qn5_3 qn74_3 qn5_2 qn81_3 /selection=stepwise;
run;

/************************Validating Against Test Dataset ******************/

data tobFinscore;
set testing;
SCORE=(-1.5757+(1.776 * qn39_1)+(-0.3667 * qn22_2)+(2.1918 * qn10_2)+(1.5913 * qn19_1)+
(1.3987 * qn19_2)+(1.5102 * qn30_1)+(1.4284 * qn30_2)+(-0.3573 * qn39_2)+(0.1169 * qn59_3)+
(-1.0847 * qn35_4)+(0.3148 * qn72_3)+(0.3335 * qn72_2)+(-0.1224 * qn2_1)+(1.6434 * qn9_2)+
(-0.2582 * qn5_3)+(1.0935 * qn74_3)+(0.2242 * qn5_2)+(0.6642 * qn81_3));
P_RESPONSE=exp(SCORE)/(1+exp(SCORE));
RUN;

/************************  Ranking the dataset P_RESPONSE  ******************/

proc rank data=tobFinscore out=out2 descending groups=10;
var p_response;
ranks p_response;
proc sort data=out2;
by descending p_response;
run;


/***************************************************************************
***************************************************************************
************************          UPDATED VERSION       ********************
***************************************************************************
****************************************************************************/

data s_Train1(drop = qn1 	qn2	qn3	qn7	qn8	qn9	qn10	qn11	qn12	qn15		
qn20	qn26	qn27	qn28  qn30	qn31	qn32	qn33	qn34 	qn39	qn43					
qn46	qn47	qn48	qn49	qn50	qn51  qn52	qn53	qn54	qn55	qn56		
qn58	qn59	qn60	qn61	qn62	qn63  qn64	qn65	qn66	qn67	qn68	qn69	
qn70	qn71	qn72	qn73	qn74	qn75  qn76	qn77	qn78	qn79	qn81	qn4	qn5
qn36	qn80);
set s_training;
if qn39= 1 then qn39_1_2 = 1; else if qn39=2 then qn39_1_2=2;   else qn39_1_2 = 0;
if qn22= 1 then qn22_1_2 = 1; else if qn22=1 then qn22_1_2=2;else qn22_1_2 = 0;
if qn10= 2 then qn10_2 = 1; else qn10_2 = 0;
if qn19= 1 then qn19_1_2 = 1;else if qn19=2 then qn19_1_2=2;else qn19_1_2 = 0;
if qn30= 1 then qn30_1_2 = 1;else if qn30=2 then qn30_1_2=2; else qn30_1_2 = 0;
if qn59= 3 then qn59_3 = 1; else qn59_3 = 0;
if qn32= 2 then qn32_2 = 1; else qn32_2 = 0;
if qn35= 4 then qn35_4 = 1; else qn35_4 = 0;
if qn72= 3 then qn72_3 = 1; else qn72_3 = 0;
if qn54= 1 then qn54_1 = 1; else qn54_1 = 0;
if qn72= 2 then qn72_2 = 1; else qn72_2 = 0;
if qn2= 1 then qn2_1 = 1; else qn2_1 = 0;
if qn9= 2 then qn9_2 = 1; else qn9_2 = 0;
if qn5= 3 then qn5_3 = 1; else qn5_3 = 0;
if qn74= 3 then qn74_3 = 1; else qn74_3 = 0;
if qn5= 2 then qn5_2 = 1; else qn5_2 = 0;
if qn81= 3 then qn81_3 = 1; else qn81_3 = 0;
if qn46= 3 then qn46_3 = 1; else qn46_3 = 0;run;

/******************* STEPWISE after creating Dummy Variables for updated version with ROC plot ************/

ods graphics on;
proc logistic data=s_Train1 descending plots=roc;
class qn6 qn39_1_2 (ref='0') qn22_1_2 (ref='0') qn10_2 (ref='0') qn19_1_2 (ref='0') 
qn30_1_2 (ref='0')qn59_3 (ref='0') qn32_2 (ref='0') qn35_4 (ref='0') 
qn72_3 (ref='0') qn54_1 (ref='0') qn72_2 (ref='0') 
qn2_1 (ref='0') qn9_2 (ref='0') qn5_3 (ref='0') qn74_3 (ref='0') 
qn5_2 (ref='0') qn81_3 (ref='0')qn46_3 (ref='0')/param=ref;
model qn6=qn39_1_2 qn22_1_2 qn10_2 qn19_1_2 qn30_1_2 qn59_3 qn32_2 qn35_4 qn72_3 qn54_1 qn72_2 qn2_1 qn9_2 qn5_3 qn74_3
qn5_2 qn81_3 qn46_3/selection=stepwise;
run;
