(* returns a boolean value, true if first date occured earlier *)
fun is_older (d_1 : int*int*int, d_2: int*int*int) = 
   if (#1 d_1) <> (#1 d_2 ) then (#1 d_1) < (#1 d_2 )
   else if (#2 d_1) <> (#2 d_2) then (#2 d_1) < (#2 d_2)
   else (#3 d_1) < (#3 d_2)

(* returns the number of occurences of a month in a list of dates *) 
fun number_in_month (date_list : (int*int*int) list, month : int) = 
   if null date_list then 0
   else if #2 (hd date_list) = month then 1 + 
         number_in_month(tl date_list, month)
   else 0 + number_in_month(tl date_list, month)
   
(* returns the number of occurences of dates with months in the month list *)
fun number_in_months (date_list :(int*int*int) list, month_list : int list) =
   if null month_list then 0
   else number_in_month(date_list, hd month_list) + 
         number_in_months(date_list, tl month_list) 
  
(* returns a list of dates corresponding to the passed month *)
fun dates_in_month (date_list : (int*int*int) list, month : int) = 
   if null date_list then []
   else if (#2 (hd date_list)) = month then hd date_list :: 
         dates_in_month(tl date_list, month)
   else dates_in_month(tl date_list, month)

(* returns a list of dates that share months listed in the month list *)
fun dates_in_months (date_list :(int*int*int) list, month_list : int list) =
   if null month_list then []
   else dates_in_month(date_list, hd month_list) @ 
         dates_in_months(date_list,tl month_list)

(* returns the nth string of a string list *) 
fun get_nth (string_list : string list, n : int) =
   if n = 1 then hd string_list
   else get_nth (tl string_list,n-1)

(* returns a string representation of a date *)
fun date_to_string (date: int*int*int) =
   let 
      val months_list = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
   in
      get_nth(months_list, #2 date) ^ " " ^ (Int.toString (#3 date)) ^ ", " 
            ^ (Int.toString (#1 date))
   end

(* returns the index i where the sum of the values through i+1 exceed sum *)  
fun number_before_reaching_sum (sum : int, num_list : int list) = 
   if sum - (hd num_list) <= 0 then 0
   else 1 + number_before_reaching_sum (sum - (hd num_list), tl num_list) 

(* returns the month to which the day corresponds *) 
fun what_month (date : int) =
   let
      val month_days_list = [31,28,31,30,31,30,31,31,30,31,30,31];
   in
      1 + number_before_reaching_sum(date, month_days_list)
   end

(* returns an int list representing consecutive days from day1 through day2 
* where each value is the month of each day *)   
fun month_range (day1 : int, day2 : int) =
   if day1 > day2 then []
   else what_month(day1) :: month_range(day1 + 1, day2)   
 
(* returns the earliest date in a list of dates *)
fun oldest_helper (date_list : (int*int*int) list) =
   if null (tl date_list) then hd date_list
   else let 
      fun get_older (date1 : int*int*int, date2 : int*int*int) =
         if is_older(date1,date2) then date1
         else date2
   in
      get_older (hd date_list, oldest_helper(tl date_list))
   end

(* returns the earliest date in a list of dates with options *)
fun oldest (date_list : (int*int*int) list) =
   if null date_list then NONE 
   else SOME (oldest_helper date_list)

(* returns a list of integers, removing values equivalent to target *)    
fun remove_int_from_list (target : int, int_list : int list) = 
   if null int_list then []
   else if hd int_list = target then remove_int_from_list (target,tl int_list)
   else hd int_list :: remove_int_from_list (target,tl int_list)

(* returns an int list without duplicate values *)
fun sort_unique_values (int_list : int list) =
   if null int_list then []
   else (hd int_list) :: sort_unique_values(remove_int_from_list(hd int_list,int_list))

(* returns number of dates occuring in a list of months, duplicates ignored *)
fun number_in_months_challenge (date_list :(int*int*int) list, month_list : int list) = 
   number_in_months(date_list, sort_unique_values (month_list)) 

(* returns dates occuring in a list of months, duplicates ignored *)
fun dates_in_months_challenge (date_list :(int*int*int) list, month_list : int list) = 
   dates_in_months(date_list, sort_unique_values (month_list))

(* returns boolean value if the date is a possible date of the common era *)
fun reasonable_date ( date: int*int*int) =
   if #1 date < 1 orelse #2 date < 1 orelse #2 date > 12 orelse #3 date < 1 
   then false
   else if (#1 date) mod 4 = 0 andalso (#1 date) mod 100 <> 0 orelse (#1 date) mod 400 = 0 
         then  if (#2 date) = 2 andalso (#3 date) < 30 
               then reasonable_date (1, #2 date, 1) 
               else reasonable_date (1, #2 date, #3 date)
         else let 
            val days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31];
            fun get_int_nth (int_list : int list, n : int) =
               if n = 1 then hd int_list
               else get_int_nth (tl int_list, n - 1)
         in 
            (#3 date) <= get_int_nth (days_in_month, #2 date) 
         end
