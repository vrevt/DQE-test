/* creating table in postgreSQL and copy data from test.csv */
create table test_csv (
    id serial,
    install_date date,
    country text,
    campaign_id text,
    campaign_name varchar(255),
    installs numeric,
    primary key (id)
);
COPY
    test_csv(install_date, country, campaign_id, campaign_name, installs)
FROM
    '/Users/vrevt/projects/tests/vizor/code/task_4/test.csv'
DELIMITER ','
CSV HEADER;


/* campaign_id is null */
select
    *
from
    test_csv
where
    campaign_id is null;

/* country is null */
select
    *
from
    test_csv
where
    country is null;

/* country not in ISO 3166 */
select
    *
from
    test_csv
where not country ~ '^[A-Z]{2}$';

/* installs amount is negative */
select
    *
from
    test_csv
where
    installs < 0;

/* campaign_id is not a valid number */
select
    *
from
    test_csv
where
    not campaign_id ~ '^[0-9]{10}$';

/* some installs amount more than 10 times the average amount */
select
    *
from
    test_csv
where
    installs > 10 * (select avg(installs) from test_csv);

/* min date in install_date is 1970-01-01 and max date is 2300-12-10 */
select
    min(install_date),
    max(install_date)
from
    test_csv;

/* campaign_id with different campaign_name */
select
    *
from
    test_csv
where campaign_id in (
select
    campaign_id
from
    test_csv
group by 1
having count(distinct campaign_name) >= 2)
order by campaign_id;

/* only 2 record with country GB */
select
    country,
    count(id) as record_cnt
from
    test_csv
group by country
order by record_cnt;
select * from test_csv where country = 'GB';

/* Ok - check for lost dates */
select
    install_date,
    lead(install_date) over (order by install_date) - install_date as mx_date_diff
from
    (select install_date from test_csv group by 1) as tmp
order by mx_date_diff desc;

/* Ok - check installs sum by date and country (70399 - 106748) */
select
    install_date,
    country,
    sum(installs) as instsalls_sum
from
    test_csv
group by install_date, country
order by instsalls_sum desc;

/* Ok - check count record by date */
select
    install_date,
    count(id) as cnt
from
    test_csv
group by install_date
order by cnt;

/* Ok - camoaign_name all unique */
select
    campaign_name,
    count(id) as cnt
from
    test_csv
group by campaign_name
order by cnt;
