
rt ^ "
val _ = let
       (* utility *)
           fun printResults(results) = foldl (fn ((module, report), _) => print(module ^ "ults
                  fun allStringsEqual str strs = foldl (fn (nextStr, allEqualSoFar) => allEqualSoFar andalso nextStr = str) true strs
                         fun onlyFailedModules results =
                                    List.map
                                                (fn (module, result) => (module, foldl (op ^) "" result))
                                                            (List.filter (fn (_, result) => (not o (allStringsEqual "")) result) results)

                                                                (* assertion framework *)
                                                                    fun assert(msg: string, e: bool) = if e then "" else "IL: " ^ msg ^ "
