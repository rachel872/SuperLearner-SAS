%MACRO OLS(TRAIN, Y, Y_TYPE, X, ID, T, WEIGHTS, SEED, WD);
title3 "OLS";
title4 "FITTING: ORDINARY LEAST SQUARES REGRESSION"; 
title5 "VARIABLE SELECTION: ALL";
proc reg data=&TRAIN;
 model &Y = &X;
 %IF &WEIGHTS ne %THEN %DO; weight &WEIGHTS; %END;
 ods output ParameterEstimates=_MyCoef;
run;
data _null_;
 set _MyCoef end=eof;
 file "&WD\f_OLS.sas";
 if _n_ = 1 then put "p_OLS = ";
 if Variable="Intercept" then put Estimate;
 else put "+" Estimate "*" Variable ;
 if eof then put ";" ;
run;
proc datasets lib=work; delete _: ; run; quit;
%MEND OLS;
