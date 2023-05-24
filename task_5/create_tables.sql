create table installs (
    install_date date,
    platform text,
    partner text,
    country text,
    installs int
);

insert into installs (install_date, platform, partner, country, installs) VALUES
('2021-09-01', 'idos', 'od', 'bldsr', 3),
('2021-10-04', 'anid', 'afsle', 'dsmzr', 15);

create table revenue (
    net_revenue int,
    install_date date,
    platform text,
    partner text,
    country text
);

insert into revenue (net_revenue, install_date, platform, partner, country) VALUES
(200, '2021-09-01', 'idos', 'od', 'bldsr'),
(300, '2021-10-04', 'anid', 'afsle', 'dsmzr');

create table spend_2021 (
    spend_date date,
    platform text,
    partner text,
    country text,
    spend int
);

insert into spend_2021 (spend_date, platform, partner, country, spend) VALUES
('2021-09-02', 'idos', 'od', 'bldsr', 100),
('2021-10-05', 'anid', 'afsle', 'dsmzr', 200);


create table spend_2022 (
    spend_date date,
    platform text,
    partner text,
    country text,
    spend int
);

insert into spend_2022 (spend_date, platform, partner, country, spend) VALUES
('2022-09-02', 'idos', 'od', 'bldsr', 10),
('2022-10-05', 'anid', 'afsle', 'dsmzr', 20);


