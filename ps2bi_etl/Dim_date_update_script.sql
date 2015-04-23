CREATE TABLE `dim_date_temp` (
  `date_key` int(11) NOT NULL AUTO_INCREMENT,
  `date_field` date DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month_in_year` int(11) DEFAULT NULL,
  `month_desc` varchar(45) DEFAULT NULL,
  `week_in_year` int(11) DEFAULT NULL,
  `week_in_month` int(11) DEFAULT NULL,
  `day_in_week` int(11) DEFAULT NULL,
  `timestamp_start` int(10) unsigned DEFAULT NULL,
  `timestamp_end` int(10) unsigned DEFAULT NULL,
  `week_start_key` int(11) DEFAULT NULL,
  `week_end_key` int(11) DEFAULT NULL,
  `month_start_key` int(11) DEFAULT NULL,
  `month_end_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `date_key_UNIQUE` (`date_key`),
  UNIQUE KEY `date_field_UNIQUE` (`date_field`)
) ENGINE=InnoDB AUTO_INCREMENT=996 DEFAULT CHARSET=utf8;

Insert into dim_date_temp

Select
a.date_key,
a.date_field,
a.year,
a.month_in_year,
a.month_desc,
a.week_in_year,
a.week_in_month,
a.day_in_week,
a.timestamp_start,
a.timestamp_end,
min(week.date_key),
max(week.date_key),
min(month.date_key),
max(month.date_key)

from
ps2bi_dwh.dim_date a
join ps2bi_dwh.dim_date week
on a.week_in_year = week.week_in_year and a.year = week.year
join ps2bi_dwh.dim_date month
on a.month_in_year = month.month_in_year and a.year = month.year

group by
a.date_key,
a.date_field,
a.year,
a.month_in_year,
a.month_desc,
a.week_in_year,
a.week_in_month,
a.day_in_week,
a.timestamp_start,
a.timestamp_end;

delete from dim_date;

insert into dim_date select * from dim_date_temp;

drop table dim_date_temp;