/* added parallel safe */
CREATE OR REPLACE FUNCTION previous_date(date DATE) RETURNS DATE
AS
$$
begin
    SELECT date - 1;
end
$$ language plpgsql parallel safe;

/* default 2 */
SET max_parallel_workers_per_gather = 3;

/* default 8MB, if table size less than 8MB */
set min_parallel_table_scan_size = 0;

/* check */
explain SELECT previous_date(time) FROM times;