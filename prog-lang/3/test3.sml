val long_str1_empty = longest_string1 [] = ""

val long_str1_first = longest_string1 ["lolcat","kitty","cat"] = "lolcat" andalso
                      longest_string1 ["lolcat","longer","shorty"] = "lolcat"

val long_str1_other = longest_string1 ["lolcat","longcat","shorter"] = "longcat" andalso
                      longest_string1 ["lolcat","longcat"] = "longcat" andalso
                                            longest_string1 ["a","bc","def","ghij"] = "ghij"

val long_str2_empty = longest_string2 [] = ""

val long_str2_first = longest_string2 ["lolcat","kitty","cat"] = "lolcat" andalso
                      longest_string2 ["lolcat","longer","shorty"] = "shorty"

val long_str2_other = longest_string2 ["lolcat","longcat","shorter"] = "shorter" andalso
                      longest_string2 ["lolcat","longcat"] = "longcat" andalso
                                            longest_string2 ["a","bc","def","ghij"] = "ghij"

val long_str3_empty = longest_string3 [] = ""

val long_str3_first = longest_string3 ["lolcat","kitty","cat"] = "lolcat" andalso
                      longest_string3 ["lolcat","longer","shorty"] = "lolcat"

val long_str3_other = longest_string3 ["lolcat","longcat","shorter"] = "longcat" andalso
                      longest_string3 ["lolcat","longcat"] = "longcat" andalso
                                            longest_string3 ["a","bc","def","ghij"] = "ghij"

val long_str4_empty = longest_string4 [] = ""

val long_str4_first = longest_string4 ["lolcat","kitty","cat"] = "lolcat" andalso
                      longest_string4 ["lolcat","longer","shorty"] = "shorty"

val long_str4_other = longest_string4 ["lolcat","longcat","shorter"] = "shorter" andalso
                      longest_string4 ["lolcat","longcat"] = "longcat" andalso
                                            longest_string4 ["a","bc","def","ghij"] = "ghij"
