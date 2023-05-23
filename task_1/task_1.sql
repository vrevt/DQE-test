with all_time_aggregated as (
select
    count(user_id) as purchases,
    count(distinct user_id) as buyers,
    sum(revenue) as revenue
from
    payments
),

installs_and_revenue_by_date as (
select
    a.install_time::date as install_date,
    count(distinct user_id) as installs,
    sum(case
            when install_to_payment_time < interval '2 day' then revenue else 0
        end) as revenue_1,
    sum(case
            when install_to_payment_time < interval '4 day' then revenue else 0
        end) as revenue_3,
    sum(case
            when install_to_payment_time < interval '6 day' then revenue else 0
        end) as revenue_5,
    sum(case
            when install_to_payment_time < interval '8 day' then revenue else 0
        end) as revenue_7
from (
    select
        u.user_id,
        u.install_time as install_time,
        p.payment_time - u.install_time as install_to_payment_time,
        p.revenue as revenue
    from
        users u
        left join payments p on u.user_id = p.user_id
    ) a
group by install_date)

select
    i.install_date,
    i.installs,
    a.purchases,
    a.buyers,
    a.revenue,
    i.revenue_1,
    i.revenue_3,
    i.revenue_5,
    i.revenue_7
from
    installs_and_revenue_by_date i
    cross join all_time_aggregated a;


