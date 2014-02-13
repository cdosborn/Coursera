(* Coursera Programming Languages, Homework 2, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
fun only_capitals str_lst = List.filter (fn l => Char.isUpper(String.sub(l,0))) str_lst
fun longest_string1 str_lst = List.foldl (fn (str, init) => if String.size init >= String.size str then init else str) "" str_lst  
fun longest_string2 str_lst = List.foldl (fn (str, init) => if String.size init > String.size str then init else str) "" str_lst
fun longest_string_helper f =  List.foldl (fn (str, init) => if f(String.size str, String.size init) then str else init) "" 
val longest_string3 = longest_string_helper (fn (x,y) => x >= y) 
val longest_string4 = longest_string_helper (fn (x,y) => x > y)
val longest_capitalized = (longest_string1 o only_capitals) 
fun rev_string str = (String.implode o List.rev o String.explode) str

fun first_answer f a_list = 
   case a_list of
        [] => raise NoAnswer
      | l::l' => case f(l) of
                      SOME v => v
                    | NONE => first_answer f l'

fun all_answers f a_list = 
   let fun aux (lst, acc) =
      case lst of
           [] => SOME acc
         | l::l' => case f(l) of
                         NONE => NONE
                       | SOME l => aux(l',l @ acc)
   in aux(a_list,[])
   end

fun count_wildcards pat = g(fn _ => 1) (fn _ => 0) pat

fun count_wild_and_variable_lengths pat =
   g (fn _ => 1)(fn name => String.size name) pat

fun count_some_var (str, pat) =
   case (str, pat) of
        (str, Variable str') => if str = str' then 1 else 0
      | (_, TupleP pat_list) => foldl (fn (new, old) => count_some_var (str, new) + old) 0 pat_list
      | _ => 0 

fun check_pat pat =
   let fun pat_to_str_list pat =
      case pat of
           Variable str => [str]
         | ConstructorP (str,pat) => pat_to_str_list pat
         | TupleP lst => List.foldl(fn(new, old) => old @ pat_to_str_list(new)) [] lst
         | _ => []

      fun unique_str_list lst =
         case lst of
              [] => true
            | l::l' => if List.all(fn str => str <> l) l'
                       then unique_str_list l'
                       else false
   in (unique_str_list o pat_to_str_list) pat 
   end 

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

		
  
fun match (v, p) =
   case (v, p) of 
        (_, Wildcard) => SOME [] 
      | (v, Variable s) => SOME [(s,v)]        
      | (Const i, ConstP i') => if i=i' then SOME [] else NONE
      | (Unit,UnitP) => SOME []
      | (Constructor (s,v),ConstructorP (s',p')) => if (s = s') then match (v,p') else NONE
      | (Tuple lst, TupleP lst') => if List.length lst = List.length lst' 
                                    then all_answers (fn (next) => match next) (ListPair.zip (lst,lst'))
                                    else NONE
      | _ => NONE 

fun first_match v plist =
   SOME(first_answer (fn p => match(v,p)) plist) handle NoAnswer => NONE
                              
fun all_answers2 f a_list b_list= 
   let fun aux (lst, acc) =
      case lst of
           [] => SOME acc
         | l::l' => case f(l, b_list) of
                         NONE => NONE
                       | SOME l => aux(l',l :: acc)
   in aux(a_list,[])
   end

fun all_answers3 f a_list = 
   let fun aux (lst, acc) =
      case lst of
           [] => SOME acc
         | l::l' => case f(l) of
                         NONE => NONE
                       | SOME l => aux(l',l :: acc)
   in aux(a_list,[])
   end

fun get_lenient_type (t1,t2) =
   case (t1,t2) of
        (t1,Anything) => SOME t1
      | (Anything,t2) => SOME t2
      | (IntT,IntT) => SOME IntT
      | (UnitT,UnitT) => SOME UnitT
      | (TupleT t, TupleT t') => (case (all_answers3 (fn (next) => get_lenient_type next) (ListPair.zip (t,t'))) of NONE => NONE | SOME l => SOME (TupleT (l)) ) 
      | (Datatype s, Datatype s') => if s=s' then SOME (Datatype s) else NONE
      | _ => NONE

fun get_option_type (pat, constructor_list) =
   case pat of
        Wildcard => SOME Anything
      | Variable s  => SOME Anything
      | ConstP i => SOME IntT
      | UnitP => SOME UnitT 
      | TupleP (p_list) => (case (all_answers2 get_option_type p_list constructor_list) of
                              SOME l => SOME (TupleT (l))
                            | NONE => NONE) 
      | ConstructorP (str,p) => let fun match_constructor (c_list, conP) =
                                    case (c_list, conP) of 
                                         ([],_) => NONE 
                                       | ((a,b,c)::l',(str,p)) => if str = a then case get_option_type(p, c_list) of
                                                                             SOME t => (case get_lenient_type(c,t) of
                                                                                            SOME t => SOME (Datatype b)
                                                                                          | NONE => match_constructor (l', conP))
                                                                           | NONE => NONE
                                               else match_constructor (l', conP)
                                in match_constructor (constructor_list, (str,p) )
                                end

fun compress (lst) = 
   case lst of
        [] => NONE 
      | t::[] => SOME t 
      | t1::t2::ts => (case get_lenient_type (t1,t2) of NONE => NONE | SOME t => compress (t::ts) )

fun typecheck_patterns (data_list, pat_list) = let
   val type_list = all_answers2 get_option_type pat_list data_list
in case type_list of
        NONE => NONE 
      | SOME lst => compress(lst) 
end
