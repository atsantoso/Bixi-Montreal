{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf200
{\fonttbl\f0\fnil\fcharset0 Monaco;}
{\colortbl;\red255\green255\blue255;\red0\green116\blue0;\red51\green26\blue255;\red0\green0\blue0;
\red128\green67\blue0;\red197\green26\blue22;}
{\*\expandedcolortbl;;\csgenericrgb\c0\c45490\c0;\csgenericrgb\c20000\c10081\c100000;\csgenericrgb\c0\c0\c0;
\csgenericrgb\c50196\c26275\c0;\csgenericrgb\c77255\c10081\c8468;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx480\tx960\tx1440\tx1920\tx2400\tx2880\tx3360\tx3840\tx4320\tx4800\tx5280\tx5760\tx6241\tx6721\tx7201\tx7681\tx8161\tx8641\tx9121\tx9601\tx10081\tx10561\tx11041\tx11521\tx12001\tx12482\tx12962\tx13442\tx13922\tx14402\tx14882\tx15362\tx15842\tx16322\tx16802\tx17282\tx17762\tx18242\tx18723\tx19203\tx19683\tx20163\tx20643\tx21123\tx21603\tx22083\tx22563\tx23043\tx23523\tx24003\tx24483\tx24964\tx25444\tx25924\tx26404\tx26884\tx27364\tx27844\tx28324\tx28804\tx29284\tx29764\tx30244\tx30725\li80\fi-80\pardirnatural\partightenfactor0

\f0\fs20 \cf2 # USAGE VOLUME OVERVIEW\
\cf0 \
\cf2 # PART 1: Number of Trips\
\cf0 \
\cf2 # 1. Total number of trips for 2016\
\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2016\cf4 ;\cf0 \
\
\cf2 # 2. Total number of trips for 2017\
\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf4 ;\cf0 \
\
\cf2 # 3. Total number of trips for 2016 by month\
\cf3 SELECT\cf0  \
	\cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Month\cf4 ,\cf0  \
	\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2016\cf0 \
\cf3 GROUP BY\cf0  \cf3 Month\cf4 ;\cf0 \
\
\cf2 # 4. Total number of trips for 2017 by month\
\cf3 SELECT\cf0  \
	\cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Month\cf4 ,\cf0  \
	\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0 \
\cf3 GROUP BY\cf0  \cf3 Month\cf4 ;\cf0 \
\
\cf2 # 5. Daily average of trips for each year-month combination\
\cf3 SELECT\cf0  \cf3 Year\cf4 ,\cf0  \cf3 Month\cf4 ,\cf0  \cf3 AVG\cf4 (NumberOfTrips)\cf0  \cf3 AS\cf0  \cf4 AverageTripDaily\cf0 \
\cf3 FROM\cf0  \cf4 (\cf0 \
	\cf3 SELECT\cf0 \
		\cf3 YEAR\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Year\cf4 ,\cf0  \
		\cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Month\cf4 ,\cf0  \
		\cf3 DAY\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Day\cf4 ,\cf0 \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
	\cf3 FROM\cf0  \cf4 trips\cf0 \
	\cf3 GROUP BY\cf0  \cf3 Year\cf4 ,\cf0  \cf3 Month\cf4 ,\cf0  \cf3 Day\cf0 \
	\cf4 )\cf0  \cf3 AS\cf0  \cf4 Nested\cf0 \
\cf3 GROUP BY\cf0  \cf3 Year\cf4 ,\cf0  \cf3 Month\cf4 ;\cf0 \
\
\cf2 # PART 2: Membership Status\
\cf0 \
\cf2 # 1. Total number of trips for 2017 by membership status\
\cf3 SELECT\cf0  \
	\cf3 CASE\cf0  \cf4 is_member\cf0 \
		\cf3 WHEN\cf0  \cf5 1\cf0  \cf3 THEN\cf0  \cf6 'Member'\cf0 \
		\cf3 ELSE\cf0  \cf6 'Non-Member'\cf0 \
		\cf3 END\cf0  \cf3 AS\cf0  \cf4 Membership,\cf0 \
	\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0 \
\cf3 GROUP BY\cf0  \cf4 Membership;\cf0 \
\
\cf2 # 2. Fraction of total trips for 2017 by members broken down by months\
# First case, where the total fraction of members and non-members for ALL months is 1\
\cf3 SELECT\cf0  \
	\cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Month\cf4 ,\cf0  \
	\cf4 COUNT(*)/\cf0 \
	\cf4 (\cf2 # Calculating total number of trips in 2017\
\cf0 		\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 Total\cf0 \
		\cf3 FROM\cf0  \cf4 trips\cf0 \
		\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0 \
	\cf4 )\cf0  \
	\cf3 AS\cf0  \cf4 MemberFraction\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf4 is_member\cf0  \cf4 =\cf0  \cf5 1\cf0  \cf3 AND\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0  \
\cf3 GROUP BY\cf0  \cf3 Month\cf4 ;\cf0 \
\cf2 # OR the total fraction of members and non-members for EACH month is 1\
\cf3 SELECT\cf0  \cf4 m1\cf0  \cf3 as\cf0  \cf3 Month\cf4 ,\cf0  \cf4 2017member/2017total\cf0  \cf3 AS\cf0  \cf4 MemberFraction\cf0 \
\cf3 FROM\cf0  \
	\cf4 (\cf0 \
		\cf3 SELECT\cf0  \cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf4 m1,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 2017member\cf0 \
		\cf3 FROM\cf0  \cf4 trips\cf0 \
		\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0  \cf3 AND\cf0  \cf4 is_member\cf0  \cf4 =\cf0  \cf5 1\cf0 \
		\cf3 GROUP BY\cf0  \cf4 m1\cf0 \
	\cf4 )\cf0  \
	\cf3 AS\cf0  \cf4 nested1\cf0 \
\cf3 JOIN\cf0 \
	\cf4 (\cf0 \
		\cf3 SELECT\cf0  \cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf4 m2,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 2017total\cf0 \
		\cf3 FROM\cf0  \cf4 trips\cf0 \
		\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0  \
		\cf3 GROUP BY\cf0  \cf4 m2\cf0 \
	\cf4 )\cf0  \cf3 as\cf0  \cf4 nested2\cf0 \
\cf3 ON\cf0  \cf4 nested1.m1\cf0  \cf4 =\cf0  \cf4 nested2.m2;\cf0 \
\
\cf2 # PART 3\
\cf0 \
\cf2 # 1. Which time of year is the demand for Bixi bikes at the highest i.e. find the month at which usage is at maximum. \
\cf0 \
\cf2 # Creating table. Note: I decided to create a table to find the maximum value because I want to display the year and month at which the value is at maximum for each year at the same time. Simply using subqueries and GROUP BY results only in the year and the maximum value, not the corresponding month unless I'm mistaken. I know you can do ORDER BY with a filter on both years, but I want to do it this way for practice as well. \
\cf3 CREATE\cf0  \cf3 TABLE\cf0  \cf4 volume_yearmonth\cf0  \cf3 AS\cf0  \
\cf3 SELECT\cf0  \cf3 Year\cf0  \cf3 AS\cf0  \cf4 Yr,\cf0  \cf3 Month\cf0  \cf3 AS\cf0  \cf4 Mth,\cf0  \cf3 AVG\cf4 (NumberOfTrips)\cf0  \cf3 AS\cf0  \cf4 AverageTripDaily\cf0 \
\cf3 FROM\cf0  \cf4 (\cf0 \
	\cf3 SELECT\cf0 \
		\cf3 YEAR\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Year\cf4 ,\cf0  \
		\cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Month\cf4 ,\cf0  \
		\cf3 DAY\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Day\cf4 ,\cf0 \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
	\cf3 FROM\cf0  \cf4 trips\cf0 \
	\cf3 GROUP BY\cf0  \cf3 Year\cf4 ,\cf0  \cf3 Month\cf4 ,\cf0  \cf3 Day\cf0 \
	\cf4 )\cf0  \cf3 AS\cf0  \cf4 NESTED\cf0 \
\cf3 GROUP BY\cf0  \cf4 Yr,\cf0  \cf4 Mth;\cf0 \
\cf2 # Finding the maximum usage volume in each year to find highest demand for Bixi bikes\
\cf3 SELECT\cf0  \cf4 Yr,\cf0  \cf4 Mth,\cf0  \cf4 AverageTripDaily\cf0  \cf3 AS\cf0  \cf4 Maximum\cf0 \
\cf3 FROM\cf0  \cf4 volume_yearmonth\cf0 \
\cf3 WHERE\cf0  \cf4 AverageTripDaily\cf0  \
\cf3 IN\cf0  \cf4 (\cf0 \
	\cf3 SELECT\cf0  \cf4 MAX(AverageTripDaily)\cf0  \
	\cf3 FROM\cf0  \cf4 volume_yearmonth\cf0  \
	\cf3 GROUP BY\cf0  \cf4 Yr);\cf0 \
\
\cf2 # 2. Best time to offer non-member a promotion i.e. find the month at which fraction of trip by member is the lowest.\
\cf3 SELECT\cf0  \
	\cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Month\cf4 ,\cf0  \
	\cf4 COUNT(*)/\cf0 \
	\cf4 (\cf2 # Calculating total number of trips in 2017\
\cf0 		\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 Total\cf0 \
		\cf3 FROM\cf0  \cf4 trips\cf0 \
		\cf3 WHERE\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0 \
	\cf4 )\cf0  \
	\cf3 AS\cf0  \cf4 MemberFraction\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf4 is_member\cf0  \cf4 =\cf0  \cf5 1\cf0  \cf3 AND\cf0  \cf3 YEAR\cf4 (start_date)=\cf5 2017\cf0  \
\cf3 GROUP BY\cf0  \cf3 Month\cf0 \
\cf3 ORDER BY\cf0  \cf4 MemberFraction\cf0  \cf3 ASC\cf0 \
\cf3 LIMIT\cf0  \cf5 1\cf4 ;\cf0 \
\
\
\
\cf2 # TRIP CHARACTERISTICS\
\cf0 \
\cf2 # 1. Average trip time \
\cf3 SELECT\cf0  \cf3 AVG\cf4 (duration_sec)\cf0  \cf3 AS\cf0  \cf4 AverageTripTime\cf0 \
\cf3 FROM\cf0  \cf4 trips;\cf0 \
\
\cf2 # 2. 1. Average trip time broken down by membership\
\cf3 SELECT\cf0  \
	\cf3 CASE\cf0  \cf4 is_member\cf0 \
		\cf3 WHEN\cf0  \cf5 1\cf0  \cf3 THEN\cf0  \cf6 'Member'\cf0 \
		\cf3 ELSE\cf0  \cf6 'Non-Member'\cf0 \
		\cf3 END\cf0  \cf3 AS\cf0  \cf4 Membership,\cf0 \
	\cf3 AVG\cf4 (duration_sec)\cf0  \cf3 AS\cf0  \cf4 AverageTripTime\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 GROUP BY\cf0  \cf4 is_member;\cf0 \
\
\cf2 # 2.2. Average trip time broken down by month\
\cf3 SELECT\cf0  \cf3 YEAR\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Year\cf4 ,\cf0  \
		\cf3 MONTH\cf4 (start_date)\cf0  \cf3 AS\cf0  \cf3 Month\cf4 ,\cf0 \
		\cf3 AVG\cf4 (duration_sec)\cf0  \cf3 AS\cf0  \cf4 AverageTripTime\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 GROUP BY\cf0  \cf3 Year\cf4 ,\cf0  \cf3 Month\cf4 ;\cf0 \
\
\cf2 # 2.3. Average trip time broken down by day of the week\
\cf3 SELECT\cf0  \
	\cf4 DAYOFWEEK(start_date)\cf0  \cf3 AS\cf0  \cf4 DayOfWeek,\cf0  \
	\cf4 DAYNAME(start_date)\cf0  \cf3 AS\cf0  \cf4 DayName,\cf0 \
	\cf3 AVG\cf4 (duration_sec)\cf0  \cf3 AS\cf0  \cf4 AverageTripTime\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 GROUP BY\cf0  \cf4 DayOfWeek,\cf0  \cf4 DayName;\cf0 \
\
\cf2 # 2.4. Average trip time broken down by station name\
\cf0 \
\cf2 # I'm creating another table so that I can do easy manipulation with it later on. \
\cf3 CREATE\cf0  \cf3 TABLE\cf0  \cf4 combined_stations\cf0  \cf3 AS\cf0 \
\cf3 SELECT\cf0  \cf4 *\cf0 \
\cf3 FROM\cf0  \
\cf4 (\cf2 # This section creates a query result called 'nested1', which joins stations and trips when the code and start station code is the same.\
\cf0 	\cf3 SELECT\cf0  \cf4 *\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr1\cf0  \cf3 ON\cf0  \cf4 st.code\cf0  \cf4 =\cf0  \cf4 tr1.start_station_code\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 nested1\cf0  \
\cf3 UNION\cf0  \cf2 # This will combine the result of nested1 with the result of the query below.\
\cf4 (\cf2 # This section creates another query result called which joins stations and trips when the code and end station code is the same.\
\cf0 	\cf3 SELECT\cf0  \cf4 *\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr2\cf0  \cf3 ON\cf0  \cf4 st.code\cf0  \cf4 =\cf0  \cf4 tr2.end_station_code\cf0 \
\cf4 );\cf0 \
\
\cf2 # For sanity check, I'm going to check for duplicates in my new table 'combined_stations'. There are 2 unique primary keys from the stations and trips table i.e. id and code so I'm going to use thats\
\cf3 SELECT\cf0  \
   \cf4 id,\cf0 \
   \cf3 code\cf0 \
\cf3 FROM\cf0 \
	\cf4 combined_stations\cf0 \
\cf3 GROUP BY\cf0  \
	\cf5 1\cf4 ,\cf0  \
	\cf5 2\cf0 \
\cf3 HAVING\cf0  \
	\cf4 (COUNT(\cf5 1\cf4 )\cf0  \cf4 >\cf0  \cf5 1\cf4 )\cf0  \cf3 AND\cf0  \
	\cf4 (COUNT(\cf5 2\cf4 )\cf0  \cf4 >\cf0  \cf5 1\cf4 );\cf0 \
\
\cf2 # 2.4.1. Finding the station with the longest trip time\
\cf3 SELECT\cf0  \cf3 code\cf4 ,\cf0  \cf3 name\cf4 ,\cf0  \cf3 AVG\cf0  \cf4 (duration_sec)\cf0  \cf3 AS\cf0  \cf4 AverageTripTime\cf0 \
\cf3 FROM\cf0  \cf4 combined_stations\cf0 \
\cf3 GROUP BY\cf0  \cf3 code\cf4 ,\cf0  \cf3 name\cf0 \
\cf3 ORDER BY\cf0  \cf4 AverageTripTime\cf0  \cf3 DESC\cf0  \
\cf3 LIMIT\cf0  \cf5 1\cf4 ;\cf0 \
\
\cf2 # 2.4.2. Finding the station with the shortest trip time \
\cf3 SELECT\cf0  \cf3 code\cf4 ,\cf0  \cf3 name\cf4 ,\cf0  \cf3 AVG\cf0  \cf4 (duration_sec)\cf0  \cf3 AS\cf0  \cf4 AverageTripTime\cf0 \
\cf3 FROM\cf0  \cf4 combined_stations\cf0 \
\cf3 GROUP BY\cf0  \cf3 code\cf4 ,\cf0  \cf3 name\cf0 \
\cf3 ORDER BY\cf0  \cf4 AverageTripTime\cf0  \cf3 ASC\cf0  \
\cf3 LIMIT\cf0  \cf5 1\cf4 ;\cf0 \
\
\cf2 # 2.4.3. To remove the skew from the result, let's first calculate some of the descriptive statistics of the trip duration.\
\cf3 SELECT\cf0  \
	\cf4 ROUND(\cf3 AVG\cf4 (duration_sec),\cf5 2\cf4 )\cf0  \cf3 AS\cf0  \cf4 Average,\cf0  \
	\cf4 ROUND(STD(duration_sec),\cf5 2\cf4 )\cf0  \cf3 AS\cf0  \cf4 SD,\cf0  \
	\cf4 MAX(duration_sec)\cf0  \cf3 AS\cf0  \cf4 Maximum,\cf0  \
	\cf4 MIN(duration_sec)\cf0  \cf3 AS\cf0  \cf4 Minimum\cf0 \
\cf3 FROM\cf0  \cf4 trips;\cf0 \
\
\cf2 # We can then remove the skew using the average and the standard deviation. The data selected here is an updated table with average and STD calculated and then filtered so that only those stations, which has a mean value within 2 standard deviation to mean is included.\
\cf3 SELECT\cf0  \cf4 *\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0 \
\cf3 JOIN\cf0  \
\cf4 (\cf0 \
	\cf3 SELECT\cf0  \cf3 AVG\cf4 (duration_sec)\cf0  \cf3 AS\cf0  \cf4 Average,\cf0  \cf4 STD(duration_sec)\cf0  \cf3 AS\cf0  \cf4 STD\cf0 \
	\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 stats\cf0 \
\cf3 WHERE\cf0  \cf4 tr.duration_sec\cf0  \cf3 BETWEEN\cf0  \cf4 (stats.average\cf0  \cf4 -\cf0  \cf5 2\cf4 *stats.STD)\cf0  \cf3 AND\cf0  \cf4 (stats.average\cf0  \cf4 +\cf0  \cf5 2\cf4 *stats.STD)\cf0 \
\cf3 LIMIT\cf0  \cf5 5\cf4 ;\cf0 \
\
\cf2 # 3. Creating a table for just round trips\
\cf3 CREATE\cf0  \cf3 TABLE\cf0  \cf4 round_trips\cf0  \cf3 AS\cf0  \
\cf3 SELECT\cf0  \cf4 *\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf4 trips.start_station_code\cf0  \cf4 =\cf0  \cf4 trips.end_station_code;\cf0 \
\
\cf2 # 3.1. Calculating the fraction of trips that were round trips broken down by membership: \
\cf3 SELECT\cf0  \
	\cf3 CASE\cf0  \cf4 is_member\cf0 \
		\cf3 WHEN\cf0  \cf5 1\cf0  \cf3 THEN\cf0  \cf6 'Member'\cf0 \
		\cf3 ELSE\cf0  \cf6 'Non-Member'\cf0 \
		\cf3 END\cf0  \cf3 AS\cf0  \cf4 Membership,\cf0 \
	\cf4 COUNT(*)/\cf0 \
	\cf4 (\cf2 # Calculating total number of trips\
\cf0 		\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 Total\cf0  \cf3 FROM\cf0  \cf4 trips\cf0 \
	\cf4 )\cf0  \cf3 AS\cf0  \cf4 RTFraction\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf4 trips.start_station_code\cf0  \cf4 =\cf0  \cf4 trips.end_station_code\cf0 \
\cf3 GROUP BY\cf0  \cf4 Membership;\cf0 \
\
\cf2 # 3.2. Calculating the fraction of trips that were round trips broken down by day of the week\
\cf3 SELECT\cf0  	\
	\cf4 DAYOFWEEK(start_date)\cf0  \cf3 AS\cf0  \cf4 DayOfWeek,\cf0 \
	\cf4 DAYNAME(start_date)\cf0  \cf3 AS\cf0  \cf4 DayName,\cf0  \
	\cf4 COUNT(*)/\cf0 \
	\cf4 (\cf2 # Calculating total number of trips\
\cf0 		\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 Total\cf0 \
		\cf3 FROM\cf0  \cf4 trips\cf0 \
	\cf4 )\cf0  \cf3 AS\cf0  \cf4 RT_Fraction\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0 \
\cf3 WHERE\cf0  \cf4 trips.start_station_code\cf0  \cf4 =\cf0  \cf4 trips.end_station_code\cf0 \
\cf3 GROUP BY\cf0  \cf4 DayOfWeek,\cf0  \cf4 DayName;\cf0 \
\
\
\
\cf2 # POPULAR STATIONS\
\cf0 \
\cf2 # 1. 5 most popular starting stations\
\cf3 SELECT\cf0  \cf3 name\cf0  \cf3 AS\cf0  \cf6 "Station Name"\cf4 ,\cf0  \cf4 start_station_code,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0 \
\cf3 JOIN\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0  \cf3 ON\cf0  \cf4 tr.start_station_code\cf0  \cf4 =\cf0  \cf4 st.code\cf0 \
\cf3 GROUP BY\cf0  \cf3 name\cf4 ,\cf0  \cf4 start_station_code\cf0 \
\cf3 ORDER BY\cf0  \cf4 NumberOfTrips\cf0  \cf3 DESC\cf0 \
\cf3 LIMIT\cf0  \cf5 5\cf4 ;\cf0 \
\
\cf2 # 2. 5 most popular ending stations\
\cf3 SELECT\cf0  \cf3 name\cf0  \cf3 AS\cf0  \cf6 "Station Name"\cf4 ,\cf0  \cf4 end_station_code,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfTrips\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0 \
\cf3 JOIN\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0  \cf3 ON\cf0  \cf4 tr.end_station_code\cf0  \cf4 =\cf0  \cf4 st.code\cf0 \
\cf3 GROUP BY\cf0  \cf3 name\cf4 ,\cf0  \cf4 end_station_code\cf0 \
\cf3 ORDER BY\cf0  \cf4 NumberOfTrips\cf0  \cf3 DESC\cf0 \
\cf3 LIMIT\cf0  \cf5 5\cf4 ;\cf0 \
\
\cf2 # 3. Number of starts and ends for the Mackay / de Maisonneuve station.\
# Let's find out the station code for the Mackay / de Maisonneuve station first to make it simpler\
\cf3 SELECT\cf0  \cf3 code\cf4 ,\cf0  \cf3 name\cf0 \
\cf3 FROM\cf0  \cf4 stations\cf0 \
\cf3 WHERE\cf0  \cf3 name\cf0  \cf4 =\cf0  \cf6 "Mackay / de Maisonneuve"\cf4 ;\cf0 \
\
\cf2 # 3.1 Now, applying the hour distribution to find out the number of STARTS in the Mackay / de Maisonneuve station.\
\cf3 SELECT\cf0  \cf4 time_of_day,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfStarts\cf0 \
\cf3 FROM\cf0 \
\cf4 (\cf0 \
\cf3 SELECT\cf0  \cf4 *,\cf0  \cf3 CASE\cf0 \
    \cf3 WHEN\cf0  \cf3 HOUR\cf4 (start_date)\cf0  \cf3 BETWEEN\cf0  \cf5 7\cf0  \cf3 AND\cf0  \cf5 11\cf0  \cf3 THEN\cf0  \cf6 "morning"\cf0 \
    \cf3 WHEN\cf0  \cf3 HOUR\cf4 (start_date)\cf0  \cf3 BETWEEN\cf0  \cf5 12\cf0  \cf3 AND\cf0  \cf5 16\cf0  \cf3 THEN\cf0  \cf6 "afternoon"\cf0 \
    \cf3 WHEN\cf0  \cf3 HOUR\cf4 (start_date)\cf0  \cf3 BETWEEN\cf0  \cf5 17\cf0  \cf3 AND\cf0  \cf5 21\cf0  \cf3 THEN\cf0  \cf6 "evening"\cf0 \
    \cf3 ELSE\cf0  \cf6 "night"\cf0 \
\cf3 END\cf0  \cf3 AS\cf0  \cf6 "time_of_day"\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0  \
\cf3 WHERE\cf0  \cf4 start_station_code\cf0  \cf4 =\cf0  \cf5 6100\cf0  \cf2 #Code for Mackay / de Maisonneuve station is 6100 and we match it with the start_station_code to find out the number of starts\
\cf4 )\cf0  \cf3 AS\cf0  \cf4 nested\cf0 \
\cf3 GROUP BY\cf0  \cf4 time_of_day\cf0 \
\cf3 ORDER BY\cf0  \cf4 NumberOfStarts;\cf0 \
\
\cf2 # Now, applying the hour distribution to find out the number of ENDS in the Mackay / de Maisonneuve station.\
\cf3 SELECT\cf0  \cf4 time_of_day,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberOfEnds\cf0 \
\cf3 FROM\cf0 \
\cf4 (\cf0 \
\cf3 SELECT\cf0  \cf4 *,\cf0  \cf3 CASE\cf0 \
    \cf3 WHEN\cf0  \cf3 HOUR\cf4 (start_date)\cf0  \cf3 BETWEEN\cf0  \cf5 7\cf0  \cf3 AND\cf0  \cf5 11\cf0  \cf3 THEN\cf0  \cf6 "morning"\cf0 \
    \cf3 WHEN\cf0  \cf3 HOUR\cf4 (start_date)\cf0  \cf3 BETWEEN\cf0  \cf5 12\cf0  \cf3 AND\cf0  \cf5 16\cf0  \cf3 THEN\cf0  \cf6 "afternoon"\cf0 \
    \cf3 WHEN\cf0  \cf3 HOUR\cf4 (start_date)\cf0  \cf3 BETWEEN\cf0  \cf5 17\cf0  \cf3 AND\cf0  \cf5 21\cf0  \cf3 THEN\cf0  \cf6 "evening"\cf0 \
    \cf3 ELSE\cf0  \cf6 "night"\cf0 \
\cf3 END\cf0  \cf3 AS\cf0  \cf6 "time_of_day"\cf0 \
\cf3 FROM\cf0  \cf4 trips\cf0  \
\cf3 WHERE\cf0  \cf4 end_station_code\cf0  \cf4 =\cf0  \cf5 6100\cf0  \cf2 #Code for Mackay / de Maisonneuve station is 6100 and we match it with the end_station_code to find out the number of ends\
\cf4 )\cf0  \cf3 AS\cf0  \cf4 nested\cf0 \
\cf3 GROUP BY\cf0  \cf4 time_of_day\cf0 \
\cf3 ORDER BY\cf0  \cf4 NumberOfEnds;\cf0 \
\
\cf2 # 4. Proportionally the least number of member trips and the most number of member trips\
# For this question I use the table I created previously, \'91combined_stations\'92 where all the station is joined with the trips table according to their start and end station codes\
# For proportionally least number of member trips \
\cf3 SELECT\cf0  \
	\cf3 code\cf4 ,\cf0  \
	\cf3 name\cf4 ,\cf0  \
	\cf4 COUNT(*)/(\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 Total\cf0  \cf3 FROM\cf0  \cf4 trips)\cf0  \cf3 AS\cf0  \cf4 MemberFraction,\cf0 \
	\cf4 COUNT(start_station_code)\cf0  \cf3 AS\cf0  \cf4 TotalStart,\cf0 \
	\cf4 COUNT(end_station_code)\cf0  \cf3 AS\cf0  \cf4 TotalEnd\cf0 \
\cf3 FROM\cf0  \cf4 combined_stations\cf0 \
\cf3 WHERE\cf0  \cf4 is_member\cf0  \cf4 =\cf0  \cf5 1\cf0  \
\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf0  \cf5 2\cf0 \
\cf3 HAVING\cf0  \cf4 TotalStart\cf0  \cf4 >=\cf0  \cf5 10\cf0  \cf3 AND\cf0  \cf4 TotalEnd\cf0  \cf4 >=\cf0  \cf5 10\cf0 \
\cf3 ORDER BY\cf0  \cf4 MemberFraction\cf0  \cf3 ASC\cf0 \
\cf3 LIMIT\cf0  \cf5 10\cf4 ;\cf0 \
\
\cf2 # For proportionally the most number of member trips\
\cf3 SELECT\cf0  \
	\cf3 code\cf4 ,\cf0  \
	\cf3 name\cf4 ,\cf0  \
	\cf4 COUNT(*)/(\cf3 SELECT\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 Total\cf0  \cf3 FROM\cf0  \cf4 trips)\cf0  \cf3 AS\cf0  \cf4 MemberFraction,\cf0 \
	\cf4 COUNT(start_station_code)\cf0  \cf3 AS\cf0  \cf4 TotalStart,\cf0 \
	\cf4 COUNT(end_station_code)\cf0  \cf3 AS\cf0  \cf4 TotalEnd\cf0 \
\cf3 FROM\cf0  \cf4 combined_stations\cf0 \
\cf3 WHERE\cf0  \cf4 is_member\cf0  \cf4 =\cf0  \cf5 1\cf0  \
\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf0  \cf5 2\cf0 \
\cf3 HAVING\cf0  \cf4 TotalStart\cf0  \cf4 >=\cf0  \cf5 10\cf0  \cf3 AND\cf0  \cf4 TotalEnd\cf0  \cf4 >=\cf0  \cf5 10\cf0 \
\cf3 ORDER BY\cf0  \cf4 MemberFraction\cf0  \cf3 DESC\cf0 \
\cf3 LIMIT\cf0  \cf5 10\cf4 ;\cf0 \
\
\cf2 # 5.1. Number of starting trips in each station\
\cf3 SELECT\cf0  \cf3 code\cf4 ,\cf0  \cf3 name\cf0  \cf3 AS\cf0  \cf4 StationName,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberStartTrips\cf0 \
\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0 \
\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0  \cf3 ON\cf0  \cf4 st.code\cf0  \cf4 =\cf0  \cf4 tr.start_station_code\cf0 \
\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf2 # To just display the first 10\
\cf3 LIMIT\cf0  \cf5 5\cf4 ;\cf0  \
\
\cf2 # 5.2. Number of round trips in each station\
\cf3 SELECT\cf0  \cf3 code\cf4 ,\cf0  \cf3 name\cf0  \cf3 AS\cf0  \cf4 StationName,\cf0  \cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberRoundTrips\cf0 \
\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0 \
\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0  \cf3 ON\cf0  \cf4 st.code\cf0  \cf4 =\cf0  \cf4 tr.start_station_code\cf0 \
\cf3 WHERE\cf0  \cf4 tr.start_station_code\cf0  \cf4 =\cf0  \cf4 tr.end_station_code\cf0 \
\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf2 # For just a display purpose\
\cf3 LIMIT\cf0  \cf5 5\cf4 ;\cf0 \
\
\cf2 # 5.3. Combining the two queries above to find the fraction of round trips to the starting trips for each station\
\cf3 SELECT\cf0  \cf4 c1\cf0  \cf3 AS\cf0  \cf3 code\cf4 ,\cf0  \cf4 n1\cf0  \cf3 AS\cf0  \cf4 StationName,\cf0  \cf4 NumberRoundTrips/NumberStartTrips\cf0  \cf3 AS\cf0  \cf4 RT_Start_Fraction\cf0 \
\cf3 FROM\cf0 \
\cf4 (\cf0 \
	\cf3 SELECT\cf0  \
		\cf3 code\cf0  \cf3 AS\cf0  \cf4 c1,\cf0  \
		\cf3 name\cf0  \cf3 AS\cf0  \cf4 n1,\cf0  \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberStartTrips\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st1\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr1\cf0  \cf3 ON\cf0  \cf4 st1.code\cf0  \cf4 =\cf0  \cf4 tr1.start_station_code\cf0 \
	\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
	\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 StartTrip\cf0 \
\cf3 JOIN\cf0 \
\cf4 (\cf0 \
	\cf3 SELECT\cf0  \
		\cf3 code\cf0  \cf3 AS\cf0  \cf4 c2,\cf0  \
		\cf3 name\cf0  \cf3 AS\cf0  \cf4 n2,\cf0  \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberRoundTrips\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0  \cf3 ON\cf0  \cf4 st.code\cf0  \cf4 =\cf0  \cf4 tr.start_station_code\cf0 \
	\cf3 WHERE\cf0  \cf4 tr.start_station_code\cf0  \cf4 =\cf0  \cf4 tr.end_station_code\cf0 \
	\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
	\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 RoundTrip\cf0  \
\cf3 ON\cf0  \cf4 StartTrip.c1\cf0  \cf4 =\cf0  \cf4 RoundTrip.c2\cf0  \cf2 #Let's join the StartTrip and RoundTrip results based on the station_code\
\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf3 LIMIT\cf0  \cf5 5\cf4 ;\cf0  \
\
\cf2 # 5.4. Filter to ONLY consider the stations with at least 50 starting trips from them\
\cf3 SELECT\cf0  \cf4 c1\cf0  \cf3 AS\cf0  \cf3 code\cf4 ,\cf0  \cf4 n1\cf0  \cf3 AS\cf0  \cf4 StationName,\cf0  \cf4 NumberStartTrips,\cf0  \cf4 NumberRoundTrips/NumberStartTrips\cf0  \cf3 AS\cf0  \cf4 RT_Start_Fraction\cf0 \
\cf3 FROM\cf0 \
\cf4 (\cf0 \
	\cf3 SELECT\cf0  \
		\cf3 code\cf0  \cf3 AS\cf0  \cf4 c1,\cf0  \
		\cf3 name\cf0  \cf3 AS\cf0  \cf4 n1,\cf0  \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberStartTrips\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st1\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr1\cf0  \cf3 ON\cf0  \cf4 st1.code\cf0  \cf4 =\cf0  \cf4 tr1.start_station_code\cf0 \
	\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
	\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 StartTrip\cf0 \
\cf3 JOIN\cf0 \
\cf4 (\cf0 \
	\cf3 SELECT\cf0  \
		\cf3 code\cf0  \cf3 AS\cf0  \cf4 c2,\cf0  \
		\cf3 name\cf0  \cf3 AS\cf0  \cf4 n2,\cf0  \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberRoundTrips\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0  \cf3 ON\cf0  \cf4 st.code\cf0  \cf4 =\cf0  \cf4 tr.start_station_code\cf0 \
	\cf3 WHERE\cf0  \cf4 tr.start_station_code\cf0  \cf4 =\cf0  \cf4 tr.end_station_code\cf0 \
	\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
	\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 RoundTrip\cf0  \
\cf3 ON\cf0  \cf4 StartTrip.c1\cf0  \cf4 =\cf0  \cf4 RoundTrip.c2\cf0  \
\cf3 WHERE\cf0  \cf4 NumberStartTrips\cf0  \cf4 >=\cf0  \cf5 50\cf0  	\cf2 # Including ONLY stations with starting trips more than or equal to 50\
\cf3 ORDER BY\cf0  \cf4 NumberStartTrips\cf0  \cf3 ASC\cf0 \
\cf3 LIMIT\cf0  \cf5 5\cf4 ;\cf0  \
\
\cf2 # 5. List all stations for which 10% of trips are round trips\
\cf3 SELECT\cf0  \cf4 c1\cf0  \cf3 AS\cf0  \cf3 code\cf4 ,\cf0  \cf4 n1\cf0  \cf3 AS\cf0  \cf4 StationName,\cf0  \cf4 NumberStartTrips,\cf0  \cf4 NumberRoundTrips/NumberStartTrips\cf0  \cf3 AS\cf0  \cf4 RT_Start_Fraction\cf0 \
\cf3 FROM\cf0 \
\cf4 (\cf0 \
	\cf3 SELECT\cf0  \
		\cf3 code\cf0  \cf3 AS\cf0  \cf4 c1,\cf0  \
		\cf3 name\cf0  \cf3 AS\cf0  \cf4 n1,\cf0  \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberStartTrips\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st1\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr1\cf0  \cf3 ON\cf0  \cf4 st1.code\cf0  \cf4 =\cf0  \cf4 tr1.start_station_code\cf0 \
	\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
	\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 StartTrip\cf0 \
\cf3 JOIN\cf0 \
\cf4 (\cf0 \
	\cf3 SELECT\cf0  \
		\cf3 code\cf0  \cf3 AS\cf0  \cf4 c2,\cf0  \
		\cf3 name\cf0  \cf3 AS\cf0  \cf4 n2,\cf0  \
		\cf4 COUNT(*)\cf0  \cf3 AS\cf0  \cf4 NumberRoundTrips\cf0 \
	\cf3 FROM\cf0  \cf4 stations\cf0  \cf3 AS\cf0  \cf4 st\cf0 \
	\cf3 JOIN\cf0  \cf4 trips\cf0  \cf3 AS\cf0  \cf4 tr\cf0  \cf3 ON\cf0  \cf4 st.code\cf0  \cf4 =\cf0  \cf4 tr.start_station_code\cf0 \
	\cf3 WHERE\cf0  \cf4 tr.start_station_code\cf0  \cf4 =\cf0  \cf4 tr.end_station_code\cf0 \
	\cf3 GROUP BY\cf0  \cf5 1\cf4 ,\cf5 2\cf0 \
	\cf3 ORDER BY\cf0  \cf5 3\cf0  \cf3 DESC\cf0 \
\cf4 )\cf0  \cf3 AS\cf0  \cf4 RoundTrip\cf0  \
\cf3 ON\cf0  \cf4 StartTrip.c1\cf0  \cf4 =\cf0  \cf4 RoundTrip.c2\cf0  \
\cf3 WHERE\cf0  \cf4 NumberStartTrips\cf0  \cf4 >=\cf0  \cf5 50\cf0  		\cf2 # Including ONLY stations with starting trips more than or equal to 50\
\cf3 HAVING\cf0  \cf4 RT_Start_Fraction\cf0  \cf4 >=\cf0  \cf5 0.1\cf0  	\cf2 # ONLY stations for which at least 10% of trips are round trips are included\
\cf3 ORDER BY\cf0  \cf4 RT_Start_Fraction\cf0  \cf3 ASC\cf4 ;\cf0  \
\
}