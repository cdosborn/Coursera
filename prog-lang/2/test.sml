use "hw2.sml";

"function test for all_except_option:";
all_except_option("front",["front","end"]) = SOME ["end"];
all_except_option("end",["front","end"]) = SOME ["front"];
all_except_option("not in list",["front","end"]) = NONE;
all_except_option("not in list",[]) = NONE;

"function test for get_substitutions1:";
get_substitutions1([["a","b","c"],["d","e","a"]],"a") = ["b","c","d","e"];
get_substitutions1([["a","a","a"],["d","e","a"]],"a") = ["a","a","d","e"];
get_substitutions1([[],["d","e","a"]],"a") = ["d","e"];

"function test for get_substitutions2:";
get_substitutions2([["a","b","c"],["d","e","a"]],"a") = ["b","c","d","e"];
get_substitutions2([["a","a","a"],["d","e","a"]],"a") = ["a","a","d","e"];
get_substitutions2([[],["d","e","a"]],"a") = ["d","e"];

"function test for similar_names:";
similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],{first="Fred", middle="W", last="Smith"}) =
      [{first="Fred", last="Smith", middle="W"},{first="Fredrick", last="Smith", middle="W"},{first="Freddie", last="Smith", middle="W"},
      {first="F", last="Smith", middle="W"}];
similar_names([],{first="Connor", middle="D", last="Osborn"}) = [{first="Connor", middle="D", last="Osborn"}];

"function test for card_color:";
card_color(Spades, Num 4) = Black;
card_color(Hearts, Num 4) = Red;
card_color(Diamonds, Ace) = Red;

card_color2(Spades, Num 4) = Black;
card_color2(Hearts, Num 4) = Red;
card_color2(Diamonds, Ace) = Red;

"function test for card_value:";
card_value(Clubs,Jack) = 10;
card_value(Clubs,King) = 10;
card_value(Clubs,Ace) = 11;
card_value(Clubs,Num 2) = 2;

"function test for remove_card:";
remove_card([(Hearts, Num 3),(Spades, Jack), (Diamonds, Ace), (Hearts, Num 3)], (Hearts, Num 3), IllegalMove) = 
      [(Spades, Jack), (Diamonds, Ace), (Hearts, Num 3)];
(*remove_card([(Clubs, Num 5)],(Hearts, Jack), IllegalMove);
remove_card([],(Hearts, Jack), IllegalMove);
*)
"function test for all_same_color:";
all_same_color([(Clubs,Jack),(Spades,Jack)]) = true;
all_same_color([(Clubs,Jack),(Hearts,Jack)]) = false;
all_same_color([]) = true;

"function test for sum_cards:";
sum_cards([(Clubs, Jack),(Clubs, Num 2)]) = 12;
sum_cards([]) = 0;

"function test for score:";
score([(Clubs,Jack),(Clubs, Num 2)], 30) = 9;
score([(Clubs,Jack),(Diamonds, Num 2)], 30) = 18;
score([(Clubs,Jack),(Clubs, Num 2)], 5) = 10;
score([(Clubs,Jack),(Diamonds, Num 2)], 5) = 21;
score([(Diamonds,Num 8)],8) = 0;

"function test for officiate:";
officiate([(Clubs, Jack),(Hearts, Num 1000),(Clubs, Num 2)],[Draw, Draw],10) = 3000;
officiate([(Clubs, Jack),(Hearts, Num 1),(Clubs, Num 2)],[Draw, Draw, Draw, Discard (Hearts, Num 1)], 17) = 2;
officiate([],[],100) = 50;

"function test for score_challenge:";
score_challenge([(Clubs, Ace),(Clubs, Ace),(Clubs, Ace)],3) = 0;
score_challenge([(Clubs, Ace),(Clubs, Ace),(Clubs, Ace)],23) = 0;
score_challenge([(Clubs, Ace),(Clubs, Ace),(Clubs, Ace)],33) = 0;

"function test for officiate_challenge:";
officiate_challenge([(Clubs,Ace),(Clubs,Ace)],[Draw,Draw,Draw,Draw],12) = 0;
officiate_challenge([],[Draw,Draw],24) = 12;
officiate_challenge([],[],33) = 16;
officiate_challenge([(Clubs,Ace),(Clubs,Ace),(Clubs,Jack)], [Draw,Draw,Draw],22) = 0;
officiate_challenge([], [Draw,Draw,Draw],22) = 11;
"function test for careful_player:";
careful_player([(Clubs,Num 2)],0) = [];
careful_player([(Clubs,Ace),(Clubs,Jack)],12) = [Draw];
careful_player([(Clubs,Num 2),(Clubs,Num 2)],4) = [Draw,Draw]; 
careful_player([(Clubs,Num 1),(Clubs,Num 3),(Clubs,Num 4)], 5) = [Draw,Draw,Discard (Clubs, Num 3),Draw];
