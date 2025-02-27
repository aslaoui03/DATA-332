R version 4.4.2 (2024-10-31) -- "Pile of Leaves"
Copyright (C) 2024 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin20

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Workspace loaded from ~/.RData]

> library(nycflights13)
Error in library(nycflights13) : 
  there is no package called ‘nycflights13’
> install.packages("nycflights13")
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/nycflights13_1.0.2.tgz'
Content type 'application/x-gzip' length 4503473 bytes (4.3 MB)
==================================================
  downloaded 4.3 MB


The downloaded binary packages are in
/var/folders/tg/pshmb40d2_n9l17tvns3r_yc0000gn/T//RtmpgyoJuJ/downloaded_packages
> library(nycflights13)
> library(tidyverse)
── Attaching core tidyverse packages ───────
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.1     ✔ tibble    3.2.1
✔ lubridate 1.9.4     ✔ tidyr     1.3.1
✔ purrr     1.0.4     
── Conflicts ────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package to force all conflicts to become errors
> flights
# A tibble: 336,776 × 19
year month   day dep_time sched_dep_time
<int> <int> <int>    <int>          <int>
  1  2013     1     1      517            515
2  2013     1     1      533            529
3  2013     1     1      542            540
4  2013     1     1      544            545
5  2013     1     1      554            600
6  2013     1     1      554            558
7  2013     1     1      555            600
8  2013     1     1      557            600
9  2013     1     1      557            600
10  2013     1     1      558            600
# ℹ 336,766 more rows
# ℹ 14 more variables: dep_delay <dbl>,
#   arr_time <int>, sched_arr_time <int>,
#   arr_delay <dbl>, carrier <chr>,
#   flight <int>, tailnum <chr>,
#   origin <chr>, dest <chr>,
#   air_time <dbl>, distance <dbl>, …
# ℹ Use `print(n = ...)` to see more rows
> flights |> filter (arrival_delay >= 120)
Error in `filter()`:
  ℹ In argument: `arrival_delay >=
  120`.
Caused by error:
  ! object 'arrival_delay' not found
Run `rlang::last_trace()` to see where the error occurred.
> flights |> filter (arr_delay >= 120)
# A tibble: 10,200 × 19
year month   day dep_time sched_dep_time
<int> <int> <int>    <int>          <int>
  1  2013     1     1      811            630
2  2013     1     1      848           1835
3  2013     1     1      957            733
4  2013     1     1     1114            900
5  2013     1     1     1505           1310
6  2013     1     1     1525           1340
7  2013     1     1     1549           1445
8  2013     1     1     1558           1359
9  2013     1     1     1732           1630
10  2013     1     1     1803           1620
# ℹ 10,190 more rows
# ℹ 14 more variables: dep_delay <dbl>,
#   arr_time <int>, sched_arr_time <int>,
#   arr_delay <dbl>, carrier <chr>,
#   flight <int>, tailnum <chr>,
#   origin <chr>, dest <chr>,
#   air_time <dbl>, distance <dbl>, …
# ℹ Use `print(n = ...)` to see more rows
> flights |> filter (dest %in% c("IAH", "HOU") 
 + flights |> filter (dest %in% c("IAH", "HOU")) 
 Error: unexpected symbol in:
   "flights |> filter (dest %in% c("IAH", "HOU") 
flights"
 > flights |>
   +     filter(dest %in% c("IAH", "HOU"))
 # A tibble: 9,313 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     1     1      517            515
 2  2013     1     1      533            529
 3  2013     1     1      623            627
 4  2013     1     1      728            732
 5  2013     1     1      739            739
 6  2013     1     1      908            908
 7  2013     1     1     1028           1026
 8  2013     1     1     1044           1045
 9  2013     1     1     1114            900
 10  2013     1     1     1205           1200
 # ℹ 9,303 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > 
   > flights |> filter(filter(career %in% c("United","American","Delta")))
 Error in `filter()`:
   ℹ In argument: `filter(career %in%
                            c("United", "American", "Delta"))`.
 Caused by error:
   ! object 'career' not found
 Run `rlang::last_trace()` to see where the error occurred.
 > flights |> filter(filter(carrier %in% c("United","American","Delta")))
 Error in `filter()`:
   ℹ In argument: `filter(carrier %in%
                            c("United", "American", "Delta"))`.
 Caused by error in `UseMethod()`:
   ! no applicable method for 'filter' applied to an object of class "logical"
 Run `rlang::last_trace()` to see where the error occurred.
 > flights |> filter(filter(carrier %in% c("UA","AA","DL")))
 Error in `filter()`:
   ℹ In argument: `filter(carrier %in%
                            c("UA", "AA", "DL"))`.
 Caused by error in `UseMethod()`:
   ! no applicable method for 'filter' applied to an object of class "logical"
 Run `rlang::last_trace()` to see where the error occurred.
 > flights |> filter(carrier %in% c("UA","AA","DL"))
 # A tibble: 139,504 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     1     1      517            515
 2  2013     1     1      533            529
 3  2013     1     1      542            540
 4  2013     1     1      554            600
 5  2013     1     1      554            558
 6  2013     1     1      558            600
 7  2013     1     1      558            600
 8  2013     1     1      558            600
 9  2013     1     1      559            600
 10  2013     1     1      559            600
 # ℹ 139,494 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > print(n= ...)
 Error: '...' used in an incorrect context
 > print(n=)
 Error in print.default(n = ) : argument "x" is missing, with no default
 > print(n= rows_append())
 Error in UseMethod("rows_append") : 
   no applicable method for 'rows_append' applied to an object of class "NULL"
 > print(n= rows)
 Error: object 'rows' not found
 > flights |> filter(month %in% c(7,8,9))
 # A tibble: 86,326 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     7     1        1           2029
 2  2013     7     1        2           2359
 3  2013     7     1       29           2245
 4  2013     7     1       43           2130
 5  2013     7     1       44           2150
 6  2013     7     1       46           2051
 7  2013     7     1       48           2001
 8  2013     7     1       58           2155
 9  2013     7     1      100           2146
 10  2013     7     1      100           2245
 # ℹ 86,316 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> filter(dep_delay <= 0, arr_delay >=120)
 # A tibble: 29 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     1    27     1419           1420
 2  2013    10     7     1350           1350
 3  2013    10     7     1357           1359
 4  2013    10    16      657            700
 5  2013    11     1      658            700
 6  2013     3    18     1844           1847
 7  2013     4    17     1635           1640
 8  2013     4    18      558            600
 9  2013     4    18      655            700
 10  2013     5    22     1827           1830
 # ℹ 19 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> filter(dep_delay > 60, arr_delay - dep_delay > 30)
 # A tibble: 1,924 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     1     1      811            630
 2  2013     1     1     1400           1250
 3  2013     1     1     1549           1445
 4  2013     1     1     1732           1630
 5  2013     1     1     1803           1620
 6  2013     1     1     1814           1700
 7  2013     1     1     1815           1325
 8  2013     1     1     2119           1930
 9  2013     1     1     2343           1724
 10  2013     1     2      817            630
 # ℹ 1,914 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> arrange(desc(dep_delay))
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     1     9      641            900
 2  2013     6    15     1432           1935
 3  2013     1    10     1121           1635
 4  2013     9    20     1139           1845
 5  2013     7    22      845           1600
 6  2013     4    10     1100           1900
 7  2013     3    17     2321            810
 8  2013     6    27      959           1900
 9  2013     7    22     2257            759
 10  2013    12     5      756           1700
 # ℹ 336,766 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > 
   > flights |> arrange(dep_time)
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     1    13        1           2249
 2  2013     1    31        1           2100
 3  2013    11    13        1           2359
 4  2013    12    16        1           2359
 5  2013    12    20        1           2359
 6  2013    12    26        1           2359
 7  2013    12    30        1           2359
 8  2013     2    11        1           2100
 9  2013     2    24        1           2245
 10  2013     3     8        1           2355
 # ℹ 336,766 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> arrange(dep_time)
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     1    13        1           2249
 2  2013     1    31        1           2100
 3  2013    11    13        1           2359
 4  2013    12    16        1           2359
 5  2013    12    20        1           2359
 6  2013    12    26        1           2359
 7  2013    12    30        1           2359
 8  2013     2    11        1           2100
 9  2013     2    24        1           2245
 10  2013     3     8        1           2355
 # ℹ 336,766 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> arrange(sched_dep_time)
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time
 <int> <int> <int>    <int>          <int>
   1  2013     7    27       NA            106
 2  2013     1     2      458            500
 3  2013     1     3      458            500
 4  2013     1     4      456            500
 5  2013     1     5      458            500
 6  2013     1     6      458            500
 7  2013     1     7      454            500
 8  2013     1     8      454            500
 9  2013     1     9      457            500
 10  2013     1    10      450            500
 # ℹ 336,766 more rows
 # ℹ 14 more variables: dep_delay <dbl>,
 #   arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>,
 #   flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, …
 # ℹ Use `print(n = ...)` to see more rows
 > 
   > flights |> arrange(act_dep_time)
 Error in `arrange()`:
   ℹ In argument: `..1 = act_dep_time`.
 Caused by error:
   ! object 'act_dep_time' not found
 Run `rlang::last_trace()` to see where the error occurred.
 > flights |> arrange(actual_dep_time)
 Error in `arrange()`:
   ℹ In argument: `..1 =
   actual_dep_time`.
 Caused by error:
   ! object 'actual_dep_time' not found
 Run `rlang::last_trace()` to see where the error occurred.
 > flights |> arrange(actu_dep_time)
 Error in `arrange()`:
   ℹ In argument: `..1 =
   actu_dep_time`.
 Caused by error:
   ! object 'actu_dep_time' not found
 Run `rlang::last_trace()` to see where the error occurred.
 > rlang::last_trace()
 <error/dplyr:::mutate_error>
   Error in `arrange()`:
   ℹ In argument: `..1 =
   actu_dep_time`.
 Caused by error:
   ! object 'actu_dep_time' not found
 ---
   Backtrace:
   ▆
 1. ├─dplyr::arrange(flights, actu_dep_time)
 2. └─dplyr:::arrange.data.frame(flights, actu_dep_time)
 3.   └─dplyr:::arrange_rows(.data, dots = dots, locale = .locale)
 4.     ├─dplyr::mutate(data, `:=`("{name}", !!dot), .keep = "none")
 5.     └─dplyr:::mutate.data.frame(data, `:=`("{name}", !!dot), .keep = "none")
 6.       └─dplyr:::mutate_cols(.data, dplyr_quosures(...), by)
 7.         ├─base::withCallingHandlers(...)
 8.         └─dplyr:::mutate_col(dots[[i]], data, mask, new_columns)
 9.           └─mask$eval_all_mutate(quo)
 10.             └─dplyr (local) eval()
 Run rlang::last_trace(drop = FALSE) to see 3 hidden frames.
 > table1
 # A tibble: 6 × 4
 country      year  cases population
 <chr>       <dbl>  <dbl>      <dbl>
   1 Afghanistan  1999    745   19987071
 2 Afghanistan  2000   2666   20595360
 3 Brazil       1999  37737  172006362
 4 Brazil       2000  80488  174504898
 5 China        1999 212258 1272915272
 6 China        2000 213766 1280428583
 > nycflights13:
   + 
   + show table()
 Error: unexpected symbol in:
   "
show table"
 > table()
 Error in table() : nothing to tabulate
 > nycflights13()
 Error in nycflights13() : could not find function "nycflights13"
 > utils::View(data)
 Error in as.data.frame.default(x) : 
   cannot coerce class ‘"function"’ to a data.frame
 > view(flights)
 > flights |> arrange(dep_time)
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time dep_delay arr_time
 <int> <int> <int>    <int>          <int>     <dbl>    <int>
   1  2013     1    13        1           2249        72      108
 2  2013     1    31        1           2100       181      124
 3  2013    11    13        1           2359         2      442
 4  2013    12    16        1           2359         2      447
 5  2013    12    20        1           2359         2      430
 6  2013    12    26        1           2359         2      437
 7  2013    12    30        1           2359         2      441
 8  2013     2    11        1           2100       181      111
 9  2013     2    24        1           2245        76      121
 10  2013     3     8        1           2355         6      431
 # ℹ 336,766 more rows
 # ℹ 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
 #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
 #   time_hour <dttm>
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> arrange(desc(distance / air_time))
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time dep_delay arr_time
 <int> <int> <int>    <int>          <int>     <dbl>    <int>
   1  2013     5    25     1709           1700         9     1923
 2  2013     7     2     1558           1513        45     1745
 3  2013     5    13     2040           2025        15     2225
 4  2013     3    23     1914           1910         4     2045
 5  2013     1    12     1559           1600        -1     1849
 6  2013    11    17      650            655        -5     1059
 7  2013     2    21     2355           2358        -3      412
 8  2013    11    17      759            800        -1     1212
 9  2013    11    16     2003           1925        38       17
 10  2013    11    16     2349           2359       -10      402
 # ℹ 336,766 more rows
 # ℹ 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
 #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
 #   time_hour <dttm>
 # ℹ Use `print(n = ...)` to see more rows
 > library(dplyr)
 > library(dplyr)
 > 
   > flights |>
   +     filter(year == 2013) |>  
   +     group_by(year, month, day) |>  
   +     summarise(count = n()) |>  
   +     ungroup() |>  
   +     summarise(flight_days = n())
 `summarise()` has grouped output by 'year', 'month'. You can override
 using the `.groups` argument.
 # A tibble: 1 × 1
 flight_days
 <int>
   1         365
 > 
   > view(flights)
 > flights |> arrange(desc(distance)) 
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time dep_delay arr_time
 <int> <int> <int>    <int>          <int>     <dbl>    <int>
   1  2013     1     1      857            900        -3     1516
 2  2013     1     2      909            900         9     1525
 3  2013     1     3      914            900        14     1504
 4  2013     1     4      900            900         0     1516
 5  2013     1     5      858            900        -2     1519
 6  2013     1     6     1019            900        79     1558
 7  2013     1     7     1042            900       102     1620
 8  2013     1     8      901            900         1     1504
 9  2013     1     9      641            900      1301     1242
 10  2013     1    10      859            900        -1     1449
 # ℹ 336,766 more rows
 # ℹ 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
 #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
 #   time_hour <dttm>
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> arrange(distance)
 # A tibble: 336,776 × 19
 year month   day dep_time sched_dep_time dep_delay arr_time
 <int> <int> <int>    <int>          <int>     <dbl>    <int>
   1  2013     7    27       NA            106        NA       NA
 2  2013     1     3     2127           2129        -2     2222
 3  2013     1     4     1240           1200        40     1333
 4  2013     1     4     1829           1615       134     1937
 5  2013     1     4     2128           2129        -1     2218
 6  2013     1     5     1155           1200        -5     1241
 7  2013     1     6     2125           2129        -4     2224
 8  2013     1     7     2124           2129        -5     2212
 9  2013     1     8     2127           2130        -3     2304
 10  2013     1     9     2126           2129        -3     2217
 # ℹ 336,766 more rows
 # ℹ 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
 #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
 #   time_hour <dttm>
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> select(contains("TIME"))
 # A tibble: 336,776 × 6
 dep_time sched_dep_time arr_time sched_arr_time air_time
 <int>          <int>    <int>          <int>    <dbl>
   1      517            515      830            819      227
 2      533            529      850            830      227
 3      542            540      923            850      160
 4      544            545     1004           1022      183
 5      554            600      812            837      116
 6      554            558      740            728      150
 7      555            600      913            854      158
 8      557            600      709            723       53
 9      557            600      838            846      140
 10      558            600      753            745      138
 # ℹ 336,766 more rows
 # ℹ 1 more variable: time_hour <dttm>
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> 
   +     rename(air_time_min = air_time) |>
   +     select(air_time_min, everything())
 # A tibble: 336,776 × 19
 air_time_min  year month   day dep_time sched_dep_time dep_delay
 <dbl> <int> <int> <int>    <int>          <int>     <dbl>
   1          227  2013     1     1      517            515         2
 2          227  2013     1     1      533            529         4
 3          160  2013     1     1      542            540         2
 4          183  2013     1     1      544            545        -1
 5          116  2013     1     1      554            600        -6
 6          150  2013     1     1      554            558        -4
 7          158  2013     1     1      555            600        -5
 8           53  2013     1     1      557            600        -3
 9          140  2013     1     1      557            600        -3
 10          138  2013     1     1      558            600        -2
 # ℹ 336,766 more rows
 # ℹ 12 more variables: arr_time <int>, sched_arr_time <int>,
 #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
 #   origin <chr>, dest <chr>, distance <dbl>, hour <dbl>, minute <dbl>,
 #   time_hour <dttm>
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> 
   +     group_by(carrier) |> 
   +     summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) |> 
   +     arrange(desc(avg_delay)) |> 
   +     slice(1)
 # A tibble: 1 × 2
 carrier avg_delay
 <chr>       <dbl>
   1 F9           20.2
 > 
   > flights |> 
   +     group_by(dest) |> 
   +     slice_max(dep_delay, n = 1)
 # A tibble: 105 × 19
 # Groups:   dest [105]
 year month   day dep_time sched_dep_time dep_delay arr_time
 <int> <int> <int>    <int>          <int>     <dbl>    <int>
   1  2013    12    14     2223           2001       142      133
 2  2013     7    23     1139            800       219     1250
 3  2013     1    25      123           2000       323      229
 4  2013     8    17     1740           1625        75     2042
 5  2013     7    22     2257            759       898      121
 6  2013     7    10     2056           1505       351     2347
 7  2013     6    14     1158            816       222     1335
 8  2013     2    21     1728           1316       252     1839
 9  2013    12     1     1504           1056       248     1628
 10  2013     4    10       25           1900       325      136
 # ℹ 95 more rows
 # ℹ 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
 #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
 #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
 #   time_hour <dttm>
 # ℹ Use `print(n = ...)` to see more rows
 > flights |> 
   +     mutate(hour = dep_time %/% 100) |> 
   +     group_by(hour) |> 
   +     summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) |> 
   +     ggplot(aes(x = hour, y = avg_delay)) + 
   +     geom_line()
 Warning message:
   Removed 1 row containing missing values or values outside the scale range
 (`geom_line()`). 
 > 
   > df <- tibble(x = 1:5, y = c("a", "b", "a", "a", "b"),z = c("K", "K", "L", "L", "K"))
 > df |>  group_by(y)
 # A tibble: 5 × 3
 # Groups:   y [2]
 x y     z    
 <int> <chr> <chr>
   1     1 a     K    
 2     2 b     K    
 3     3 a     L    
 4     4 a     L    
 5     5 b     K    
 > df |>  arrange_by(y)
 Error in arrange_by(df, y) : could not find function "arrange_by"
 > df |>  arrange(y)
 # A tibble: 5 × 3
 x y     z    
 <int> <chr> <chr>
   1     1 a     K    
 2     3 a     L    
 3     4 a     L    
 4     2 b     K    
 5     5 b     K    
 > df |> group_by(y, z) |>  summarize(mean_x = mean(x))
 `summarise()` has grouped output by
 'y'. You can override using the
 `.groups` argument.
 # A tibble: 3 × 3
 # Groups:   y [2]
 y     z     mean_x
 <chr> <chr>  <dbl>
   1 a     K        1  
 2 a     L        3.5
 3 b     K        3.5