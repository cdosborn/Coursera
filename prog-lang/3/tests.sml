use "hw3provided.sml";

"only_capitals";
only_capitals(["A","b","C"]) = ["A","C"];
only_capitals(["A"]) = ["A"];
only_capitals(["a"]) = [];

"longest_string1";
longest_string1(["s","med","longest"]) = "longest";
longest_string1([]) = "";
longest_string1([""]) = "";
longest_string1(["a","b"]) = "a";

"longest_string2";
longest_string2(["a","b"]) = "b";

"longest_string_helper";
longest_string_helper (fn (x,y) => y mod x = 2) ["4444","22"] = "22";

"longest_capitalized";
longest_capitalized [] = "";
longest_capitalized ["adfadsfas", "Be"] = "Be";
longest_capitalized ["long","LONGER"] = "LONGER";

"rev_string";
rev_string "racecar" = "racecar";
rev_string "boy" = "yob";
rev_string "" = "";
rev_string "AAaa" = "aaAA";

"first_answer";
first_answer (fn a => if (a + 1) mod 2 = 0 then SOME a else NONE) [2,4,6,8,7] = 7;
first_answer (fn a => case a of UnitP => SOME a | _ => NONE) [ConstP 3, ConstP 1, UnitP] = UnitP;

"all_answers";
all_answers (fn a => if (a + 1) mod 2 = 0 then SOME [a] else NONE) [1,3,5,7] = SOME [7,5,3,1];
all_answers (fn a => if (a + 1) mod 2 = 0 then SOME [a] else NONE) [1,3,5,7,8] = NONE;
all_answers (fn a => case a of UnitP => SOME [a] | _ => NONE) [UnitP] = SOME [UnitP];
all_answers (fn a => case a of UnitP => SOME [a] | _ => NONE) [] = SOME [];

"count_wildcards";
count_wildcards (Variable "boy") = 0;
count_wildcards (TupleP([Wildcard])) = 1;
count_wildcards (TupleP([Wildcard, Wildcard,Variable "boy", UnitP, Wildcard])) = 3;

"count_wild_and_variable_lengths";
count_wild_and_variable_lengths (Variable "boy") = 3;
count_wild_and_variable_lengths (TupleP([Wildcard])) = 1;
count_wild_and_variable_lengths (TupleP([Wildcard, Wildcard,Variable "boy", UnitP, Wildcard])) = 6;

"count_some_var";
count_some_var ("a", UnitP) = 0;
count_some_var ("a", TupleP([TupleP([Variable "a"]), Variable "a"])) = 2;

"check_pat";
check_pat UnitP = true;
check_pat (TupleP([UnitP,Variable "a", TupleP([Variable "a"])])) = false;
check_pat (TupleP([UnitP,Variable "a", TupleP([Variable "b"])])) = true;

"match";
match (Const 5, Variable "baby") = SOME [("baby", Const 5)];
match (Unit, UnitP) = SOME [];
match (Tuple ([Unit,Unit]), TupleP ([UnitP,UnitP])) = SOME [];
match (Tuple([Unit]), TupleP([ConstP 7])) = NONE;

"first_match";
first_match (Unit, [Variable "baby", UnitP]) = SOME [("baby", Unit)];
first_match (Tuple ([Unit]), [TupleP([]), TupleP([UnitP])])= SOME [];
first_match (Tuple ([Unit]), [TupleP([])]) = NONE;
