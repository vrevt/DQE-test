/* 2 */
select
    u.install_date::date as install_date,
    u.platform as platform,
    u.is_paid as is_paid,
    extract('day' from date_trunc('day', p.payment_time - u.install_date)) as cohort_day,
    sum(p.revenue)
from
    users_3 u
    left join payments p on u.user_id = p.user_id
group by install_date, platform, is_paid, cohort_day
order by cohort_day;
