explain (costs off, verbose true)
select
    *
from
    installs i
right join
(select
    spend_2021.spend,
    spend_2021.spend_date,
    spend_2021.platform as platform1,
    spend_2021.partner as partner1,
    spend_2021.country as country1,
    r.net_revenue,
    r.install_date,
    r.platform as platform2,
    r.partner as partner2,
    r.country as country2,
    COALESCE(r.install_date, spend_2021.spend_date) as c_date,
    COALESCE(r.platform, spend_2021.platform) as c_platform,
    COALESCE(r.partner, spend_2021.partner) as c_partner,
    COALESCE(r.country, spend_2021.country) as c_country
from
(select * from spend_2021
union all
select * from spend_2022) as spend_2021
full join revenue r on ((spend_2021.spend_date = r.install_date) AND
                        (spend_2021.platform = r.platform) AND
                        (spend_2021.partner = r.partner) AND
                        (spend_2021.country = r.country))) tmp
    on (((COALESCE(tmp.install_date, tmp.spend_date)) = i.install_date) AND ((COALESCE(tmp.platform1, tmp.platform2)) = i.platform) AND ((COALESCE(tmp.partner1, tmp.partner2)) = i.partner) AND ((COALESCE(tmp.country1, tmp.country2)) = i.country));