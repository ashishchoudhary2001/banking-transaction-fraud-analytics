/* Banking Transaction & Fraud Analytics
   SAS analysis using DATA step and PROC SQL/FREQ/MEANS/SORT */

options validvarname=v7;

/* 1. Import CSV */
proc import datafile="dataset.csv"
    out=banking
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

/* 2. Inspect structure */
proc contents data=banking;
run;

/* 3. Descriptive statistics */
proc means data=banking n mean sum min max maxdec=2;
    var amount customer_age risk_score fraud_flag;
run;

/* 4. Frequency analysis */
proc freq data=banking;
    tables customer_segment city transaction_type merchant_category
           channel transaction_status fraud_flag / nocum;
run;

/* 5. Core transaction KPIs */
proc sql;
    select
        count(*) as total_transactions,
        sum(amount) as total_transaction_value format=comma18.2,
        mean(amount) as average_transaction format=comma12.2,
        sum(fraud_flag) as fraudulent_transactions,
        calculated fraudulent_transactions / calculated total_transactions * 100
            as fraud_rate format=8.2
    from banking;
quit;

/* 6. Transaction type analysis */
proc sql;
    create table transaction_type_analysis as
    select
        transaction_type,
        count(*) as transactions,
        sum(amount) as total_value format=comma18.2,
        mean(amount) as average_amount format=comma12.2,
        mean(fraud_flag)*100 as fraud_rate format=8.2
    from banking
    group by transaction_type
    order by total_value desc;
quit;

/* 7. Customer segment analysis */
proc sql;
    create table customer_segment_analysis as
    select
        customer_segment,
        count(*) as transactions,
        sum(amount) as total_value format=comma18.2,
        mean(amount) as average_amount format=comma12.2,
        sum(fraud_flag) as fraud_count
    from banking
    group by customer_segment
    order by total_value desc;
quit;

/* 8. Channel analysis */
proc sql;
    create table channel_analysis as
    select
        channel,
        count(*) as transactions,
        sum(amount) as total_value format=comma18.2,
        sum(fraud_flag) as fraud_count,
        mean(fraud_flag)*100 as fraud_rate format=8.2
    from banking
    group by channel
    order by transactions desc;
quit;

/* 9. Monthly analysis */
data banking_monthly;
    set banking;
    month = intnx('month', transaction_date, 0, 'b');
    format month yymmn7.;
run;

proc sql;
    create table monthly_analysis as
    select
        month,
        count(*) as transactions,
        sum(amount) as total_value format=comma18.2,
        sum(fraud_flag) as fraud_count
    from banking_monthly
    group by month
    order by month;
quit;

/* 10. Identify high-risk transactions */
proc sort data=banking out=high_risk_transactions;
    by descending risk_score;
run;

data high_risk_transactions;
    set high_risk_transactions;
    if risk_score >= 80;
run;

/* 11. Review top 20 high-risk records */
proc print data=high_risk_transactions(obs=20);
    var transaction_id transaction_date customer_id transaction_type
        amount channel fraud_flag risk_score;
run;
