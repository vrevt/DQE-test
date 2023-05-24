/* prepare */
drop table base;
create temporary table base as
    select
        u.install_date::date as install_date,
        u.platform as platform,
        u.is_paid as is_paid,
        extract('day' from date_trunc('day', p.payment_time - u.install_date)) as cohort_day,
        sum(p.revenue) as revenue
    from
        users_3 u
        left join payments p on u.user_id = p.user_id
    group by install_date,
             platform,
             is_paid,
             cohort_day;


/* 1 */
select
    install_date,
    platform,
    is_paid,
    cohort_day,
    SUM(revenue) OVER(partition by
                        install_date,
                        platform,
                        is_paid
                    order by
                        cohort_day
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                    ) AS acc_revenue
from
    base;


/* 2 */
select
    install_date,
    platform,
    is_paid,
    b1.cohort_day,
    sum(b2.revenue) as acc_revenue
from
    base b1
    left join base b2 using(install_date, platform, is_paid)
where b1.cohort_day >= b2.cohort_day
group by install_date,
         platform,
         is_paid,
         b1.cohort_day
order by install_date,
         platform,
         is_paid,
         cohort_day;