(*is_Older*)
val bday_old_year = (1970,1,1);
val bday_new_year = (2000,1,1);
val bday_old_month = (0,1,0);
val bday_new_month = (0,12,0);
val bday_old_day = (0,0,0);
val bday_new_day = (0,0,31);

(*number_in_month*)
val date_list = [(0,1,0),(0,2,3),(0,3,5),(0,2,0),(0,1,0),(0,2,0)];
val february = 2;
val january = 1;
val march = 3;

(*number_in_months*)
val month_list_1 = [1,3];
val month_list_2 = [3,2];
val month_list_3 = [9,8];

(*dates_in_month*)
val expected_dates_jan = [(0,1,0),(0,1,0)];
val expected_dates_feb = [(0,2,3),(0,2,0),(0,2,0)];
val expected_dates_may = [];

(*dates_in_months*)
val expected_dates_1 = [(0,1,0),(0,1,0),(0,3,5)];
val expected_dates_2 = [(0,3,5),(0,2,3),(0,2,0),(0,2,0)];
val expected_dates_3 = [];

(*get_nth*)
val string_list = ["one","two","three","four","five","six","seven"];

val func_1_1 = is_older(bday_old_year,bday_new_year) = true;
val func_1_2 = is_older(bday_old_month,bday_new_month) = true;
val func_1_3 = is_older(bday_old_day,bday_new_day) = true;

val func_2_1 = number_in_month(date_list,january) = 2;
val func_2_2 = number_in_month(date_list,february) = 3;
val func_2_3 = number_in_month(date_list,march) = 1;

val func_3_1 = number_in_months(date_list,month_list_1) = 3;
val func_3_2 = number_in_months(date_list,month_list_2) = 4;
val func_3_3 = number_in_months(date_list,month_list_3) = 0;

val func_4_1 = dates_in_month(date_list,january) = expected_dates_jan;
val func_4_2 = dates_in_month(date_list,february) = expected_dates_feb;
val func_4_3 = dates_in_month(date_list,5) = expected_dates_may;

val func_5_1 = dates_in_months(date_list,month_list_1) = expected_dates_1;
val func_5_2 = dates_in_months(date_list,month_list_2) = expected_dates_2;
val func_5_3 = dates_in_months(date_list,month_list_3) = expected_dates_3;

val func_6_1 = get_nth(string_list,1) = "one";
val func_6_2 = get_nth(string_list,5) = "five";
val func_6_3 = get_nth(string_list,length string_list) = "seven";

val func_7_1 = date_to_string((1993,10,13)) = "October 13, 1993";
val func_7_2 = date_to_string((2001,10,14)) = "October 14, 2001";

val func_8_1 = number_before_reaching_sum(5, [1,2,3,4,5]) = 2;
val func_8_2 = number_before_reaching_sum(2, [4,5,4]) = 0;
val func_8_3 = number_before_reaching_sum(42,[31,28,31,30,31,30,31,31,30,31,30,31]) = 1;

val func_9_1 = what_month(1) = 1;
val func_9_2 = what_month(87) = 3;
val func_9_3 = what_month(32) = 2;

val func_10_1 = month_range(1,5) = [1,1,1,1,1];
val func_10_2 = month_range(31,33) = [1,2,2];
val func_10_3 = month_range(58,61) = [2,2,3,3];
val func_10_4 = month_range(5,1) = [];

val func_11_1 = oldest([(0,0,0), (~1,~1,~1)]) = SOME (~1,~1,~1);
val func_11_2 = oldest([(5,5,5), (2,3,3), (3,4,5)]) = SOME (2,3,3);
val func_11_3 = oldest([]) = NONE; 

val func_12_1 = number_in_months_challenge([(~1,2,3),(2,34,5),(0,0,0),(1333,45,6)],[~8]) = 0 ;
val func_12_2 = number_in_months_challenge([(~1,2,3),(2,34,5),(0,0,0),(1333,45,6)],[~8,34,34,34]) = 1;
val func_12_3 = number_in_months_challenge([(~1,2,3),(2,34,5),(0,0,0),(1333,45,6)],[2,34,0,0,0]) = 3;

val func_13_1 = dates_in_months_challenge(date_list,month_list_1 @ month_list_1) = expected_dates_1;  
val func_13_2 = dates_in_months_challenge(date_list,month_list_2 @ month_list_2) = expected_dates_2;  
val func_13_3 = dates_in_months_challenge(date_list,month_list_3 @ month_list_3) = expected_dates_3;

val func_14_1 = reasonable_date(1993,10,13) = true;
val func_14_2 = reasonable_date(~1440,1,1) = false;
val func_14_3 = reasonable_date(2,15,3) = false;
